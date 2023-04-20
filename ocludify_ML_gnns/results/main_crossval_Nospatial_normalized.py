#!/usr/bin/python3

"""
    This script is the main code, with which I call ...
    
    @author: mariannatzortzi
"""


import io
import os  
import sys
import glob
import time
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


from pyg_crossval import create_pg_graphs, feature_scale, scaling
from train_crossval_no_wrapper_l1lossmean_with_standardization import train_one_epoch, evaluate_per_epoch, test_per_epoch, test_per_epoch_minmax
#from GTM_crossval_NOwrapper_nospatialencoding import GTModel
from GTMcrossval_nwrap_nospatial_newparametrized import GTModel


#GPU
os.environ['CUDA_VISIBLE_DEVICES'] ="0"


def maincall(trainpaths, devicekernels, args):
    train_pg_graphs_double = []
    for i in trainpaths:
        print('*** train graphs ***')
        print(f'i is {i}')
        # Create a list of pytorch_geometric Data objects containing the kernel measurements    

        if args.devicedataset == 'CPU':
            devicekernels = pd.read_csv(i+'/cpu.csv')
            # devicekernels = devicekernels[devicekernels['Device'] == 0]
            scaletype = args.scale_type
            # print(f'scaling the execution and the output bytes for CPU for training')
            # devicekernels, meant, stdt, meanb, stdb = scaling(scaletype, devicekernels)
            train_pg_graphs_sublist, max_number_nodes, max_number_edges = create_pg_graphs(i, devicekernels)
            train_pg_graphs_double.append(train_pg_graphs_sublist)

        elif args.devicedataset == 'GPU':
            devicekernels = pd.read_csv(i+'/gpu.csv')
            # devicekernels = devicekernels[devicekernels['Device'] == 1]
            scaletype = args.scale_type
            # print(f'scaling the execution and the output bytes for GPU for training')
            # devicekernels, meant, stdt, meanb, stdb = scaling(scaletype, devicekernels)
            train_pg_graphs_sublist, max_number_nodes, max_number_edges = create_pg_graphs(i, devicekernels)
            train_pg_graphs_double.append(train_pg_graphs_sublist)

    train_pg_graphs = [item for sublist in train_pg_graphs_double for item in sublist]
    print(f'length of train pytorch geometric graphs: {len(train_pg_graphs)}')

    # test graphs
    print('**** test graphs ***')
    if args.devicedataset == 'CPU':
        # print(f'scaling the execution and the output bytes for CPU for testing')
        # devicekernels, meant, stdt, meanb, stdb = scaling(scaletype, devicekernels)
        devicekernels = pd.read_csv(args.test_path+'/cpu.csv')
        test_pg_graphs, max_number_nodes, max_number_edges = create_pg_graphs(path=args.test_path, kernelsdf=devicekernels)
    elif args.devicedataset == 'GPU':
        # print(f'scaling the execution and the output bytes for GPU for testing')
        # devicekernels, meant, stdt, meanb, stdb = scaling(scaletype, devicekernels)
        devicekernels = pd.read_csv(args.test_path+'/gpu.csv')
        test_pg_graphs, max_number_nodes, max_number_edges = create_pg_graphs(path=args.test_path, kernelsdf=devicekernels)
    set = "test"
    print(f'length of {set} pytorch geometric graphs: {len(test_pg_graphs)}')

    return train_pg_graphs, test_pg_graphs

if __name__ == '__main__':    

    #--------------------- Parser arguments --------------------------------------
    # Program parameters parsing
    parser = argparse.ArgumentParser(description='Reads two paths the train llvm ir files and measurements of opencl kernels and returns train pg graphs')
    parser.add_argument('-i', '--indent', type=int, default=None, help='If set to a non-negative integer, then json array elements and object members will be pretty-printed with that indent level. An indent level of 0 or negative, will only insert newlines. The default value (None) selects the most compact representation.')
    parser.add_argument('kfolder_path', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/kfolder', help='kfolder')
    parser.add_argument('test_path', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/ir/test_path', help='The test dataset')

    parser.add_argument('csv_measurements_path', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/kernel_measurements.csv', help='The input csv file containing measurements.')
    #parser.add_argument('--save', type=bool, default=False, action='store_true', help='The store_true option automatically creates a default value of False, Likewise, store_false will default to True when the command-line argument is not present.')
    parser.add_argument('--dataset_name', type=str, default='fromCummins', help='name of the dataset that is used for the experiments.')        
    parser.add_argument('experiments_path', type=str, default='/home/marianna/Documents/programl/compiled_kernels/final_dataset/experiments', help='The path containing the experiments.')
    parser.add_argument('--epochs', type=int, default=100, help='The number of epochs to train the model for')
    parser.add_argument('--batch_size', type=int, default=32, help='batch size')
    parser.add_argument('--pct_close', type=float, default=0.05, help='In regression problem, you have to define what a correct prediction is. You define correctness as being within a certain percentage of the true value. pct_close is the percentage.')
    #parser.add_argument('--num_layers', type=int, default=3, help='number of iterations over the neighborhood')
    #parser.add_argument('--norm', type=str, default=None, help='Type of normalization.')
    parser.add_argument('--hidden_dim', type=int, default=64, help='Dimmension of the hidden states.')
    parser.add_argument('--heads', type=int, default=8, help='Number of attention heads')
    parser.add_argument('--num_exps', type=int, default=1, help='Number of experiments')

    parser.add_argument('--lr', type=float, default=0.001, help='learning rate')
    parser.add_argument('--patience', type=int, default=20, help='number of epochs to wait before starting lr decay (early stoppping criterion).')

    parser.add_argument('--feature_scale', type=bool, default=True, help='whether or not do feature scaling')
    parser.add_argument('--scale_type', type=str, default='standardization', help='(or minmax)what type of feature scaling I use')
    parser.add_argument('--devicedataset', type=str, default='GPU', help='(GPU or CPU) the device with which the kernels are running')

    args = parser.parse_args() # args respresents the options we have

    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    print('available device in this HW is {device}'.format(device=device))
    
    

    if args.devicedataset == 'CPU':
        df = pd.read_csv(io.open(args.kfolder_path+'/dfmeanscpu.csv'))
        meant, stdt, meanb, stdb = df['meant'], df['stdt'], df['meanb'], df['stdb']
    if args.devicedataset == 'GPU':
        df = pd.read_csv(io.open(args.kfolder_path+'dfmeansgpu.csv')) #'/home/marianna/Documents/programl/ML_gnns_git/compiled_kernels/final_dataset/kfolder/dfmeansgpu.csv'))
        meant, stdt, meanb, stdb = df['meant'], df['stdt'], df['meanb'], df['stdb']

    ifold = 0
    all_list = []
    for filename in os.listdir(args.kfolder_path):
        trainpaths = []
        ifold += 1         
        for ff in os.listdir(args.kfolder_path): # ff = k1, k2, ...
            if filename == ff:
                print('****validation graphs*****')
                val_path = os.path.join(args.kfolder_path, ff)
                print(f'the fold used for validation this time is {filename}')
                if args.devicedataset == 'CPU':
                    # print(f'scaling the execution and the output bytes for CPU for validation set')    
                    devicekernels = pd.read_csv(val_path+'/cpu.csv')
                    scaletype = args.scale_type
                    # devicekernels, meant, stdt, meanb, stdb = scaling(scaletype, devicekernels)
                    validation_pg_graphs, max_number_nodes, max_number_edges = create_pg_graphs(path=val_path, kernelsdf=devicekernels)#devicekernels)
                elif args.devicedataset == 'GPU':
                    # print(f'scaling the execution and the output bytes for GPU for validation set')    
                    devicekernels = pd.read_csv(val_path+'/gpu.csv')
                    scaletype = args.scale_type
                    # devicekernels, meant, stdt, meanb, stdb = scaling(scaletype, devicekernels)
                    validation_pg_graphs, max_number_nodes, max_number_edges = create_pg_graphs(val_path, devicekernels)#devicekernels)                    
                set = "validation"
                print(f'length of {set} pytorch geometric graphs: {len(validation_pg_graphs)}')
            else:
                trainpaths.append(os.path.join(args.kfolder_path, ff))
               
        train_pg_graphs, test_pg_graphs = maincall(trainpaths, devicekernels, args)

        for norm in ['None']:#'pairnorm', 'layernorm', 'None', 'neighbornorm']:#, 'batchnorm', 'None', 'layernorm']:#, 'pairnorm', 'lipschitznorm']:
            for num_layers in [1]:#, 2]:#, 3, 5]:
                accuracy_list = []
                for exp in range(args.num_exps):
                    print('-----------------------')
                    print(f'Experiment {exp} with normalization type {norm} and number of layers {num_layers}')
                    print('-----------------------')
                    
                    # model
                    model = GTModel(
                                    num_layers = num_layers,
                                    hidden_dim= args.hidden_dim,
                                    heads=args.heads,
                                    feat_dropout=0.0, 
                                    top_k_pool=5, 
                                    norm=norm,
                                    beta=True
                                    )#.to(device)
                    print(next(model.parameters()).device)
                    print(model)
                    # optimizer
                    optimizer = torch.optim.Adam(model.parameters(), lr=args.lr, weight_decay=0.0005) # args.lr=0.01
                    if args.patience > 0:
                        scheduler = torch.optim.lr_scheduler.ReduceLROnPlateau(optimizer, mode='min', patience=args.patience, verbose=True, min_lr=0.00000001) #args.patience

                    # Train
                    whole_exp_states = []
                    start_time = time.time()
                    for epoch in tqdm(range(args.epochs)):
                        state, optimizer = train_one_epoch(meant, stdt, meanb, stdb, epoch, model, optimizer, train_pg_graphs, batch_size=args.batch_size, pct_close=args.pct_close)#, device, batch_size=16)
                        whole_exp_states.append(state)

                        val_state = evaluate_per_epoch(meant, stdt, meanb, stdb, epoch, model, validation_pg_graphs, batch_size=args.batch_size, pct_close=args.pct_close)
                        whole_exp_states.append(val_state)

                    
                        # early stopping here comparing with the val loss 

                    if args.scale_type == 'standardization':
                        test_state = test_per_epoch(meant, stdt, meanb, stdb, epoch, model, test_pg_graphs, batch_size=args.batch_size, pct_close=args.pct_close)
                        whole_exp_states.append(test_state)

                    print('End of experiment {exp}.')

        dict_folds = {'ifold': ifold, 'whole_exp_states': whole_exp_states}
        all_list.append(dict_folds)

    # Save the experiments 
    experiments_folder = None
    if True:
        now = time.strftime("%Y%m%d_%H%M%S")
        experiments_folder = os.path.join(args.experiments_path, args.dataset_name, now)
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
