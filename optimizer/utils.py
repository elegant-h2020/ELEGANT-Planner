import random
import numpy as np
import networkx as nx
import itertools


def create_task_performance_statistics(operators_id_list,   predicted_times_cpu_standard_real, predicted_times_gpu_standard_real, devices_info, num_cpu, num_gpu):
    """
    """
    operator_time_statistics = {}
    operator_average_time_statistics = {}
    operator_power_statistics = {}
    
    # Add zero execution times and powers for entry and exit nodes
    operator_time_statistics["n_entry"] = np.zeros(num_cpu + num_gpu)
    operator_time_statistics["n_exit"] = np.zeros(num_cpu + num_gpu)
    operator_average_time_statistics["n_entry"] = 0
    operator_average_time_statistics["n_exit"] = 0
    operator_power_statistics["n_entry"] = 0
    operator_power_statistics["n_exit"] = 0
    #print("Operators ID list:", operators_id_list)
    #print("Pred cpu time vector: ",predicted_times_cpu_standard_real, type(predicted_times_cpu_standard_real))
    
    #========== additions to fix tensor indexing problem ======# -x 
    pred_cpu_list = predicted_times_cpu_standard_real.flatten().tolist()
    pred_gpu_list = predicted_times_gpu_standard_real.flatten().tolist()
    pred_cpu_dict = dict(map(lambda i,j : (i,j), operators_id_list, pred_cpu_list)) #could be one dict -x
    pred_gpu_dict = dict(map(lambda i,j : (i,j), operators_id_list, pred_gpu_list))
    #print(pred_cpu_dict)
    #for device_id in range(num_cpu+num_gpu): # what is happening with devices ID? -x
        #print("Device ID: ", device_id) 
    
    for operator_id in operators_id_list:
        #print("Pred time item: ", predicted_times_cpu_standard_real[operator_id].item(), "Operator ID: ", operator_id)
        #print("Pred time from dict: ", pred_cpu_dict[operator_id], "Operator ID: ",operator_id)
        #========# -x
        stats = [pred_cpu_dict[operator_id] if devices_info[device_id]["device_type"] == "CPU" else pred_gpu_dict[operator_id] for device_id in range(num_cpu+num_gpu)]
        #========#

        operator_time_statistics[operator_id] = np.array(stats)
        operator_average_time_statistics[operator_id] = np.mean(stats)
        
        power_stats = [105 if devices_info[device_id]["device_type"] == "CPU" else 120 for device_id in range(num_cpu+num_gpu)]
        operator_power_statistics[operator_id] = np.array(power_stats)
        
            
    #print(f"task statistics: {operator_time_statistics}")
    #print(f"average time statistics: {operator_average_time_statistics}")
    #print(f"task power statistics: {operator_power_statistics}")
        
    return operator_time_statistics, operator_average_time_statistics, operator_power_statistics

def create_task_performance_statistics_simulated(num_tasks, num_cpu, num_gpu):
    """
    task_statistics: Dictionary with executions times of all tasks for all devices
    average_task_statistics: Dictionary with average execution time of all tasks across all devices
    task_power_consuption : Dictionary with power consumption of all tasks for all devices
    """

    task_statistics = {}
    average_task_statistics = {}
    task_power_statistics = {}

    # Add zero execution times for entry and exit nodes
    task_statistics["n_entry"] = np.zeros(num_cpu + num_gpu)
    task_statistics["n_exit"] = np.zeros(num_cpu + num_gpu)
    average_task_statistics["n_entry"] = 0
    average_task_statistics["n_exit"] = 0
    task_power_statistics["n_entry"] = 0
    task_power_statistics["n_exit"] = 0

    for i in range(num_tasks):
        cpu_times = np.array([random.uniform(5, 10) for j in range(num_cpu)])  # 5 - 10 sec execution times
        mean_cpu_time = np.mean(cpu_times)
        gpu_times = np.array([mean_cpu_time / random.randint(3, 4) for j in range(num_gpu)])

        cpu_power_consumption = np.array([random.uniform(0, 1) for j in range(num_cpu)])
        mean_cpu_power_consumption = np.mean(cpu_power_consumption)
        gpu_power_consumption = np.array([mean_cpu_power_consumption * random.uniform(3, 4) for j in range(num_gpu)])

        key = i
        value = np.concatenate((cpu_times, gpu_times))
        average_value = np.mean(value)
        task_statistics[key] = value
        average_task_statistics[key] = average_value
        task_power_statistics[key] = np.concatenate((cpu_power_consumption, gpu_power_consumption))

    return task_statistics, average_task_statistics, task_power_statistics


def create_task_transfer_times(G, num_cpu, num_gpu, same_node_devices, actual_links, rates_dict):
    """
    Creates the communication costs for all tasks and
    all pairs of available devices
    """

    devices = list(range(num_cpu+num_gpu))

    # Create a pair for every device combination
    device_combinations = []
    device_combinations = list(itertools.combinations_with_replacement(devices, 2))
    # Add the reverse links
    devices.reverse()
    device_combinations += list(itertools.combinations_with_replacement(devices, 2))
    imaginary_device_combinations = [x for x in device_combinations if x not in actual_links]
    device_combinations = set(device_combinations)
    transfer_rates = rates_dict
    #print("Zeygh suskeuwn",device_combinations)
    for link in imaginary_device_combinations:
                transfer_rates[link] = 0  # these links do not actually exist
    #print("TRANSFER RATES: ", transfer_rates)
    # Average transfer rate among available devices
    transfer_rate_list = list(rates_dict.values()) 
    average_transfer_rate = np.mean(transfer_rate_list) # avg of the actual transfer rates

    transfer_times = {}
    average_transfer_times = {}
    data_sent_dict = {}
    big_M = 999999999

    # Calculate communication costs between tasks in the graph
    # 1. The average communication cost between all tasks with a dependency
    # 2. The communication cost between all tasks with a dependency and on every
    #    combination of possible device placements for that tasks
    for edge in G.edges():
        # Add zero transfer times to edges connected to entry node
        if edge[0] == "n_entry" or edge[1] == "n_exit":
            transfer_times[edge] = {link: 0 for link in device_combinations}
            average_transfer_times[edge] = 0
        else:
            data_sent = random.uniform(0, 10)  # data transmitted between tasks in MB
            data_sent_dict[edge] = data_sent
            # zero transfer times if both tasks executed on the same device or devices of same node
            transfer_times[edge] = {link: 0 if (link == link[::-1] or link in same_node_devices) else data_sent/transfer_rates[link] if transfer_rates[link] != 0 else big_M for link in transfer_rates}
            average_transfer_times[edge] = data_sent / average_transfer_rate
        #print("Edge name: ", edge)
        #print("transfer_times[edge]: ",transfer_times[edge])

    return transfer_times, average_transfer_times, transfer_rates


def create_random_DAG(nodes, edges):
    """
    Generate a random Directed Acyclic Graph (DAG) with a given number of nodes and edges.
    """
    G = nx.DiGraph()
    for i in range(nodes):
        G.add_node(i)

    while edges > 0:
        a = random.randint(0, nodes-1)
        b = a

        while b == a:
            b = random.randint(0, nodes-1)
        G.add_edge(a, b)

        if nx.is_directed_acyclic_graph(G):
            edges -= 1
        else:
            # we closed a loop!
            G.remove_edge(a, b)

    return G


def insert_entry_and_exit_nodes(G):
    """
    Connect root and leaf nodes with virual nodes n_entry
    and n_exit respectively

    Attributes
    ----------
    G: networkx graph
            The task graph

    Returns
    -------
    G: networkx graph
            The task graph enriched with the vitual nodes
    """
    # Find all entry nodes
    entries = [node for node in G.nodes() if len(list(G.predecessors(node))) == 0]
    # Find all exit nodes
    exits = [node for node in G.nodes() if len(list(G.successors(node))) == 0]

    for node in entries:
        G.add_edge("n_entry", node)

    for node in exits:
        G.add_edge(node, "n_exit")

    return G


def total_power_consumption(schedule, task_power_statistics):
    """
    Computes the power consumption of a given scheduling plan

    Attributes
    ----------
    schedule: dict
            The device placement of each task
    task_power_statistics: dict
            Power consumption for each task on each device

    Returns
    -------
    power: real
            Power consumption of the scheduling
    """
    power = 0
    for task in schedule:
        if task == "n_entry" or task == "n_exit":
            continue

        power += task_power_statistics[task][schedule[task]]

    return power
