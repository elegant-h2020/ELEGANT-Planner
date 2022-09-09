#!/usr/bin/python3

"""
    This script: 
                - splits the kernel_measurements.csv into two parts, one for CPU, and one for GPU.
                - for each one of the above groups keeps randomly 
                                                                    10% as test set (based on rows-kernelnames)
                                                                    90% rest as trainval set in which cross-validation will be applied 
                - takes the 90% splits it into k parts
                - gives the corresponding ir files for all the splits and creates the new ir files, test_ir, trainval_folds (k1, k2, k3, k4, k5)
                                                                                            
    @author: mariannatzortzi
"""

import io
import os
import glob
import shutil
import parser
import random
import argparse
import numpy as np
import pandas as pd
from tqdm import tqdm

def makedirectories(args):
    # cpu
    if not os.path.exists(args.k1_cpu):
        os.makedirs(args.k1_cpu)

    if not os.path.exists(args.k2_cpu):
        os.makedirs(args.k2_cpu)

    if not os.path.exists(args.k3_cpu):
        os.makedirs(args.k3_cpu)
 
    if not os.path.exists(args.k4_cpu):
        os.makedirs(args.k4_cpu)
 
    if not os.path.exists(args.k5_cpu):
        os.makedirs(args.k5_cpu)

    # gpu
    if not os.path.exists(args.k1_gpu):
        os.makedirs(args.k1_gpu)
 
    if not os.path.exists(args.k2_gpu):
        os.makedirs(args.k2_gpu)
 
    if not os.path.exists(args.k3_gpu):
        os.makedirs(args.k3_gpu)
 
    if not os.path.exists(args.k4_gpu):
        os.makedirs(args.k4_gpu)
 
    if not os.path.exists(args.k5_gpu):
        os.makedirs(args.k5_gpu)

    return

def split_on_device(args):
    measurements_df = pd.read_csv(io.open(args.final_kernel_measurements))
    cpu_measurements = measurements_df[measurements_df['Device'] == 'CPU']
    gpu_measurements = measurements_df[measurements_df['Device'] == 'GPU']
    return cpu_measurements, gpu_measurements


def random_test_trainval_on_rows(d_measurements):
    # Randomly sample 10% of your dataframe
    df_test = d_measurements.sample(frac=0.1)
    df_trainval = d_measurements.sample(frac=0.9)
    return df_test, df_trainval


def kfolds_split(df_trainval):
    shuffled = df_trainval.sample(frac=1) # sample(frac=1) shuffle the rows of df
    k1, k2, k3, k4, k5 = np.array_split(shuffled, 5) # np.array_split split it into parts that have equal size
    #print(f'k1 is {k1.shape}, k2 {k2.shape}')
    return k1, k2, k3, k4, k5


def split_files(args, kernelsdf, pathfile):
    for filename in tqdm(glob.glob(os.path.join(args.final_ir_path, '*.ll'))):
        llname = filename.split('/')[-1]
        # If I have measurements for this llname kernel  
        if kernelsdf['Kernel'].str.contains(llname).any():
            shutil.copy(filename, pathfile)
    return 

if __name__ == '__main__':
    
    # Program parameters parsing
    parser = argparse.ArgumentParser(description='Reads two paths of llvm ir files and measurements of opencl kernels and return the csv and the file of llvm ir codes updated with the intersection of the kernels between them.')
    parser.add_argument('final_kernel_measurements', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/kernel_measurements.csv')    
    parser.add_argument('final_ir_path', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/ir', help='The path containing the final llvmir code after the filtering of the common kernels.')

    parser.add_argument('test_path', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/test_path', help='The test dataset')
    parser.add_argument('test_cpu', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/test_path/cpu', help='The test dataset')
    parser.add_argument('test_gpu', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/test_path/gpu', help='The test dataset')
 
    parser.add_argument('kfolder_path', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/kfolder', help='kfolder')
    parser.add_argument('kfolder_cpu', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/kfolder/cpu', help='kfolder')
    parser.add_argument('kfolder_gpu', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/kfolder/gpu', help='kfolder')

    parser.add_argument('k1_cpu', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/kfolder/cpu/k1', help='k1 fold')
    parser.add_argument('k2_cpu', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/kfolder/cpu/k2', help='k2 fold')
    parser.add_argument('k3_cpu', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/kfolder/cpu/k3', help='k3 fold')
    parser.add_argument('k4_cpu', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/kfolder/cpu/k4', help='k4 fold')
    parser.add_argument('k5_cpu', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/kfolder/cpu/k5', help='k5 fold')

    parser.add_argument('k1_gpu', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/kfolder/gpu/k1', help='k1 fold')
    parser.add_argument('k2_gpu', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/kfolder/gpu/k2', help='k2 fold')
    parser.add_argument('k3_gpu', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/kfolder/gpu/k3', help='k3 fold')
    parser.add_argument('k4_gpu', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/kfolder/gpu/k4', help='k4 fold')
    parser.add_argument('k5_gpu', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/kfolder/gpu/k5', help='k5 fold')


    args = parser.parse_args() # args respresents the options we have

    if not os.path.exists(args.kfolder_path):
        os.makedirs(args.kfolder_path)

    if not os.path.exists(args.kfolder_cpu):
        os.makedirs(args.kfolder_cpu)

    if not os.path.exists(args.kfolder_gpu):
        os.makedirs(args.kfolder_gpu)

    if not os.path.exists(args.test_path):
        os.makedirs(args.test_path)

    if not os.path.exists(args.test_cpu):
        os.makedirs(args.test_cpu)

    if not os.path.exists(args.test_gpu):
        os.makedirs(args.test_gpu)

    if not os.path.exists(args.k1_gpu):
        os.makedirs(args.k1_gpu)
    makedirectories(args)

    cpu_measurements, gpu_measurements = split_on_device(args)
    cpu_test_df, cpu_trainval = random_test_trainval_on_rows(cpu_measurements)
    gpu_test_df, gpu_trainval = random_test_trainval_on_rows(gpu_measurements)
    k1cpu_df, k2cpu_df, k3cpu_df, k4cpu_df, k5cpu_df = kfolds_split(cpu_trainval)
    k1gpu_df, k2gpu_df, k3gpu_df, k4gpu_df, k5gpu_df = kfolds_split(gpu_trainval)
   

    split_files(args, cpu_test_df, args.test_cpu)
    split_files(args, k1cpu_df, args.k1_cpu)
    split_files(args, k2cpu_df, args.k2_cpu)
    split_files(args, k3cpu_df, args.k3_cpu)
    split_files(args, k4cpu_df, args.k4_cpu)
    split_files(args, k5cpu_df, args.k5_cpu)


    # gpu
    split_files(args, gpu_test_df, args.test_gpu)
    split_files(args, k1gpu_df, args.k1_gpu)
    split_files(args, k2gpu_df, args.k2_gpu)
    split_files(args, k3gpu_df, args.k3_gpu)
    split_files(args, k4gpu_df, args.k4_gpu)
    split_files(args, k5gpu_df, args.k5_gpu)
