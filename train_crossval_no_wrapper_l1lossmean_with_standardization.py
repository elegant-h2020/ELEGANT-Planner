#!/usr/bin/python3

"""
    This script has the train and evaluate functions for our graph regression.

    @author: mariannatzortzi
"""

import io
import os  
import glob
from textwrap import indent
import time
import argparse
import datetime
from matplotlib.pyplot import sca
import numpy as np
import pandas as pd
from pandas.io import json
from torch_geometric import data
from tqdm import tqdm
from pathlib import Path, WindowsPath
from sklearn.preprocessing import StandardScaler

import torch
import torch.nn as nn
import torch_geometric
from torch_geometric.data import Data
from torch_geometric.loader import DataLoader

def accuracy(batchscores, targets, pct_close):
    n_items = len(targets)
    print(f'n_items is {n_items}')
    print(f'subtract {(torch.abs(batchscores-targets) < pct_close)}')
    arr_correct = torch.sum((torch.abs(batchscores-targets) < pct_close), dim=1)
    print(f'arr_correct is {arr_correct}')
    n_correct = (arr_correct==2).sum()
    print(f'give me the number of items and how many correct cases do I have in that group {n_items}, {n_correct}')
    return 

def train_one_epoch(epoch, model, optimizer, train_pg_graphs, batch_size, pct_close):# device
    
    trainloader = DataLoader(train_pg_graphs, batch_size=batch_size)
    # print('\n How many times do I have to traverse the dataset so as to train graphs equal to window(number of iterations) ?', len(dataset), '\n')
    epoch_train_loss = 0
    epoch_train_mae = 0
    model.train()
    for step, batch_graphs in enumerate(trainloader):
        start_time_training = time.time()
        print('========================')
        print(f'Step {step+1}:')
        optimizer.zero_grad() # Reset gradients

        batch_scores = model(batch_graphs) # load each DataBatch object
        print(f'shape of batch scores is {batch_scores.shape}, {batch_scores}')

        # Calculating the loss and the gradients# targets = batch_graphs.y.view(-1)
        loss_train = model.loss(batch_scores, batch_graphs.y)
        print(f'batch_graphs.y is {batch_graphs.y.shape}, {batch_graphs.y}')
        print(f'loss_train is {loss_train.detach().item()}')

        loss_train.backward()
        optimizer.step()
        # Update tracking
        epoch_train_loss += loss_train.detach().item()
        # epoch_train_mae += MAE(batch_scores, batch_graphs.y)            
    epoch_train_loss /= (step+1)
    # epoch_train_mae /= (i+1)

    print('Epoch: {:04d}'.format(epoch),
            'loss_train: {:.4f}'.format(epoch_train_loss),
            # 'loss_train_mae: {:.4f}'.format(epoch_train_mae),
            #'loss_val: {:.4f}'.format(loss_val.item()),
            'time: {:.4f}s'.format(time.time() - start_time_training)
    )

    current_train_state = {
        'epoch': epoch,
        'loss_train': epoch_train_loss,
        # 'loss_train_mae': epoch_train_mae
    } 
    return current_train_state, optimizer

def evaluate_per_epoch(epoch, model, eval_pg_graphs, batch_size, pct_close): #device

    evalloader = DataLoader(eval_pg_graphs, batch_size=batch_size)
    epoch_eval_loss = 0
    model.eval()
    with torch.no_grad():

        for step, batch_graphs in enumerate(evalloader):
            start_time_training = time.time()
            print('========================')
            print(f'Step {step+1}:')

            batch_scores = model(batch_graphs) # load each DataBatch object
            print(f'shape of batch scores is {batch_scores.shape}, {batch_scores}')

            # Calculating the loss and the gradients# targets = batch_graphs.y.view(-1)
            loss_eval = model.loss(batch_scores, batch_graphs.y)
            print(f'batch_graphs.y is {batch_graphs.y.shape}, {batch_graphs.y}')
            epoch_eval_loss += loss_eval.detach().item()
            
        epoch_eval_loss /= (step+1)

        print('Epoch: {:04d}'.format(epoch),
                'loss_eval: {:.4f}'.format(epoch_eval_loss),
                'time: {:.4f}s'.format(time.time() - start_time_training)
        )

        current_evaluation_state = {
            'epoch': epoch,
            'loss_eval': epoch_eval_loss,
        } 
    return current_evaluation_state


def inverse_scale(meant, stdt, meanb, stdb, y_scaled):
    # original_values_t = (y_scaled[:,0] * stdt) + meant
    original_values_t = (y_scaled * stdt) + meant
    # original_values_b = (y_scaled[:,1] * stdb) + meanb
    # original_values_b = (y_scaled * stdb) + meanb
    # print(f'original_values_t {original_values_t.shape} {original_values_t}')
    # print(f'original_values_b {original_values_b.shape} {original_values_b}')
    # original_values = torch.stack((original_values_t, original_values_b), dim=1)
    return original_values_t

def inverse_minmax(Max, Min, y_scaled):
    original_values_t = (y_scaled*(Max-Min)) + Min
    return original_values_t


def test_per_epoch(meant, stdt, meanb, stdb, epoch, model, eval_pg_graphs, batch_size, pct_close): #device

    evalloader = DataLoader(eval_pg_graphs, batch_size=batch_size)
    # print('\n How many times do I have to traverse the dataset so as to train graphs equal to window(number of iterations) ?', len(dataset), '\n')
    epoch_eval_loss = 0
    test_label_list = []
    test_pred_list = []
    model.eval()
    with torch.no_grad():

        for step, batch_graphs in enumerate(evalloader):
            start_time_training = time.time()
            print('========================')
            print(f'Step {step+1}:')

            batch_scores = model(batch_graphs) # load each DataBatch object
            print(f'shape of batch scores is {batch_scores.shape}, {batch_scores}')

            # Calculating the loss and the gradients# targets = batch_graphs.y.view(-1)
            loss_eval = model.loss(batch_scores, batch_graphs.y)
            print(f'test batch_graphs.y is {batch_graphs.y.shape}, {batch_graphs.y}')
            epoch_eval_loss += loss_eval.detach().item()
           
            #endtoend and outputbytes
            #labels
            original_values_label = inverse_scale(meant, stdt, meanb, stdb, batch_graphs.y)
            original_label = pd.DataFrame(original_values_label)
            original_label['2'] = batch_graphs.kernelname
            #preds
            original_values_pred = inverse_scale(meant, stdt, meanb, stdb, batch_scores)
            original_pred = pd.DataFrame(original_values_pred)
            original_pred['2'] = batch_graphs.kernelname

            test_label_list.append(original_label)
            test_pred_list.append(original_pred)
            print(f'original_pred {original_pred}, original_label {original_label}')

        epoch_eval_loss /= (step+1)

        print('Epoch: {:04d}'.format(epoch),
                'loss_test: {:.4f}'.format(epoch_eval_loss),
                'time: {:.4f}s'.format(time.time() - start_time_training)
        )

        current_test_state = {
            'epoch': epoch,
            'loss_test': epoch_eval_loss,
            'test_labels' : test_label_list,
            'test_preds' : test_pred_list
        } 
    return current_test_state

def test_per_epoch_minmax(Max, Min, epoch, model, eval_pg_graphs, batch_size, pct_close): #device

    evalloader = DataLoader(eval_pg_graphs, batch_size=batch_size)
    epoch_eval_loss = 0
    test_label_list = []
    test_pred_list = []
    model.eval()
    with torch.no_grad():

        for step, batch_graphs in enumerate(evalloader):
            start_time_training = time.time()
            print('=========================')
            print(f'Step {step+1}:')

            batch_scores = model(batch_graphs)
            print(f'shape of batch scores is {batch_scores.shape}, {batch_scores}')

            # Calculating the loss and the gradients 
            loss_eval = model.loss(batch_scores, batch_graphs.y)
            print(f'test batch_graphs.y is {batch_graphs.y.shape}, {batch_graphs.y}')
            epoch_eval_loss += loss_eval.detach().item()

            #endtoend 
            #labels 
            original_values_label = inverse_minmax(Max, Min, batch_graphs.y)
            original_label = pd.DataFrame(original_values_label)
            original_label['2'] = batch_graphs.kernelname
            #preds
            original_values_pred = inverse_minmax(Max, Min, batch_scores)
            original_pred = pd.DataFrame(original_values_pred)
            original_pred['2'] = batch_graphs.kernelname

            test_label_list.append(original_label)
            test_pred_list.append(original_pred)
            print(f'original_pred {original_pred}, original_label {original_label}')
        
        epoch_eval_loss /= (step+1)

        print('Epoch: {:04d}'.format(epoch),
              'loss_test: {:.4f}'.format(epoch_eval_loss),
              'time: {:.4f}s'.format(time.time() - start_time_training)
        )

        current_test_state = {
                'epoch': epoch,
                'loss_test': epoch_eval_loss,
                'test_labels': test_label_list,
                'test_preds': test_pred_list
        }
    return current_test_state
