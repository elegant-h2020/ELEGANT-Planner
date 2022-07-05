#!/usr/bin/python3

"""
    We apply multiple torch.nn.Embedding for edges if the edge_features > 1 then we sum the embeddings up

    @author: mariannatzortzi
"""

import torch

class eFeatureEncoder(torch.nn.Module):
    """
    The eFeatureEncoder 
    Args:
        emb_dim (int): Output embedding dimension
    """
    def __init__(self, batch, emb_dim):
        super(eFeatureEncoder, self).__init__()

        self.edge_embedding_list = torch.nn.ModuleList()

        unique_per_features = get_edge_feature_dims(batch)

        for i, dim in unique_per_features.items():
            emb = torch.nn.Embedding(dim.item()+1, emb_dim)
            torch.nn.init.xavier_uniform_(emb.weight.data)
            self.edge_embedding_list.append(emb)


    def forward(self, batch):

        encoded_features = 0
        for i in range(batch.edge_attr.shape[1]):
            encoded_features += self.edge_embedding_list[i](batch.edge_attr[:, i].long())

        # newedgefeatures=encoded_features.view(encoded_features.shape[0], encoded_features.shape[1]*encoded_features.shape[2])
        # print(f'edges encoded_features are {encoded_features} {encoded_features.shape} and mean(-2) {encoded_features.mean(-2)} {encoded_features.mean(-2).shape}')
        batch.edge_attr = encoded_features
        return batch

def get_edge_feature_dims(batch):
    """ edge feature is 1 in this example and is called flow which is about control, data, call types of edges"""
    unique_per_features = {}
    # number of unique values of each of the features --> dim for the input of the embedding 
    for i in range(batch.edge_attr.shape[1]):
        unique_per_features[i] = batch.edge_attr[:,i].unique().max()
    return unique_per_features