#!/usr/bin/python3

"""

    This script reads results.csv from the different runs,
    and returns which kernels are compiled and which are not,
    in the form of two dataframes converted into csv.

    @author mtzortzi

"""
import os
import csv
import sys
import argparse
import pandas as pd

import torch


def maincall(args):
    
    # csv from results running in machine
    results = pd.read_csv(args.results_csvpath)
    print(results.head())

    # give me the array of unique elements based on the kernel name
    compiled_kernels = results['kernel'].unique()
    print(f'these are the {compiled_kernels}, and is of type {type(compiled_kernels)}')
    print(f'the number of unique compiled kernels is {len(compiled_kernels)}')

    # initial dataset from benchmarks_config
    dataset_init = pd.read_csv(args.initialdataset_csvpath)
    print('initial dataset from config', dataset_init.shape)

    # the compiled kernels will be the kernels that we have results.csv (we keep the unique kernels - one kernel has many runs)
    newdf = dataset_init.loc[dataset_init['benchmark'].isin(compiled_kernels)]
    print('compiled kernels', newdf.shape)

    # the uncompiled kernels are those that don't exist inside the results.csv (so inside the compiled_kernels array)
    uncompiledkernels = dataset_init.loc[~dataset_init['benchmark'].isin(compiled_kernels)]
    print('uncompiled kernels', uncompiledkernels.shape)

    return newdf, uncompiledkernels


if __name__ == '__main__':

    #----------- Parser arguments ----------
    # Program parameters parsing
    parser = argparse.ArgumentParser(description='Reads two csv and returns one csv with the compiled kernels and one with the uncompiled kernels?')
    parser.add_argument('results_csvpath', type=str, default='/home/marianna/Documents/programl/ocludify/results_silver1_Tesla_exp1.csv', help='The results path to be checked' )
    parser.add_argument('initialdataset_csvpath', type=str, default='/home/marianna/Documents/programl/ocludify/benchmarks_config.csv')
    parser.add_argument('machine', type=str, default='silver1', help='The name of the machine')
    parser.add_argument('device', type=str, default='gpu', help='What device we use.')
    parser.add_argument('experiment', type=str, default='exp1', help='The number of the experiment category')

    args = parser.parse_args() # args represents the options we have

    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    print('available device in this HW is {device}'.format(device=device))

    #  'command': ' '.join(sys.argv[:]),
    print("This is the name of the program:", sys.argv[0])
    print("Argument List:", str(sys.argv))

    newdf, uncompiledkernels =  maincall(args)

    machine = args.machine
    device = args.device
    experiment = args.experiment

    # checking if directory exists or not.
    path = 'results/analyzing_compiled_uncompiled_kernels/'
    if not os.path.exists(path):
        # if the folder directory is not present, then create it.
        os.makedirs(path)
    
    newdf.to_csv(path+f'compiledkernels_{machine}_{device}_{experiment}.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)
    uncompiledkernels.to_csv(path+f'uncompiledkernels_{machine}_{device}_{experiment}.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)