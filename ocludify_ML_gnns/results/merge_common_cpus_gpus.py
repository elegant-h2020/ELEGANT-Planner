#!/usr/bin/python3

"""
    Check common kernels between cpu and gpu, from the output 
    of the check_common_values_kernels_inputbytes.py

    @author mtzortzi
"""

import os
import csv
import sys
import torch
import argparse
import pandas as pd


if __name__ == '__main__':
    # Program Parameters
    parser = argparse.ArgumentParser(description='find common kernels between cpu and gpu')
    parser.add_argument('cpu', type=str, default='/home/marianna/Documents/programl/ocludify/results/commonkernelsinputbytes_acrossmachines_cpu.csv')
    parser.add_argument('gpu', type=str, default='/home/marianna/Documents/programl/ocludify/results/commonkernelsinputbytes_acrossmachines_gpu.csv')

    args = parser.parse_args() # args represents the options we have

    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    print(f'show me the available device in this machine {device}')

    #  'command': ' '.join(sys.argv[:]),
    print("This is the name of the program:", sys.argv[0])
    print("Argument List:", str(sys.argv))

    cpu = pd.read_csv(args.cpu)
    print(f'shape of cpu dataframe is {cpu.shape}')

    gpu = pd.read_csv(args.gpu)
    print(f'shape of cpu dataframe is {gpu.shape}')

    common_columns = ['kernel', 'input_bytes']

    # Merge the DataFrames based on common values between rows
    merged_df = pd.merge(cpu, gpu, on=common_columns, how='inner', suffixes=('_cpu', '_gpu'))
    print(merged_df.head())

    # Create a list of overlapping columns
    overlapping_columns = [col for col in cpu.columns if col in gpu.columns and col not in common_columns]
    print(f'\n show me the overlapping columns {overlapping_columns} \n')

    # Initialize an empty dictionary to store the values for each column
    column_values = {}

    # Check if the overlapping columns exist in the merged dataframe
    #  The extend() method is used to append the values and indices from merged_df to the corresponding column's dictionary in column_values
    for col in overlapping_columns:
        if (col+'_cpu' in merged_df.columns):
            if col not in column_values:
                column_values[col] = {'values':[], 'indices':[], 'cpugpu':[]}
            column_values[col]['values'].extend(merged_df[col+'_cpu'])
            column_values[col]['indices'].extend(merged_df.index)
            column_values[col]['cpugpu'].extend(['cpu'] * len(merged_df))
        if (col+'_gpu' in merged_df.columns):
            if col not in column_values:
                column_values[col] = {'values':[], 'indices':[], 'cpugpu':[]}
            column_values[col]['values'].extend(merged_df[col+'_gpu'])
            column_values[col]['indices'].extend(merged_df.index)
            column_values[col]['cpugpu'].extend(['gpu'] * len(merged_df))


    # Create a new dataframe
    new_df = pd.DataFrame()

    # Iterate over the keys (column names) in column_values dictionary
    for col in column_values:
        # Get the column values and indices from column_values
        values = column_values[col]['values']
        indices = column_values[col]['indices']
        cpugpu = column_values[col]['cpugpu']


        # Create a new column in the new dataframe using the column values  
        new_df[col] = pd.Series(values, index=indices) 
        # Add 'cpugpu' column to the new dataframe
        new_df['cpugpu'] = cpugpu

    print(f'show me how many indices I have {set(indices)}')
    
    # Create empty lists for the new columns
    new_column1 = []
    new_column2 = []

    # Iterate over the list of indices and extract values from the original dataframe
    for index in indices:
        value1 = merged_df.at[index, 'kernel']
        value2 = merged_df.at[index, 'input_bytes']
        new_column1.append(value1)
        new_column2.append(value2)
    
    # Assign the new columns to the dataframe
    new_df['kernel'] = new_column1
    new_df['input_bytes'] = new_column2
    print(f'columns of new dataframe is {new_df.columns}')

    print(new_df)
    merged_df.to_csv('merged_cpu_gpu.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)
    new_df.drop_duplicates(inplace=True)
    new_df.to_csv('commonkernelsinputbytes_cpu_gpu.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)