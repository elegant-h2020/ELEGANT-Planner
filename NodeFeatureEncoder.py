#!/usr/bin/python3

"""
    We apply multiple torch.nn.Embedding and sum the embeddings up

    @author: mariannatzortzi
"""

from hashlib import new
import torch
import math

class FeatureEncoder(torch.nn.Module):
    """
    The FeatureEncoder 
    Args:
        emb_dim (int): Output embedding dimension
        num_classes: None but it's obviously the same as unique_per_features because this corresponds to the dim which is the size of the dictionary of each of the embeddings
    """
    def __init__(self, batch, emb_dim, num_classes=None):
        super(FeatureEncoder, self).__init__()

        self.node_embedding_list = torch.nn.ModuleList()

        unique_per_features = get_node_feature_dims(batch)
        # print(f'unique_per_features is {unique_per_features}')

        for i, dim in unique_per_features.items():
            emb = torch.nn.Embedding(dim.item()+1, emb_dim)#, sparse=True)
            torch.nn.init.xavier_uniform_(emb.weight.data)
            self.node_embedding_list.append(emb)


    def forward(self, batch):

        encoded_features = 0
        for i in range(batch.x.shape[1]):
            # print('**********')
            # this is the embedding list for each feature - so when i=0 its for the node type and we have embedding for the feature node type 
            # print(f'node_embedding_list for {i} is {self.node_embedding_list[i]} and self.node_embedding_list[i](batch.x[:, i].long().view(-1,1)) {self.node_embedding_list[i](batch.x[:, i].long().view(-1,1))}') 
            # here we add the corresponding embeddings for each feature per row/node
            encoded_features += self.node_embedding_list[i](batch.x[:, i].long().view(-1,1))
            # print(f'encoded_features are inside the loop {i}, {encoded_features}, {encoded_features.shape}')

        newnodefeatures=encoded_features.view(encoded_features.shape[0], encoded_features.shape[1]*encoded_features.shape[2])
        # print(f'encoded_features are {newnodefeatures}')
        batch.x = newnodefeatures
        return batch


def get_node_feature_dims(batch):
    #node_attr = ["ntype", "nblock", "ninputbytes", "ndevice"]
    unique_per_features = {}
    # find the number of unique values of each of the features --> this is the dim for the input of the embedding 
    for i in range(batch.x.shape[1]):
        # print(f'what are the unique values for each node feature? {batch.x[:,i].unique()}')
        unique_per_features[i] = batch.x[:,i].unique().max()
        # unique_per_features[i] = len(batch.x[:,i].unique())  
    return unique_per_features


def init_params(module, n_layers):
    """
        Initialize the weights specific to the model.
        This overrides the default initializations depending on the specified arguments.
            1. If normal_init_embed_weights is set then weights of embedding layer will 
            be initialized using the normal distribution.
    """
    if isinstance(module, torch.nn.Embedding):
        module.weight.data.normal_(mean=0.0, std=0.02)


class spatial_encoding(torch.nn.Module):
    """
    The spatial encoding 
    Args:
        emb_dim (int): Output embedding dimension
    """
    def __init__(self, batch, emb_dim):
        super(spatial_encoding, self).__init__()

        dim = batch.spatial_pos.unique().max()
        print(f'show me the dim {dim}')

        self.encoder = torch.nn.Embedding(dim+1, emb_dim, padding_idx=0)
        torch.nn.init.normal_(self.encoder.weight.data, mean=0.0, std=0.02)

    def forward(self, batch):
        
        newpos = self.encoder(batch.spatial_pos)
        # print(f'newpos is {newpos.shape} {newpos}')
        batch.spatial_pos = newpos
        return batch
