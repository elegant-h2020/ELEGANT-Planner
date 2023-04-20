#!/usr/bin/python3

"""
   
"""

import io
import os
import csv
import sys
import glob
import torch
import random
import shutil
import argparse
import numpy as np
import pandas as pd
from tqdm import tqdm
from statistics import mean, stdev

# GPU
os.environ['CUDA_VISIBLE_DEVICES'] = "0"

def feature_test(data, scale_type, max_kfold, min_kfold):
    if scale_type == 'minmax':
        data = data.squeeze().tolist()
        scaled = (np.asarray(data) - min_kfold) / (max_kfold - min_kfold)
    return scaled

def scale_test(scale_type, testdf, maxt_kfold, mint_kfold, maxb_kfold, minb_kfold, maxi_kfold, mini_kfold):
    if scale_type == 'minmax':
        datainputs = testdf['input_bytes'].values
        datainputs = feature_test(datainputs, scale_type, maxi_kfold, mini_kfold)
        testdf['input_bytes'] = datainputs
        # output byte
        dataoutputs = testdf['output_bytes'].values
        dataoutputs = feature_test(dataoutputs, scale_type, maxb_kfold, minb_kfold)
        testdf['output_bytes'] = dataoutputs
        # execution time
        dataexectime = testdf['devicetransfer'].values
        dataexectime = feature_test(dataexectime, scale_type, maxt_kfold, mint_kfold)
        testdf['devicetransfer'] = dataexectime
        return testdf


def feature_scale(data, scale_type):
    if scale_type == 'minmax':
        data = data.squeeze().tolist()
        Max = max(data)
        Min = min(data)
        scaled = (np.asarray(data) - Min) / (Max - Min)
        return scaled, Max, Min
    elif scale_type == 'standardization':
        data = data.squeeze().tolist()
        meand = mean(data)
        print(f'meand is {meand}')
        std = stdev(data)
        print(f'std is {std}')
        scaled = (np.asarray(data) - meand) / std
        return scaled, meand, std


def scaling(scale_type, df):
    # feature scaling for output_bytes, and devicetransfer time
    if scale_type == 'standardization':
        dataoutputs = df['output_bytes'].values
        print(f'scaling output bytes:')
        dataoutputs, meanb, stdb = feature_scale(dataoutputs, scale_type)
        df['output_bytes'] = dataoutputs

        dataexectime = df['devicetransfer'].values
        print(f'scaling execution time:')
        dataexectime, meant, stdt = feature_scale(dataexectime, scale_type)
        df['devicetransfer'] = dataexectime

        return df, meant, stdt, meanb, stdb

    elif scale_type == 'minmax':
        datainputs = df['input_bytes'].values
        print(f'scaling input bytes:')
        datainputs, maxi, mini = feature_scale(datainputs, scale_type)
        df['input_bytes'] = datainputs

        dataoutputs = df['output_bytes'].values
        print(f'scaling output bytes:')
        dataoutputs, maxb, minb  = feature_scale(dataoutputs, scale_type)
        df['output_bytes'] = dataoutputs

        dataexectime = df['devicetransfer'].values
        print(f'scaling execution time:')
        dataexectime, maxt, mint = feature_scale(dataexectime, scale_type)
        df['devicetransfer'] = dataexectime

        return df, maxt, mint, maxb, minb, maxi, mini
    


""" Based on the unique kernels, create for each team the corresponding ir folder """
def split_on_teams(args):
    
    # create pathfile
    pathfile = args.team_path+'ir_'+f'{args.device}'
    if not os.path.exists(pathfile):
        os.makedirs(pathfile)

    # calculate the number of unique kernels for the corresponding team
    team = pd.read_csv(args.team_csv)
    unique_kernels = team['kernel'].unique()
    print(f'unique kernels for the team {args.num_team} {len(unique_kernels)}, {type(unique_kernels)}')
    # convert the unique kernels into a dataframe
    unique_kernels = pd.DataFrame(unique_kernels, columns=['unkernel'])
    print('give me the columns', unique_kernels.head())
    # for every llvmir file if I have kernel for this file, I copy the file into pathfile
    for filename in tqdm(glob.glob(os.path.join(args.ir_path, '*.ll'))):
        llname = filename.split('.')[-1]
        # If I have kernel for this llname kernel
        if unique_kernels['unkernel'].str.contains(llname).any():
            shutil.copy(filename, pathfile)

    return pathfile


class Split_llvmir():
    
    def __init__(self, pathfile):
        super().__init__()
        # data loading
        self.LLVM_IR_FILE_PATH = pathfile
    
    def __len__(self):
        len_of_files = 0
        for filename in glob.glob(os.path.join(self.LLVM_IR_FILE_PATH, '*.ll')):
            with open(os.path.join(os.getcwd(), filename), 'r') as f: # open in readonly mode
                len_of_files += 1
        # print(f'len_of_files is: {len_of_files}')
        return len_of_files
    
    def __getitem__(self, args):

        kfolder = args.team_kfolder_device
        if not os.path.exists(kfolder):
            os.makedirs(kfolder)

        test_dir = args.team_testfolder_device
        if not os.path.exists(test_dir):
            os.makedirs(test_dir)        

        src = self.LLVM_IR_FILE_PATH
        allFileNames = os.listdir(src)
        np.random.shuffle(allFileNames)

        kfold_Filenames, test_Filenames = np.split(np.array(allFileNames), [int(len(allFileNames)*args.percentage)])

        kfold_Filenames = [src + '/' + name for name in kfold_Filenames.tolist()]
        test_Filenames = [src + '/' + name for name in test_Filenames.tolist()]

        print('Total ir files:', len(allFileNames))
        print('kfold files', len(kfold_Filenames))
        print('test files', len(test_Filenames))

        # Copy-pasting files
        for name in kfold_Filenames:
            shutil.copy(name, kfolder)

        for name in test_Filenames:
            shutil.copy(name, test_dir)

        return
    
def fold_into_df(args, fold):
    # kfolder = args.team_kfolder_device
    team_csv = args.team_csv
    team_df = pd.read_csv(team_csv)
    print(f'team_df columns are {team_df.columns} and shape {team_df.shape}')
    df_list = []
    """
        For each filename, inside the kfolder, where the llvm ir code exists, 
        if there is any row of the team dataframe, with the same kernel name,
        I keep the rows in a new dataframe. So, I create a new dataframe, 
        corresponding to all the runs of the kernels of the kfolder (kfold_df).
        I'm doing the same with the testfolder, so as to create a new dataframe,
        corresponding to all the runs of the kernels that belong to the testfolder.
    """
    for filename in tqdm(glob.glob(os.path.join(fold, '*.ll'))):
        llname = filename.split('/')[-1].split('.ll')[0]
        if team_df['kernel'].str.contains(llname).any():
           specifickernel = team_df[team_df['kernel'] == llname]
           df_list.append(specifickernel)
    fold_df = pd.concat(df_list)
    return fold_df


def makedirectories(args, chunks):
    # base dir    
    base = args.team_kfolder_device
    kfold = args.k

    # create dynamically directories
    listt = [str(i) for i in range(0,kfold)]
    for items in listt:
        device_path = os.path.join(base, items)
        if not os.path.exists(base):
            os.makedirs(base)
        os.mkdir(device_path)

    # Instead of splitting the kfolds ir files, based on kernels
    # I split the ir files of the kfolds, based on runs
    for en, i in enumerate(chunks):
        split_files(args, i, base+'/'+str(en))
        i.to_csv(base+'/'+str(en)+'/'+f'{args.device}.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)
    return

def split_files(args, chunkdf, pathfile):
    for filename in tqdm(glob.glob(os.path.join(args.team_kfolder_device, '*.ll'))):
        llname = filename.split('/')[-1].split('.ll')[0]
        # If I have measurements for this llname kernel  
        if chunkdf['kernel'].str.contains(llname).any():
            shutil.copy(filename, pathfile)
    return 


def kfolds_split(kfold_df, k): #df_trainval = kfold_df
    # sample(frac=1) shuffle the rows of df - frac=1 means to return all rows (in random order)
    shuffled = kfold_df.sample(frac=1) 
    chunks = np.array_split(kfold_df, k) # np.array_split split it into parts that have equal size
    print(f'k1 is {chunks[0].shape} and type {type(chunks[0])}')
    return chunks 

"""
    team1 consists of silver1 (Tesla 2018, cpu 2017) and epyc7 (A100 2020, cpu 2019)
    team2 consists of gold2 (GeForce 2018, cpu 2017) and dungani (Quadro 2015, Tesla 2013, cpu 2013)
"""

if __name__ == '__main__':
    # Program parameters parsing
    parser = argparse.ArgumentParser(description='')
    parser.add_argument('device', type=str, default='cpu', help='show me the device used for the experiments')
    parser.add_argument('team_csv', type=str, default='/home/marianna/Documents/programl/ocludify/results/team1/team1_cpu.csv')
    parser.add_argument('num_team', type=str, default='team1', help='The team in which the current kernels belong')
    parser.add_argument('ir_path', type=str, default='/home/marianna/Documents/programl/ocludify/results/ir')

    # team folders
    parser.add_argument('team_path', type=str, default='/home/marianna/Documents/programl/ocludify/results/team1/', help='team path')
    parser.add_argument('team_kfolder_device', type=str, default='/home/marianna/Documents/programl/ocludify/results/team1/kfolder_cpu', help='kfolder team path')
    parser.add_argument('team_testfolder_device', type=str, default='/home/marianna/Documents/programl/ocludify/results/team1/testfolder_cpu', help='testfolder team path')

    parser.add_argument('--scale_type', type=str, default='standardization', help='(or minmax) what type of feature scaling I use')   
    parser.add_argument('--percentage', type=float, default=0.9, help='percentage of kfolder')
    parser.add_argument('--k', type=int, default=5, help='how many folders in my cross-validation')
    
    args = parser.parse_args() # args represents the options that we have

    if not os.path.exists(args.team_path):
        os.makedirs(args.team_path)

    # When a python script is executed with arguments,
    # it is captured by Python and stored in a list called sys.argv
    print("This is the name of the program:", sys.argv[0])
    print("Argument List:", str(sys.argv))
 
    pathfile = split_on_teams(args)

    print(f'pathfile is {pathfile}')
    dataset = Split_llvmir(pathfile)
    dataset_size = len(dataset)
    print(f'How many ir files do I have in total? {dataset_size}')
    dataset.__getitem__(args)

    # kfolder 
    kfolder = args.team_kfolder_device
    kfold_df = fold_into_df(args, kfolder) #args.team_kfolder_device
    print(f'kfold_df is {kfold_df.shape}')
    
    # testfolder
    testfolder = args.team_testfolder_device
    testfold_df = fold_into_df(args, testfolder)
    print(f'testfold_df is {testfold_df.shape}')

    if args.num_team == 'team1':
        # numpy.where(condition, [x, y, ]/)
        # An array with elements from x where condition is True, and elements from y elsewhere.
        kfold_df['#machine'] = np.where(kfold_df['machine'] != 'silver1', kfold_df['machine'], 1)
        kfold_df['#machine'] = np.where(kfold_df['machine'] != 'epyc7', kfold_df['#machine'], 7)
        testfold_df['#machine'] = np.where(testfold_df['machine'] != 'silver1', testfold_df['machine'], 1)
        testfold_df['#machine'] = np.where(testfold_df['machine'] != 'epyc7', testfold_df['#machine'], 7)
    elif args.num_team == 'team2':
        kfold_df['#machine'] = np.where(kfold_df['machine'] != 'gold2', kfold_df['machine'], 2)
        kfold_df['#machine'] = np.where(kfold_df['machine'] != 'dungani', kfold_df['#machine'], 3)
        testfold_df['#machine'] = np.where(testfold_df['machine'] != 'gold2', testfold_df['machine'], 2)
        testfold_df['#machine'] = np.where(testfold_df['machine'] != 'dungani', testfold_df['#machine'], 3)

    kfold_df.to_csv(args.team_path+'/'+f'kfolder_{args.device}.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)
    testfold_df.to_csv(args.team_path+'/'+f'testfolder_{args.device}.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)
   
    print(f'\n scaling the exectime and the output bytes (both are targets of the prediction model) for each team')


    """ Normalize the test folder using the parameters from the kfolder.""" 
    if args.scale_type == 'standardization':
        kfold_final, meant_kfold, stdt_kfold, meanb_kfold, stdb_kfold = scaling(args.scale_type, kfold_df)
        statisticalm_kfold = [[meant_kfold, stdt_kfold, meanb_kfold, stdb_kfold]]
        # scaled kfold final
        kfold_final.to_csv(args.team_path+'/'+f'scaled_kfolder_{args.device}.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)
        dfmeans_kfold = pd.DataFrame(statisticalm_kfold, columns=['meant', 'stdt', 'meanb', 'stdb'])
        dfmeans_kfold.to_csv(args.team_path+f'dfmeans_kfold_{args.num_team}_{args.device}.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)

        # test_final, meant_test, stdt_test, meanb_test, stdb_test = scaling(args.scale_type, testfold_df)
        # statisticalm_test = [[meant_test, stdt_test, meanb_test, stdb_test]]
        # # scaled testfold final
        # test_final.to_csv(args.team_path+'/'+f'scaled_testfolder_{args.device}.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)
        # dfmeans_test = pd.DataFrame(statisticalm_test, columns=['meant', 'stdt', 'meanb', 'stdb'])
        # dfmeans_test.to_csv(args.team_path+f'dfmeans_test_{args.num_team}_{args.device}.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)    

    elif args.scale_type == 'minmax':
        kfold_final, maxt_kfold, mint_kfold, maxb_kfold, minb_kfold, maxi_kfold, mini_kfold = scaling(args.scale_type, kfold_df)
        statisticalm_kfold = [[maxt_kfold, mint_kfold, maxb_kfold, minb_kfold, maxi_kfold, mini_kfold]]
        # scaled kfold final
        kfold_final.to_csv(args.team_path+'/'+f'scaled_kfolder_{args.device}.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)
        dfminmax_kfold = pd.DataFrame(statisticalm_kfold, columns=['maxt', 'mint', 'maxb', 'minb', 'maxi', 'mini'])
        dfminmax_kfold.to_csv(args.team_path+f'dfminmax_kfold_{args.num_team}_{args.device}.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)

        test_final = scale_test(args.scale_type, testfold_df, maxt_kfold, mint_kfold, maxb_kfold, minb_kfold, maxi_kfold, mini_kfold)
        # scaled testfold final
        test_final.to_csv(args.team_path+'/'+f'scaled_testfolder_{args.device}.csv', index=False, sep=',', quoting=csv.QUOTE_ALL)
       
    # create the k chunks for the cross-validation
    df = pd.read_csv(args.team_path+f'scaled_kfolder_{args.device}.csv')
    chunks = kfolds_split(df, args.k)

    makedirectories(args, chunks)