#!/usr/bin/python3

"""
    This script is the main code.
    
    @author: mariannatzortzi
"""


import io
import os  
import sys
import glob
import time
import shutil
import argparse
import datetime
import numpy as np
import pandas as pd
from tqdm import tqdm
from pathlib import Path
from torch_geometric import data


import torch
import torch.nn as nn
import torch_geometric
from torch_geometric.data import Data
from torch_geometric.data import DataLoader

from pyg_crossval import create_pg_graphs 
from GTM_kfold_nwrap_nospatial import GTModel
from train_kfold_no_wrapper import train_one_epoch, evaluate_per_epoch, test_per_epoch


# GPU
#os.environ['CUDA_VISIBLE_DEVICES'] = "0"

def maincall(trainpaths, devicekernels, targetis):
    train_pg_graphs_double = []
    for i in trainpaths:
        print('*** train graphs ***')
        print(f'i is {i}')
        # Create a list of pytorch_geometric Data objects containing the kernel measurements
        devicekernels = pd.read_csv(i+'/'+f'{args.ndevice}'+'.csv')
        train_pg_graphs_sublist, max_number_nodes, max_number_edges = create_pg_graphs(i, devicekernels, targetis)#='devicetransfer')
        train_pg_graphs_double.append(train_pg_graphs_sublist)

    train_pg_graphs = [item for sublist in train_pg_graphs_double for item in sublist]
    print(f'length of train pytorch geometric graphs: {len(train_pg_graphs)}')

    # test graphs
    print('**** test graphs ****')
    devicekernels = pd.read_csv(args.scaled_testfolder_device)
    test_pg_graphs, max_number_nodes, max_number_edges = create_pg_graphs(args.team_testfolder_device, devicekernels, targetis)#='devicetransfer')
    print(f'length of {set} pytorch geometric graphs: {len(test_pg_graphs)}')

    return train_pg_graphs, test_pg_graphs

if __name__ == '__main__':
    # Program parameters parsing
    parser = argparse.ArgumentParser(description='')
    parser.add_argument('ndevice', type=str, default='cpu', help='show me the device used for the experiments')
    parser.add_argument('num_team', type=str, default='team1', help='The team in which the current kernels belong')
    parser.add_argument('--target_is', type=str, default='devicetransfer', help='the target variable to predict each time')
    parser.add_argument('team_kfolder_device', type=str, default='/home/marianna/Documents/programl/ocludify/results/team1/kfolder_cpu', help='kfolder team path')
    parser.add_argument('team_testfolder_device', type=str, default='/home/marianna/Documents/programl/ocludify/results/team1/testfolder_cpu', help='testfolder team path')
    parser.add_argument('scaled_testfolder_device', type=str, default='/home/marianna/Documents/programl/ocludify/results/team1/scaled_testfolder_cpu.csv', help='csv for scaled testfolder')

    parser.add_argument('--epochs', type=int, default=100, help='The number of epochs to train the model for')
    parser.add_argument('--batch_size', type=int, default=32, help='batch size')
    # parser.add_argument('--pct_close', type=float, default=0.05, help='In regression problem, you have to define what a correct prediction is. You define correctness as being within a certain percentage of the true value. pct_close is the percentage.')
    #parser.add_argument('--num_layers', type=int, default=3, help='number of iterations over the neighborhood')

    parser.add_argument('experiments_path', type=str, default='/home/marianna/Documents/programl/ocludify/experiments/results', help='The path containing the experiments.')
    parser.add_argument('--dataset_name', type=str, default='fromCummins', help='name of the dataset that is used for the experiments.')

    parser.add_argument('--hidden_dim', type=int, default=64, help='Dimmension of the hidden states.')
    parser.add_argument('--heads', type=int, default=8, help='Number of attention heads')
    parser.add_argument('--num_exps', type=int, default=1, help='Number of experiments')

    parser.add_argument('--lr', type=float, default=0.001, help='learning rate')
    parser.add_argument('--patience', type=int, default=20, help='number of epochs to wait before starting lr decay (early stoppping criterion).')
    parser.add_argument('--scale_type', type=str, default='standardization', help='(or minmax) what type of feature scaling I use') 

    args = parser.parse_args() # args represents the options that we have

    # When a python script is executed with arguments,
    # it is captured by Python and stored in a list called sys.argv
    print("This is the name of the program:", sys.argv[0])
    print("Argument List:", str(sys.argv))

    #device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    #print('available device in this HW is {device}'.format(device=device))

    available_gpus = [torch.cuda.device(i) for i in range(torch.cuda.device_count())]
    print(f'available_gpus are {available_gpus}')
    
    #os.environ["CUDA_VISIBLE_DEVICES"] = "0"

    # move the .ll files from the kfolder_cpu in kfolder_cpu/llfiles
    llfiles = args.team_kfolder_device + '_llfiles'
    if not os.path.exists(llfiles):
        os.makedirs(llfiles)

    for filename in tqdm(glob.glob(os.path.join(args.team_kfolder_device, '*.ll'))):
        shutil.move(filename, llfiles)    

    # create the programl graphs for validation, trainset (kfold cross validation), and for test set.
    ifold = 0
    all_list = []
    for filename in os.listdir(args.team_kfolder_device):
        trainpaths = []
        ifold += 1
        for ff in os.listdir(args.team_kfolder_device):
            if filename == ff:
                print(f'ff is {ff}')
                print('***** validation graphs ******')
                val_path = os.path.join(args.team_kfolder_device, ff)
                print(f'the fold used for validation this time is {filename} and val_path is {val_path}')
                devicekernels = pd.read_csv(val_path+'/'+f'{args.ndevice}'+'.csv')
                validation_pg_graphs, max_number_nodes, max_number_edges = create_pg_graphs(val_path, devicekernels, args.target_is)#'devicetransfer')
                set = "validation"
                print(f'lenght of {set} pytorch geometric graphs: {len(validation_pg_graphs)}')
            else:
                trainpaths.append(os.path.join(args.team_kfolder_device, ff))
        
        train_pg_graphs, test_pg_graphs = maincall(trainpaths, devicekernels, args.target_is)

        for norm in ['None']:
            for num_layers in [1]:
                for exp in range(args.num_exps):
                    print('-------------------------')
                    print(f'Experiment {exp} with normalization type {norm} and number of layers {num_layers}')
                    print('-------------------------')

                    # model
                    model = GTModel(
                        num_layers = num_layers,
                        hidden_dim = args.hidden_dim,
                        heads = args.heads,
                        feat_dropout = 0.0,
                        top_k_pool = 5,
                        norm = norm,
                        beta = True
                    )#.to('cuda')

                    print('the device of one parameter', next(model.parameters()).device)

                    print(model)
                    # optimizer
                    optimizer = torch.optim.Adam(model.parameters(), lr=args.lr, weight_decay=0.0005)
                    if args.patience > 0:
                        scheduler = torch.optim.lr_scheduler.ReduceLROnPlateau(optimizer, mode='min', patience=args.patience, verbose=True, min_lr=0.00000001)

                    # Train
                    whole_exp_states = []
                    start_time = time.time()
                    for epoch in tqdm(range(args.epochs)):
                        state, optimizer = train_one_epoch(epoch, model, optimizer, train_pg_graphs, args.batch_size)#, args.pct_close)
                        whole_exp_states.append(state)

                        val_state = evaluate_per_epoch(epoch, model, validation_pg_graphs, args.batch_size)#, args.pct_close)
                        whole_exp_states.append(val_state)

                        # early stopping here comparing with the val loss
                    test_state = test_per_epoch(args.scale_type, args.target_is, args.num_team, args.ndevice, epoch, model, test_pg_graphs, args.batch_size)#, args.pct_close)
                    whole_exp_states.append(test_state)

                    print(f'End of experiment {exp}.')

        dict_folds = {'ifold': ifold, 'whole_exp_states': whole_exp_states}
        all_list.append(dict_folds)

    # Save the experiments 
    experiments_folder = None
    if True:
        now = time.strftime("%Y%m%d_%H%M%S")
        experiments_folder = os.path.join(args.experiments_path, args.num_team, args.dataset_name, now)
        # Create a new directory at this given path.
        Path(experiments_folder).mkdir(parents=True, exist_ok=True)

    if True:#args.save
        if norm == None:
            norm = "None"
        # A common PyTorch convention is to save models using either a .pt or .pth file extension.
        torch.save(model.state_dict(), os.path.join(experiments_folder, f'model={model.__class__.__name__}_batch={args.batch_size}_nheads={args.heads}_hdim={args.hidden_dim}_kfold={5}_lr={args.lr}.pt'))
        torch.save(all_list, os.path.join(experiments_folder, f'model={model.__class__.__name__}_norm={norm}_nlayers={num_layers}_nheads={args.heads}_hdim={args.hidden_dim}_kfold={5}.pt'))
    end_time = time.time()
    print('Total time elapsed: {:.4f}s'.format(end_time-start_time))
