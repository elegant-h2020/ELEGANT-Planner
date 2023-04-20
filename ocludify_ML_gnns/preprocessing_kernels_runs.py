#!/usr/bin/python3

"""
    Preprocessing script
    
    @author mtzortzi
"""

import io
import os
import csv
import sys
import glob
import torch
import argparse
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# GPU
os.environ['CUDA_VISIBLE_DEVICES'] = "0"

"""
    This function is for separating the csv results file of gold2, 
    into gold2_gpu, and gold2_cpu
"""
def separate_gold2(args, expid):
    gold2_all = pd.read_csv(args.gold2_path + "results_gold2_GeForceGTX_IntelXeonCPU_" + expid +".csv")
    gold2_gpu = gold2_all[gold2_all['device'] == 'GeForceGTX']
    gold2_cpu = gold2_all[gold2_all['device'] == 'IntelXeonCPU']
    return gold2_gpu, gold2_cpu


# This function is for merging the input csv
def df_merger(args, path, gold2_device_exp1, gold2_device_exp2):
    all_files = glob.glob(path + "/*.csv")

    gold2_device_exp1['machine'] = 'gold2'
    print(f'shape of gold2 is {gold2_device_exp1.shape}')
    gold2_device_exp2['machine'] = 'gold2'
    print(f'shape of gold2 is {gold2_device_exp2.shape}')
    
    li = [gold2_device_exp1, gold2_device_exp2]
    for filename in all_files:
        name = filename.split('_')[1]
        df = pd.read_csv(filename)
        df['machine'] = name
        print(f'shape of {name} is {df.shape}')
        li.append(df)

    df_all = pd.concat(li, axis=0, ignore_index=True)

    return df_all


def is_unique(s):
    a = s.to_numpy() # s.values 
    return (a[0] == a).all()

def remove_initialization_kernels(args, df):
    # group the data on kernel and on device value
    gp = df.groupby(['kernel', 'device'])

    counter = 0
    init_kernels = []
    for name, groupkernel in gp:
    
        kernelname = groupkernel['kernel']
        inputbytes = groupkernel['input_bytes']
        # if inputbytes.any() == 0, or if inputbytes is a constant number and the runs of the kernel > 1 this is an initialization kernel
        if is_unique(inputbytes) and len(groupkernel) != 1:
            counter += 1
            init_kernels.append(kernelname.values[0])
            # print(f'kernelname is {kernelname.values[0]}')
    print(f'counter is {counter}')
    df_clean = df[df.kernel.isin(init_kernels) == False]

    return df_clean


def keep_essentials(df):
    final_df = df.filter(items=['kernel', 'gsize', 'device', 'input_bytes', 'output_bytes', 'device_mean', 'transfer_mean', 'machine', 'hostcode_mean'])
    final_df['devicetransfer'] = final_df.device_mean + final_df.transfer_mean
    return final_df


if __name__ == '__main__':
    # Program parameters parsing
    parser = argparse.ArgumentParser(description='Preprocessing kernels and runs')
    parser.add_argument('gold2_path', type=str, default='/home/marianna/Documents/programl/ocludify/results/gpu_cpu_together')
    parser.add_argument('cpu_csv_path', type=str, default='/home/marianna/Documents/programl/ocludify/results/cpu')
    parser.add_argument('gpu_csv_path', type=str, default='/home/marianna/Documents/programl/ocludify/results/gpu')

    args = parser.parse_args() # args represents the options we have

    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    print('available device in this HW is {device}'.format(device=device))

    # When a python script is executed with arguments,
    # it is captured by Python and stored in a list called sys.argv
    print("This is the name of the program:", sys.argv[0])
    print("Argument List:", str(sys.argv))


    gold2_gpu_exp1, gold2_cpu_exp1 = separate_gold2(args, expid='exp1')
    gold2_gpu_exp2, gold2_cpu_exp2 = separate_gold2(args, expid='exp2')

    # gpu
    print(f'######## GPU #########')
    df_all_gpu = df_merger(args, args.gpu_csv_path, gold2_gpu_exp1, gold2_gpu_exp2)
    print(f'shape of all the gpu dataset is: {df_all_gpu.shape}')
    print(f'unique kernels in the gpu dataset are: {df_all_gpu.kernel.nunique()}')
    df_all_gpu.to_csv('results/allgpu_init.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)
    
    df_gpu_clean = remove_initialization_kernels(args, df_all_gpu)
    print(f'shape of the cleaned gpu dataset is: {df_gpu_clean.shape}')
    print(f'unique kernels in the clean gpu dataset are: {df_gpu_clean.kernel.nunique()}')
    df_gpu_clean.to_csv('results/clean_gpu.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)
    
    final_gpu = keep_essentials(df_gpu_clean)
    final_gpu.to_csv('results/final_gpu.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)


    # cpu
    print(f'\n ######## CPU ########')
    df_all_cpu = df_merger(args, args.cpu_csv_path, gold2_cpu_exp1, gold2_cpu_exp2)
    print(f'shape of all the cpu dataset is: {df_all_cpu.shape}')
    print(f'unique kernels in the cpu dataset are: {df_all_cpu.kernel.nunique()}')
    df_all_cpu.to_csv('results/allcpu_init.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)

    df_cpu_clean = remove_initialization_kernels(args, df_all_cpu)
    print(f'shape of the cleaned cpu dataset is: {df_cpu_clean.shape}')
    print(f'unique kernels in the clean cpu dataset are: {df_cpu_clean.kernel.nunique()}')
    df_cpu_clean.to_csv('results/clean_cpu.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)

    final_cpu = keep_essentials(df_cpu_clean)
    final_cpu.to_csv('results/final_cpu.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)