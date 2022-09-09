import networkx as nx
import programl as pg
from argparse import ArgumentParser
import itertools
import torch
from torch_geometric.data import Data
from torch_geometric.loader import DataLoader
from GTMcrossval_nwrap_nospatial_newparametrized import GTModel


def pyg_from_string(code_str, input_bytes):
    """
    Create the pyg graph that represents an operator from its source code.
    The llvm ir code of each operator is converted to a pyg Data object in
    the following order:
  
    LLVM IR code in str -> Programl Graph -> Networkx -> Pytorch Geometric
    (using Data class)
  
    Parameters
    ----------
    code_str: string
            LLVM IR code of operator
    input_bytes: int
            Input data size of the operator
  
    Returns
    -------
    pyg_graph : pyg data object 
            Pyg graph of the operator
  
    """
    G = pg.from_llvm_ir(code_str)
  
    # Convert graph to networkx graph   
    max_number_nodes = 0
    max_number_edges = 0
        
    NG = pg.to_networkx(G)
    NG = nx.convert_node_labels_to_integers(NG)
    NG = NG.to_directed() if not nx.is_directed(NG) else NG
    if max_number_nodes < NG.number_of_nodes():
        max_number_nodes = NG.number_of_nodes()
    if max_number_edges < NG.number_of_edges():
        max_number_edges = NG.number_of_edges()
    
    """
    The tensor defining the source and the target nodes of all edges
    create the edge_index properly - Edges in sparse COO format: set of
    tuples of connections Shape [2, num_edges]
    """       
    edge_index_list = []
    for e in NG.edges():
        source, target = e
        edge_index_list.append([source, target])
    edge_index = torch.tensor(edge_index_list, dtype=torch.long)
    edge_index = edge_index.t().contiguous()
    
    """
    Node feature matrix with shape [num_nodes, num_node_feature]
    Add to node features the rows of each corresponding measurement of
    each corresponding kernel from the dataframe
    """     
    node_attr = []
    for i, (k, features_dict) in enumerate(NG.nodes(data=True)):
        ntype = features_dict['type']
        nblock = features_dict['block']
        ninputbytes = input_bytes
        node_attr.append([ntype, nblock, ninputbytes])
    x = torch.tensor(node_attr, dtype=torch.long)
    
    # Create the edge_attr
    edge_features_list = []
    edge_types = ["control", "data", "call"]
    for i, (k, l, features_dict) in enumerate(NG.edges(data=True)):
        edge_features_list.append([features_dict['flow']])
    edge_features = torch.tensor(edge_features_list, dtype=torch.long)
    
    # Create the graph
    pyg_graph = {}
    pyg_graph = Data(x=x,        # maybe it will also need the operator id
                     edge_index=edge_index,
                     edge_attr=edge_features)
    
    return pyg_graph
    
    
def create_pyg_list(source_codes):
    """
    Create the list of pyg graphs for each operator in the application
    graph
    
    Parameters
    ----------
    source_codes: dict
            Dictionary with source codes and input data for each operator
    
    Returns
    -------
    pyg_list : list
            List with the pyg graph for each operator
    
    """
    pyg_list = []
    for operator in source_codes:
        pyg_graph = pyg_from_string(source_codes[operator][0], source_codes[operator][1])
        pyg_list.append(pyg_graph)
     
    return pyg_list

with open("tests/llvm_ir/shoc-1.1.5-Triad-Triad.ll", 'r') as f_0:
    src_0 = f_0.read()
    
with open("tests/llvm_ir/shoc-1.1.5-Sort-reduce.ll", 'r') as f_1:
    src_1 = f_1.read()
    
source_codes = {
                0: (src_0, 2000),
                1: (src_1, 1500)
               }


PATH_GPU = "gpu_model/model=GTModel_batch=16_nheads=8_hdim=64_kfold=5_lr=0.0001.pt"

PATH_CPU = "cpu_model/model=GTModel_batch=32_nheads=8_hdim=64_kfold=5_lr=0.0001.pt"

gpu_model = GTModel(num_layers=1,
                    hidden_dim=64,
                    heads=8,
                    feat_dropout=0.0,
                    top_k_pool=5,
                    norm=None)
                    
cpu_model = GTModel(num_layers=1,
                    hidden_dim=64,
                    heads=8,
                    feat_dropout=0.0,
                    top_k_pool=5,
                    norm=None)
 
gpu_model.load_state_dict(torch.load(PATH_GPU))                  
gpu_model.eval()

cpu_model.load_state_dict(torch.load(PATH_CPU)) 
cpu_model.eval()

pyg_list = create_pyg_list(source_codes)
batch_loader = DataLoader(pyg_list, batch_size=len(pyg_list))

predicted_times_gpu = gpu_model(next(iter(batch_loader)))
predicted_times_cpu = cpu_model(next(iter(batch_loader)))

print(f"estimates for gpu: {predicted_times_gpu}") 
print(f"estimates for cpu: {predicted_times_cpu}") 

