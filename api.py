from flask import Flask, jsonify, request, abort, send_file, after_this_request
from flask_restful import Api, Resource, reqparse
import json
import base64
import numpy as np
from optimizer.Heft import HeftScheduler
from optimizer.utils import create_random_DAG, insert_entry_and_exit_nodes, create_task_transfer_times, create_task_performance_statistics, total_power_consumption
import networkx as nx
import programl as pg
from argparse import ArgumentParser
import itertools
import torch
from torch_geometric.data import Data
from torch_geometric.loader import DataLoader
from GTMcrossval_nwrap_nospatial_newparametrized import GTModel
import os

app = Flask(__name__)
api = Api(app)

EXEC_TIME_WEIGHT = 0.5
POWER_WEIGHT = 0.5

print(torch.__version__)

PATH_GPU_standard = "gpu_model_standard/model=GTModel_batch=32_nheads=8_hdim=64_kfold=5_lr=0.0001.pt"

PATH_CPU_standard = "cpu_model_standard/model=GTModel_batch=32_nheads=8_hdim=64_kfold=5_lr=0.0001.pt"

gpu_model_standard = GTModel(num_layers=1,
                    	     hidden_dim=64,
                             heads=8,
                             feat_dropout=0.0,
                             top_k_pool=5,
                             norm=None)
                             
cpu_model_standard = GTModel(num_layers=1,
                    	     hidden_dim=64,
                             heads=8,
                             feat_dropout=0.0,
                             top_k_pool=5,
                             norm=None)
                             
 
gpu_model_standard.load_state_dict(torch.load(PATH_GPU_standard))                  
gpu_model_standard.eval()

cpu_model_standard.load_state_dict(torch.load(PATH_CPU_standard))                  
cpu_model_standard.eval()


def nx_from_json(task_graph_json):
    """
    Convert the task graph from json format to networkx graph and store the
    source code of each task in a dictionary
    and create constraints dictionary

    Parameters
    ----------
    task_graph_json : list
            List with info for each task in the task graph

    Returns
    -------
    task_graph : networkx graph
            The DAG representing the tasks to be scheduled
    source_codes : dict
            Dictionary with the operator id's int integer format as keys and
            tuples with their source code and input data size as values
    constraints : dict
            Dictionary with operator id's int integer format as key and node id             that the task must be executed to, as defined by the user, as value
    """
    task_graph = nx.DiGraph()
    source_codes = {}
    constraints = {}
    for task in task_graph_json:
        # Create the graph
        task_id = int(task["operatorId"])
        task_graph.add_node(task_id)
        print("task ids in nx_from_json",task_id)
        for child in task["children"]:
            task_graph.add_edge(task_id, int(child))
        
        # Create Constraints
        if task["constraint"] != '':
            constraints[task_id] = int(''.join(filter(str.isdigit, task["constraint"])))
        # Decode the source code in string format
        code_encoded = task["sourceCode"]
        code_encoded = str.encode(code_encoded)
        code_encoded = base64.b64decode(code_encoded)
        code_str = code_encoded.decode()
        
        source_codes[task_id] = (code_str, int(task["inputData"]))
        
    return task_graph, source_codes, constraints

def device_info_from_json(nodes_json):
    """
    Collect info about the available devices

    Parameters
    ----------
    nodes_json : list
            List with info for each available node and its devices

    Returns
    -------
    devices_info : dict
            Dictionary with information for each available device
    num_cpu: int
            Number of available CPUs
    num_gpu: int
            Number of available GPUs
    same_node_devices: set
            Set with device pairs that are on the same node
    """
    num_cpu = 0
    num_gpu = 0
    device_key = 0
    same_node_devices = []

    devices_info = {}
    for node in nodes_json:
        node_id = node["nodeId"]
        current_node_devices = []
        for device in node["devices"]:
            device_info = {}
            device_id = device_key
            current_node_devices.append(device_id)

            # Create the dictionary with info for each device
            device_info["node_id"] = node_id
            device_info["nes_device_id"] = device["deviceId"]
            device_info["device_type"] = device["deviceType"]
            device_info["model_name"] = device["modelName"]
            device_info["memory"] = device["memory"]

            # Add this device to the total collection of devices
            devices_info[device_id] = device_info
            device_key += 1

            if device["deviceType"] == "CPU":
                num_cpu += 1
            else:
                num_gpu += 1

        same_node_devices += list(itertools.combinations(current_node_devices, 2))
        current_node_devices.reverse()  # add the reverse links
        same_node_devices += list(itertools.combinations(current_node_devices, 2))

    same_node_devices = set(same_node_devices)
    print("Devices_info", devices_info)
    print("same_node_devices", same_node_devices)
    return devices_info, num_cpu, num_gpu, same_node_devices
    
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
        print(f"Pyg Graph of operator {operator} : {pyg_graph}")
        pyg_list.append(pyg_graph)
        print("Operator from pyg_list:", operator)
    return pyg_list
    
    
class ObjectivesConfig(Resource):
    def post(self):
        global EXEC_TIME_WEIGHT
        global POWER_WEIGHT

        args = request.get_json()
        time = args.get("execTime")
        power = args.get("power")

        if time is None:
            abort(400, description="Invalid request data: missing execTime")
        if power is None:
            abort(400, description="Invalid request data: missing power")
        if time + power != 1.0:
            abort(400, description="Invalid form of request data: execTime and power don't sum up to 1")

        EXEC_TIME_WEIGHT = time
        POWER_WEIGHT = power

        return {"message": "Weights configured succesfully"}, 200


class Scheduling(Resource):
    def post(self):
        # Parse arguments from request object
        args = request.get_json(force=False, silent=True)
        # Get the operator graph and transform it to networkx
        task_graph_json = args.get("operatorGraph")
        if task_graph_json is None:
            abort(400, description="Invalid form of request data: operatorGraph argument missing")

        try:
            operator_graph, source_codes, constraints = nx_from_json(task_graph_json)
            print("Constraints",constraints)
            operator_graph = insert_entry_and_exit_nodes(operator_graph)
        except:
            abort(400, description="Invalid form of request data in the operatorGraph")


        # Get the available nodes and the information for their devices
        nodes_json = args.get("availNodes")
        if nodes_json is None:
            abort(400, description="Invalid form of request data: availNodes argument missing")

        try:
            devices_info, num_cpu, num_gpu, same_node_devices = device_info_from_json(nodes_json)
        except:
            abort(400, description="Invalid form of request data in availNodes")
             
        pyg_list = create_pyg_list(source_codes)
        print("Pyg List: ", pyg_list)
        batch_loader = DataLoader(pyg_list, batch_size=len(pyg_list))
        for step, data in enumerate(batch_loader):
            print(f'Step {step + 1}:')
            print('=======')
            print(f'Number of graphs in the current batch: {data.num_graphs}')
            print(data)
            
        predicted_times_gpu_standard = gpu_model_standard(next(iter(batch_loader)))
               
        predicted_times_cpu_standard = cpu_model_standard(next(iter(batch_loader)))
        
        # rescale the predictions 
        predicted_times_gpu_standard_real = predicted_times_gpu_standard * 0.075227 + 0.310192
        
        predicted_times_cpu_standard_real = predicted_times_cpu_standard * 29.09 + 2.71
        
        print(f" estimates for gpu standard real: {predicted_times_gpu_standard_real}")
        print(f" estimates for cpu standard real: {predicted_times_cpu_standard_real}")
        print(f" Source Code Keys: {source_codes.keys()}")
        operators_id_list = list(source_codes.keys())
        
        # Calculate the execution times for each operator on each device
        operator_time_statistics, operator_average_time_statistics, operator_power_statistics = create_task_performance_statistics(operators_id_list,   predicted_times_cpu_standard_real, predicted_times_gpu_standard_real, devices_info, num_cpu, num_gpu)
   
        transfer_times, average_transfer_times, _ = create_task_transfer_times(operator_graph, num_cpu, num_gpu, same_node_devices)
        
        print(f"CCR: {np.mean(list(average_transfer_times.values()))/ np.mean(list(operator_average_time_statistics.values()))}")
        
        scheduler = HeftScheduler(operator_graph, operator_time_statistics, operator_average_time_statistics, operator_power_statistics,
                                  transfer_times, average_transfer_times, list(range(num_cpu + num_gpu)),constraints,devices_info)

       
        weights = (EXEC_TIME_WEIGHT, POWER_WEIGHT)
        scheduling = scheduler.schedule(weights,constraints,devices_info)
        makespan = scheduler.aft["n_exit"]
        power = total_power_consumption(scheduling, operator_power_statistics)

        response = {"placement": [], "objective": {}}
        for operator_id, device_id in scheduling.items():
            if operator_id not in ["n_entry", "n_exit"]:
                item = {
                      "operator_id": str(operator_id),
                      "device_id": devices_info[device_id]["nes_device_id"],
                      "node_id": devices_info[device_id]["node_id"],
                      "device_type": devices_info[device_id]["device_type"]
                       }

                response["placement"].append(item)

        response["objective"]["time"] = str(makespan)
        response["objective"]["power"] = str(power)
        ####
        filename = 'response.json'
        with open(filename,'w') as f:
            json.dump(response,f)
        
        @after_this_request
        def remove_file(response):
            try:
                os.remove(filename)
            except Exception as error:
                app.logger.error("Error removing response file", error)
            return response

        return send_file(filename,mimetype='application/json')

        ####
api.add_resource(Scheduling, "/planner/schedule")
api.add_resource(ObjectivesConfig, "/planner/configure_objectives")

if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("-p", "--port", default=8080, type=int, help="Port to listen on")
    args = parser.parse_args()
    port = args.port

    app.run(host="127.0.0.1", port=port, debug=True)
