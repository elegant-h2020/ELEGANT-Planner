#!/usr/bin/python3

"""
    This script reads runs csv and final llvmir codes from each set, (train, validation or test - depending on which one I call)
    and creates pytorch geometric graphs.

    @author: mariannatzortzi
"""

import io
import os  
import glob
import argparse
import datetime
import numpy as np
import pandas as pd
from tqdm import tqdm

import torch
import torch_geometric
from torch_geometric.data import Data

import networkx as nx
import programl as pg

# GPU
#os.environ['CUDA_VISIBLE_DEVICES'] = "0" 

# I want to load the files containing all the llvm ir codes.
def create_pg_graphs(path, kernelsdf, target_is):

    llvmir_path = path
    pg_graphs = []
    max_number_nodes = 0
    max_number_edges = 0
    total_number_nodes = 0
    total_number_edges = 0
    inputlist = []
    outputlist = []
    execlist = []
    storeOpslist = []
    """ 
        For each llvm ir code filename I have, I convert it first into 
        Programl Graph -> Networkx -> Pytorch Geometric (using Data class)
    """
    for filename in tqdm(glob.glob(os.path.join(llvmir_path, '*.ll'))):
        llname = filename.split('/')[-1].split('.ll')[0]
        # If I have measuremets for this llname kernel create its pytorch geometric graph 
        if kernelsdf['kernel'].str.contains(llname).any():
            specifickernel = kernelsdf[kernelsdf['kernel'] == llname]
            runs = specifickernel.shape[0]
            print(f'There are %d different runs for the {llname} kernel and for this device' % runs)
            
            for index, row in specifickernel.iterrows():
                with open(os.path.join(os.getcwd(), filename), 'r') as f:

                    src = f.read()
                    G = pg.from_llvm_ir(src)

                    """ convert graph to networkx graph """
                    NG = pg.to_networkx(G)
                    NG = nx.convert_node_labels_to_integers(NG)
                    NG = NG.to_directed() if not nx.is_directed(NG) else NG
                    # print(f'length of nodes is: {NG.number_of_nodes()}')
                    #print(f'number of edges is: {NG.number_of_edges()}')
                    total_number_nodes += NG.number_of_nodes()
                    total_number_edges += NG.number_of_edges()
                    if max_number_nodes < NG.number_of_nodes():
                        max_number_nodes = NG.number_of_nodes()
                    if max_number_edges < NG.number_of_edges():
                        max_number_edges = NG.number_of_edges()


                    """
                        the tensor defining the source and the target nodes of all edges
                        create the edge_index properly - Edges in sparse COO format: set of tuples of connections
                        Shape [2, num_edges]
                    """
                    edge_index_list = []
                    for e in NG.edges():
                        source, target = e
                        edge_index_list.append([source, target])
                    edge_index = torch.tensor(edge_index_list, dtype=torch.long)
                    edge_index = edge_index.t().contiguous()

                    """
                        Node feature matrix with shape [num_nodes, num_node_feature]
                        Add to node features the rows of each corresponding measurement of each corresponding kernel from the dataframe
                    """
                    node_attr = []
                    for i, (k, features_dict) in enumerate(NG.nodes(data=True)):
                        ntype = features_dict['type']
                        nblock = features_dict['block']
                        ninputbytes = row['input_bytes']
                        # nstoreOps = row['storeOps']
                        ndevice = row['device']
                        nmachine = row['#machine']
                        node_attr.append([ntype, nblock, ninputbytes, nmachine])#, nstoreOps])
                        

                    x = torch.tensor(node_attr, dtype=torch.long)

                    """ create the edge_attr """
                    edge_features_list = []
                    edge_types = ["control", "data", "call"]
                    for i, (k, l, features_dict) in enumerate(NG.edges(data=True)):
                        edge_features_list.append([features_dict['flow']])
                    edge_features = torch.tensor(edge_features_list, dtype=torch.long)

                    """
                         data.y: Target to train against (may have arbitrary shape), e.g.,
                         node-level targets of shape [num_nodes, *] or 
                         graph-level targets of shape [1, *]
                    """

                    if target_is == 'devicetransfer':
                        y = torch.unsqueeze(torch.tensor([row['devicetransfer']], dtype=torch.float), 0)
                    elif target_is == 'output_bytes':
                        y = torch.unsqueeze(torch.tensor([row['output_bytes']], dtype=torch.float), 0)
                    else:
                        y = torch.unsqueeze(torch.tensor([row['devicetransfer'], row['output_bytes']], dtype=torch.float), 0)


                    outputlist.append(row['output_bytes'])
                    inputlist.append(row['input_bytes'])
                    execlist.append(row['devicetransfer'])
                    # storeOpslist.append(row['storeOps'])

                    graph = {}
                    graph = Data(
                        kernelname = llname,
                        x = x, 
                        edge_index = edge_index,
                        edge_attr = edge_features,
                        y = y 
                    )
                    pg_graphs.append(graph)

        # print('\n print pg graphs ', pg_graphs)
        # print('\n >>>>> next graph <<<<< \n')

    print('total number of nodes', total_number_nodes)
    print('total number of edges', total_number_edges)

    return pg_graphs, max_number_nodes, max_number_edges
