#!/usr/bin/pyhon3 

"""
    This scirpt is for visualizing the compiled results

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

"""
    At first I want to count all the compiled and uncompiled kernels
    for each machine and for each device.

"""
def count_analyzed_kernels(args,expid):
    
    compilation_state = args.compilation_state
    machine = args.machine
    device = args.device
    filename = args.comp_uncomp_iled_path+f'{compilation_state}_{machine}_{device}_{expid}.csv'
    print('filename is', filename)
    kernels = pd.read_csv(filename)
    print(kernels.shape)
    return kernels.shape[0]

def visualize_compiled(args):
    """
        We want to visualize the compiled kernels based on their input/output bytes and
        on the execution time.
    """
    return

def analyze_compiled(args, expid):
    machine = args.machine
    devicename = args.devicename
    filename = args.results_path+f'results_'+f'{machine}_{devicename}_{expid}.csv'
    print(f'filename is {filename}')
    results = pd.read_csv(filename)
    print('dataset_size', results.shape[0])
    print('unique kernels', results['kernel'].nunique())
    return


if __name__ == '__main__':
    # -------- Parser arguments ---------------
    # Program parameters parsing
    parser = argparse.ArgumentParser(description='...')
    parser.add_argument('results_path', type=str, default='/home/marianna/Documents/programl/ocludify/results/')
    parser.add_argument('comp_uncomp_iled_path', type=str, default='/home/marianna/Documents/programl/ocludify/results/analyzing_compiled_uncompiled_kernels/')
    parser.add_argument('compilation_state', type=str, default='compiledkernels')
    parser.add_argument('machine', type=str, default='silver1')
    parser.add_argument('device', type=str, default='cpu')
    parser.add_argument('devicename', type=str, default='QuadroTesla')
   

    args = parser.parse_args() # args represents the options we have


    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    print('available device in this HW is {device}'.format(device=device))

    # When a python script is executed with arguments,
    # it is captured by Python and stored in a list called sys.argv. 
    print("This is the name of the program:", sys.argv[0])
    print("Argument List:", str(sys.argv))


    """
        Uncompiled and Compiled kernels
    """         
    if args.compilation_state == 'uncompiledkernels' :
    
        uncompiled_exp1 = count_analyzed_kernels(args,'exp1')
        uncompiled_exp2 = count_analyzed_kernels(args, 'exp2')

        uncompiled_total = uncompiled_exp1 + uncompiled_exp2
        print(f'show me the total number of uncompiled kernels of the runs for device {args.device} in {args.machine} machine: {uncompiled_total}')

    elif args.compilation_state == 'compiledkernels' :
        compiled_exp1 = count_analyzed_kernels(args, 'exp1')
        compiled_exp2 = count_analyzed_kernels(args, 'exp2')

        compiled_total = compiled_exp1 + compiled_exp2
        print(f'show me the total number of compiled kernels of the runs for device {args.device} in {args.machine} machine: {compiled_total}')


    """
        Results from the compiled kernels (obviously)
    """
    analyze_compiled(args, expid='exp1')
    analyze_compiled(args, expid='exp2')