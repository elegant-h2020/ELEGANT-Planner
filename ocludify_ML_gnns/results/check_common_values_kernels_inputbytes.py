#!/usr/bin/python3

"""
    Check the number of a kernel common for all the machines

    @author mtzortzi
"""

import io
import os 
import csv
import sys  
import torch
import argparse
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

# GPU
os.environ['CUDA_VISIBLE_DEVICES'] = "0"


# This function finds kernels across all groups created by machines
def check_common_value(df):
    grouped = df.groupby('machine')
    common_values = set(df['kernel'])  # Start with all unique values in column2
    print(f'show me how many unique kernel names we have {len(common_values)}')
    for group_name, group_df in grouped:
        common_values = common_values.intersection(set(group_df['kernel']))
        if not common_values:  # No common values left
            return []
    return list(common_values)

# Creates a dataframe out of the initial dataframe, based on the kernels common accross all groups
def create_df(commonkernels, df):
    filtered_df = df[df['kernel'].isin(commonkernels)]
    return filtered_df

def check_input_bytes(args, filtered_df):
    grouped2 = filtered_df.groupby(['kernel', 'machine'])   
    totalkernels = []
    finalbytes = []
    finalkernels = []
    count = 0
    tc = 0
    for group_name, group_df in grouped2: 
        if count == 0:
            commonvalues = set(group_df['input_bytes'])    
            print(f'\n How many unique input_bytes we have in this group name {group_name}? {len(list(commonvalues))}')
            totalkernels.append(group_name)
        else:  
            commonvalues = commonvalues.intersection(set(group_df['input_bytes']))
        
        
        if commonvalues: 
            if count != 0:
                totalkernels.append(group_name)
            if count==3:
                finalkernels.append(totalkernels)
                finalbytes.append(list(commonvalues))
                totalkernels = []
                tc += 1
                print(f'I found a kernel common across all machines, with at least one common input_byte :)')
        else:
            print(f'for the kernel {group_name[0]} I do not have common input bytes!!!')
            totalkernels = []

        count += 1

        if count == args.machines:
            count = 0

    print(f'how many times did I find kernels with common input bytes across all machines? {tc}')
    print(f'finaltotalkernels {len(finalkernels)} {finalkernels}')
    return finalbytes, finalkernels

# Creates a dataframe out of the initial dataframe, based on the kernels and bytes that are common accross all groups
"""
    The list_of_kernelsbytes list contains tuples representing the conditions. Each tuple consists of values for the 'kernel' and 'input_bytes' columns.
    The new dataframe new_df is created using the isin() method with multiple conditions. The first condition checks if the 'kernel' column values are in the list of kernels from the tuples, 
    and the second condition checks if the 'input_bytes' column values are in the list of input_bytes from the tuples.
"""
def create_final_df(filtered_df, finalkernels, finalbytes):
    uniquefinalkernels = [sublist[0][0] for sublist in finalkernels]
    print(f'uniquefinalkernels {uniquefinalkernels} \n')
    # Extract the new dataframe based on the conditions
    list_of_kernelsbytes = list(zip(uniquefinalkernels,finalbytes))
    print(f'list of tuples kernelsbytes {list_of_kernelsbytes} \n')
    conditions = [list(t) for t in list_of_kernelsbytes]
    print(f'*Conditions: {conditions} \n')
    # Extract the values from the nested list into separate lists
    dflist = []
    for sublist in conditions:
        print(sublist)
        dflist.append(filtered_df[((filtered_df['kernel']==sublist[0]) & (filtered_df['input_bytes'].isin(sublist[1])))])
    combined_df = pd.concat(dflist)

    return combined_df



if __name__ == '__main__':
    # Program Parameters
    parser = argparse.ArgumentParser(description='finds a kernel common across all machines, with at least one common input byte')
    parser.add_argument('device', type=str, default='cpu', help='show me the device used for the experiments')
    parser.add_argument('csv_path', type=str, default='/home/marianna/Documents/programl/ocludify/results/final_cpu.csv')
    parser.add_argument('machines', type=int, default=4, help='it is the number of machines that we have')

    args = parser.parse_args() # args represents the options we have

    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    print(f'show me the available device in this machine {device}')

    df = pd.read_csv(args.csv_path)
    print(df.head(2))

    # Find common values of 'kernel' across all groups created by 'machine'
    commonkernels = check_common_value(df)
    print(f'\n commonkernels across the 4 machine runs are {len(commonkernels)} and {commonkernels} \n')

    filtered_df = create_df(commonkernels, df)
    print(f'\n print the shape of the new dataframe: {filtered_df.shape} \n')

    # save filtered dataframe
    filtered_df.to_csv('commonkernels'+'_'+'acrossmachines_'+f'{args.device}.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)

    finalbytes, finalkernels = check_input_bytes(args, filtered_df)
    print(f'final bytes and final kernels that are common across the {args.machines} machines: {len(finalbytes)} \n {finalbytes}')

    finaldf = create_final_df(filtered_df, finalkernels, finalbytes)
    # save 
    finaldf.to_csv('commonkernelsinputbytes'+'_'+'acrossmachines_'+f'{args.device}.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)