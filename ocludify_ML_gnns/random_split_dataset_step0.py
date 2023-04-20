#!/usr/bin/python3

"""
    Randomly split the dataset based on unique kernels
    and for each machine.
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

# GPU
os.environ['CUDA_VISIBLE_DEVICES'] = "0"


"""
    team1 consists of silver1 (Tesla 2018, cpu 2017) and epyc7 (A100 2020, cpu 2019)
    team2 consists of gold2 (GeForce 2018, cpu 2017) and dungani (Quadro 2015, Tesla 2013, cpu 2013)
"""

def split_based_on_machines(args):
    final_df = pd.read_csv(args.final_csv)

    silver1 = final_df[final_df.machine == 'silver1']
    gold2 = final_df[final_df.machine == 'gold2']
    epyc7 = final_df[final_df.machine == 'epyc7']
    dungani = final_df[final_df.machine == 'dungani']

    silver1_unkernels = silver1.kernel.nunique()
    gold2_unkernels = gold2.kernel.nunique()
    epyc7_unkernels = epyc7.kernel.nunique()
    dungani_kernels = dungani.kernel.nunique()

    print(silver1_unkernels, gold2_unkernels, epyc7_unkernels, dungani_kernels)
    print(silver1.shape, gold2.shape, epyc7.shape, dungani.shape)

    team1 = final_df[(final_df.machine == 'silver1') | (final_df.machine == 'epyc7')]
    team2 = final_df[(final_df.machine == 'dungani') | (final_df.machine == 'gold2')]

    return team1, team2, silver1, gold2, epyc7, dungani



if __name__ == '__main__':
    # Program parameters parsing
    parser = argparse.ArgumentParser(description='Splitting the dataset')
    parser.add_argument('device', type=str, default='cpu', help='show me the device used for the experiments')
    parser.add_argument('final_csv', type=str, default='/home/marianna/Documents/programl/ocludify/results/final_cpu.csv', help='final cpu or gpu')
    # team1 folders
    parser.add_argument('team1_path', type=str, default='/home/marianna/Documents/programl/ocludify/results/team1', help='team1 path')
    # team2 folders
    parser.add_argument('team2_path', type=str, default='/home/marianna/Documents/programl/ocludify/results/team2', help='team2 path')
    
    args = parser.parse_args() # args represents the options that we have

    # When a python script is executed with arguments,
    # it is captured by Python and stored in a list called sys.argv
    print("This is the name of the program:", sys.argv[0])
    print("Argument List:", str(sys.argv))

    if not os.path.exists(args.team1_path):
        os.makedirs(args.team1_path)

    if not os.path.exists(args.team2_path):
        os.makedirs(args.team2_path)

    team1, team2, silver1, gold2, epyc7, dungani = split_based_on_machines(args)

    if args.device == 'cpu':
        team1['#device'] = 0
        team2['#device'] = 0
    else:
        team1['#device'] = 1
        team2['#device'] = 1

    print(f'unique kernels for team1 {team1.kernel.nunique()}, with total runs {team1.shape}')
    team1.to_csv(args.team1_path+'/'+f'team1_{args.device}.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)
    
    print(f'unique kernels for team2 {team2.kernel.nunique()}, with total runs {team2.shape}')
    team2.to_csv(args.team2_path+'/'+f'team2_{args.device}.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)