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
from collections import defaultdict
import subprocess
from RL_Planner.utils import Environment
from RL_Planner.ddqn_agent import Agent
from RL_Planner.env import Env
from RL_Planner_AC.utils import Environment
from RL_Planner_AC.ac_agent import ACAgent
from RL_Planner_AC.ac_env import ACEnv
from time import time

app = Flask(__name__)
api = Api(app)

EXEC_TIME_WEIGHT = 0.5
POWER_WEIGHT = 0.5

#print(torch.__version__)

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
        #print("task ids in nx_from_json",task_id)
        for child in task["children"]:
            task_graph.add_edge(task_id, int(child))
        
        # Create Constraints
        if task["constraint"] != '':
            parts = task["constraint"].split('-')
            constraints[task_id] = [parts[0].split('_')[1], parts[1]]
        # Decode the source code in string format


        code_encoded = task["sourceCode"]
        process = subprocess.Popen(
        ["clang++", "-emit-llvm", "-S", "-x", "c++", "-", "-o", "-"],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
        )
        llvm_ir, error = process.communicate(input=code_encoded)
        llvm_ir = llvm_ir.encode("utf-8")
        code_encoded = base64.b64encode(llvm_ir).decode()
        code_encoded = str.encode(code_encoded)
        code_encoded = base64.b64decode(code_encoded)
        code_str = code_encoded.decode()
        source_codes[task_id] = (code_str, int(task["inputData"]))
        #print(code_str)
    #print(constraints)
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
    #print("Devices_info", devices_info)
    #print("same_node_devices", same_node_devices)
    return devices_info, num_cpu, num_gpu, same_node_devices


def device_topology_info(nodes_link_json, devices_info):
    actual_links =[]
    rates_dict = {}
    nodes_links = []
    old_dict = {k: int(v['node_id'].split('_')[1]) for k, v in devices_info.items()}
    new_dict = defaultdict(list)
    for k, v in old_dict.items():
        new_dict[v].append(k)
    new_dict = dict(new_dict)
    #print("node_ID-dev_ID: ",new_dict)
    for item in nodes_link_json:
        nodes_edge_tmp =  tuple(map(int, item['linkID'].split('-')))
        nodes_edge = nodes_edge_tmp + (int(item['transferRate']),)
        nodes_links.append(nodes_edge)
    #print("NODE LINKS WITH RATES", nodes_links)
    for link in nodes_links:
        values1 = new_dict[link[0]]
        values2 = new_dict[link[1]]
        values3 = link[2]
        for v1 in values1:
            for v2 in values2:
                 actual_links.append((v1,v2))
                 #convert to MB/s
                 rates_dict[(v1,v2)] = values3*0.125
    #print("actual_links: ", actual_links)
    #print("rates_dict: ", rates_dict)

    ## to do: ftiakse tuples me devices, to rates_dict and to actual_links
    return actual_links, rates_dict



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
        #print(f"Pyg Graph of operator {operator} : {pyg_graph}")
        pyg_list.append(pyg_graph)
        #print("Operator from pyg_list:", operator)
    return pyg_list


def feasibility_check(response):
    big_M = 999999999
    flag = False
    time_calculated = float(response["objective"]["time"])
    if time_calculated > big_M:
        flag = True
    return flag

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
            #print("Constraints",constraints)
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
             
        
        nodes_link_json = args.get("networkDelays")
        actual_links, rates_dict = device_topology_info(nodes_link_json, devices_info)
        pyg_list = create_pyg_list(source_codes)
        #print("Pyg List: ", pyg_list)
        batch_loader = DataLoader(pyg_list, batch_size=len(pyg_list))
        #for step, data in enumerate(batch_loader):
        #    print(f'Step {step + 1}:')
        #    print('=======')
        #    print(f'Number of graphs in the current batch: {data.num_graphs}')
        #    print(data)
            
        predicted_times_gpu_standard = gpu_model_standard(next(iter(batch_loader)))
               
        predicted_times_cpu_standard = cpu_model_standard(next(iter(batch_loader)))
        
        # rescale the predictions 
        predicted_times_gpu_standard_real = predicted_times_gpu_standard * 0.075227 + 0.310192
        
        predicted_times_cpu_standard_real = predicted_times_cpu_standard * 29.09 + 2.71
        
        #print(f" estimates for gpu standard real: {predicted_times_gpu_standard_real}")
        #print(f" estimates for cpu standard real: {predicted_times_cpu_standard_real}")
        #print(f" Source Code Keys: {source_codes.keys()}")
        operators_id_list = list(source_codes.keys())
        
        # Calculate the execution times for each operator on each device
        operator_time_statistics, operator_average_time_statistics, operator_power_statistics, actual_operator_time_statistics, actual_operator_power_statistics = create_task_performance_statistics(operators_id_list,   predicted_times_cpu_standard_real, predicted_times_gpu_standard_real, devices_info, num_cpu, num_gpu)
   
        transfer_times, average_transfer_times, _ = create_task_transfer_times(operator_graph, num_cpu, num_gpu, same_node_devices, actual_links, rates_dict)
        
        
        EXEC_TIME_WEIGHT = float(args.get("time_weight"))
        POWER_WEIGHT = 1 - EXEC_TIME_WEIGHT
        weights = (EXEC_TIME_WEIGHT, POWER_WEIGHT)        
        #print(f"CCR: {np.mean(list(average_transfer_times.values()))/ np.mean(list(operator_average_time_statistics.values()))}")
        '''
        scheduler = HeftScheduler(operator_graph, operator_time_statistics, operator_average_time_statistics, operator_power_statistics,
                                  transfer_times, average_transfer_times, list(range(num_cpu + num_gpu)),constraints,devices_info, actual_operator_time_statistics, actual_operator_power_statistics)
        scheduling = scheduler.schedule(weights,constraints,devices_info)
        makespan = scheduler.compute_scheduling_time_execution(scheduling, flag=False)
        power = total_power_consumption(scheduling, operator_power_statistics)
        actual_score_heft = scheduler.compute_scheduling_time_execution(scheduling, flag=True) #actual finish time of HEFT placement
        actual_power_con_heft = total_power_consumption(scheduling, actual_operator_power_statistics)        
        '''
        #print("Constraints: ", constraints)
        #print("Devices info: ", devices_info)
        
        
        #'''
        score_rl = 0
        placements_rl = []
        env = ACEnv(operator_graph, operator_time_statistics, operator_average_time_statistics, operator_power_statistics,
                transfer_times, average_transfer_times, list(range(num_cpu + num_gpu)),constraints,devices_info, num_cpu, num_gpu, 
                actual_operator_time_statistics, actual_operator_power_statistics, weights)
        state_dims = 5 + num_cpu + num_gpu
        #agent = Agent(lr=0.001, gamma=0.99, epsilon=1.0, state_dims=state_dims, n_actions=len(env.action_space),
        #      batch_size=64, tau=0.05, chkpt_dir='RL_Planner/models/')
        agent = ACAgent(critic_lr=3e-3, actor_lr=3e-3, gamma=0.99, state_dims=4+num_cpu + num_gpu+3*(4+num_cpu + num_gpu), n_actions=len(env.action_space),
                chkpt_dir='RL_Planner_AC/models/', name=f'AC_300_5_network', batch_size=128)
        
        
        agent.load_models()
        observation, G, task_time_statistics, task_average_time_statistics, transfer_times, average_transfer_times, new_constraints, _  = env.reset()
        done = False
        while not done:
            action = agent.choose_action(observation)
            new_observation, reward, done = env.step(action)
            #print(f"Reward: {reward}")
            observation = new_observation
        #all_placements = env.check(done)
        #print("all_placements: ", env.all_placements)
        if len(constraints) == 0:
            if len(env.all_placements) > 1:
                first_k = next(iter(env.all_placements))
                env.all_placements.pop(first_k)
            smallest_key = min(env.all_placements.keys())
            score_rl, power_con_rl = env.makespan(env.all_placements[smallest_key], flag=False) #False for our statistics, True for the actual ones'
            actual_score_rl, actual_power_con_rl = env.makespan(env.all_placements[smallest_key], flag=True)
            placements_rl.append(env.all_placements[smallest_key])
            placement = env.all_placements[smallest_key]
        else:
            score_rl, power_con_rl = env.makespan(env.current_placement, flag=False) #False for our statistics, True for the actual ones'
            actual_score_rl, actual_power_con_rl = env.makespan(env.current_placement, flag=True)
            placements_rl.append(env.current_placement)
            placement = env.current_placement         
        
        #score_rl, power_con_rl = env.makespan(all_placements[smallest_key], flag=False)
        #actual_score_rl, actual_power_con_rl = env.makespan(all_placements[smallest_key], flag=True)
        #placements_rl.append(all_placements[smallest_key])

        response = {"placement": [], "objective": {}}
        for operator_id, device_id in placement.items():
            if operator_id not in ["n_entry", "n_exit"]:
                item = {
                      "operator_id": str(operator_id),
                      "device_id": devices_info[device_id]["nes_device_id"],
                      "node_id": devices_info[device_id]["node_id"],
                      #"device_type": devices_info[device_id]["device_type"]
                       }

                response["placement"].append(item)

        response["objective"]["time"] = str(score_rl)
        response["objective"]["actual_time"] = str(actual_score_rl)
        response["objective"]["power"] = str(power_con_rl)
        response["objective"]["actual_power"] = str(actual_power_con_rl)
        #'''
        #print(weights)
        
        '''
        print(f"RL Placements: {placements_rl}")
        print(f"RL makespan: {score_rl}")
        print(f"RL power consumption: {power_con_rl}")
        print(f"actual makespan of RL placement: {actual_score_rl}")
        print(f"actual power consumption of RL placement: {actual_power_con_rl}")
        print()
        print("==================================")
        print()
        print(f"HEFT Placements: {scheduling}")
        print(f"HEFT makespan: {makespan}")
        print(f"HEFT power consumption: {power}")
        print(f"actual makespan of HEFT placement: {actual_score_heft}")
        print(f"actual power consumption of HEFT placement: {actual_power_con_heft}")
        '''
        

        '''
        response = {"placement": [], "objective": {}}
        for operator_id, device_id in scheduling.items():
            if operator_id not in ["n_entry", "n_exit"]:
                item = {
                      "operator_id": str(operator_id),
                      "device_id": devices_info[device_id]["nes_device_id"],
                      "node_id": devices_info[device_id]["node_id"],
                      #"device_type": devices_info[device_id]["device_type"]
                       }

                response["placement"].append(item)

        response["objective"]["time"] = str(makespan)
        response["objective"]["actual_time"] = str(actual_score_heft)
        response["objective"]["power"] = str(power)
        response["objective"]["actual_power"] = str(actual_power_con_heft)
        #flag = feasibility_check(response)
        '''

        flag = False
        if flag == False:
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
        
        else:
            abort(jsonify(error='Incorrect operators constraint assignment based on network topology. Please check your constraints again.'), 400)

        ####
api.add_resource(Scheduling, "/planner/schedule")
api.add_resource(ObjectivesConfig, "/planner/configure_objectives")

if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("-p", "--port", default=8081, type=int, help="Port to listen on")
    args = parser.parse_args()
    port = args.port
    app.run(host="0.0.0.0", port=8085, debug=True)
