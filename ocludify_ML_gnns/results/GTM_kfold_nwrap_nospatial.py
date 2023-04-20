#!/usr/bin/python3

"""
    Graph Transformer for Graph Regression

    @author: mariannatzortzi
"""

# import libraries
import os 
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch.nn.modules.linear import Linear

from torch_geometric.nn import TopKPooling 
from torch_geometric.nn.norm import PairNorm, LayerNorm 
from torch_geometric.nn import global_mean_pool as gap, global_max_pool as gmp

from layers.Graph_transformer_layer import TransformerConv
import NodeFeatureEncoder
import EdgeFeatureEncoder

class GTModel(nn.Module):
    def __init__(self, num_layers, hidden_dim, heads, feat_dropout, top_k_pool, norm, beta=True):

        super().__init__()

        dense_neurons = 256
        self.top_k_every_n = top_k_pool # self.top_k_every_n
        self.num_layers = num_layers
        self.norm_name = norm
        self.feat_dropout = feat_dropout
        self.norm = None

        self.conv_layers = nn.ModuleList([])
        self.transf_layers = nn.ModuleList([])
        self.pooling_layers = nn.ModuleList([])
        self.norm_layers = nn.ModuleList([])

        if self.norm_name == 'pairnorm':
            self.norm = PairNorm() #self.pairnorm = PairNorm()
        elif self.norm_name == 'layernorm':
            self.norm = LayerNorm(hidden_dim) #self.layernorm = LayerNorm(hidden_dim)


        """
            we don't calculate the embeddings here, but we calculate them using the NodeFeatureEncoder and then pass them into our GNN model directly.
            The call of NodeFeatureEncoder is happening inside the ... so this is happening per batch of graphs!
        """

        # Transformation Layer
        #self.conv1 = TransformerConv(hidden_dim, hidden_dim, heads, dropout=0.5, edge_dim=hidden_dim, norm=self.norm, beta=False)
        ##self.transf1 = Linear(hidden_dim*heads, hidden_dim) # reduce dimensionality and accelerate processing
        #self.bn1 = nn.BatchNorm1d(hidden_dim*heads)
        #self.transf1 = Linear(hidden_dim*heads, hidden_dim)


        # maybe the number of input channels in the next layer via num_heads * output_channels - search for this!!!!
        # Other Layers
        for i in range(self.num_layers):
            self.conv_layers.append(TransformerConv(hidden_dim, hidden_dim, heads, dropout=0.4, edge_dim=hidden_dim, norm=self.norm, beta=False))#, self.batch_norm, self.residual))   
            # self.transf_layers.append(Linear(hidden_dim*heads, hidden_dim))
            # self.norm_layers.append(nn.LayerNorm(hidden_dim))
            self.norm_layers.append(nn.BatchNorm1d(hidden_dim*heads)) 
            self.transf_layers.append(Linear(hidden_dim*heads, hidden_dim))
            #if i % self.top_k_every_n == 0:
            #   self.pooling_layers.append(TopKPooling(hidden_dim, ratio=0.5)) # Graph pooling ratio default: 0.5   

        # Linear Layers 
        self.linear1 = Linear(hidden_dim*2, dense_neurons)
        self.linear2 = Linear(dense_neurons, int(dense_neurons/2))  
        # self.linear3 = Linear(int(dense_neurons/2), 2)  
        self.linear3 = Linear(int(dense_neurons/2), 1)

 
    def forward(self, batch_graphs): # h_lap_pos_enc=None

        #device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
        #print('available device in this HW is {device}'.format(device=device))
        #os.environ["CUDA_VISIBLE_DEVICES"] = "0"
        out = []

        # x, edge_attr, edge_index, batch_index = batch_graphs.x, batch_graphs.edge_attr, batch_graphs.edge_index, batch_graphs.batch
        print(f'================x.shape in this new batch of graphs {batch_graphs.x.shape} ')#{batch_graphs.x}==============')

        nodefeature = NodeFeatureEncoder.FeatureEncoder(batch_graphs, emb_dim=64) # emb_dim=hidden_dim=64
        renewed_data = nodefeature(batch_graphs) # forward pass

        edgefeature = EdgeFeatureEncoder.eFeatureEncoder(renewed_data, emb_dim=64)
        renewed_data = edgefeature(renewed_data) 

        print(f'x after the Embedding layer {renewed_data.x}')

        x, edge_attr, edge_index, batch_index = renewed_data.x, renewed_data.edge_attr, renewed_data.edge_index, renewed_data.batch

        print(f'shape of x after the calculation and summation of the node embeddings {x.shape}')
        print(f'edge_attr shape {edge_attr.shape}')

        # Initial Transformation
        #x = self.conv1(x, edge_index, edge_attr)
        #x = self.bn1(x)
        #x = torch.nn.functional.elu(self.transf1(x))
        ##x = self.bn1(x)

        # Holds the intermediate graph representations
        global_representation = []

        for i in range(self.num_layers):
            x = self.conv_layers[i](x, edge_index, edge_attr)
            x  = self.norm_layers[i](x)
            x = torch.nn.functional.relu(self.transf_layers[i](x))
            #x = self.norm_layers[i](x)
            # Always aggregate last layer
            #if i % self.top_k_every_n == 0 or i == self.num_layers:
            #    x, edge_index, edge_attr, batch_index, _, _ = self.pooling_layers[int(i/self.top_k_every_n)](x, edge_index, edge_attr, batch_index) 
            print(f'shape x: {x.shape}, batch_index shape {batch_index.shape}')
            # Add current representation
            global_representation.append(torch.cat([gmp(x, batch_index), gap(x, batch_index)], dim=1))

        x = sum(global_representation)

        print(f'out shape after gap, cat and sum {x.shape}') #[batchsize, hiddendim*lendatalist]

        # Output block
        x = torch.nn.functional.relu(self.linear1(x))
        x = F.dropout(x, p=0.4, training=self.training)
        x = torch.nn.functional.relu(self.linear2(x))
        x = F.dropout(x, p=0.4, training=self.training)
        x = self.linear3(x)

        print(f'x shape from GTModel {x.shape}')

        return x


    # def loss(self, scores, targets):
    #     loss = nn.L1Loss(reduction='none')(scores, targets)
    #     return loss

    def loss(self, scores, targets):
        loss = nn.L1Loss()(scores, targets)
        return loss
