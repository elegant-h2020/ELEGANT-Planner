import matplotlib.pyplot as plt
import random
import numpy as np
import networkx as nx
from queue import PriorityQueue
import itertools
import time
import pprint
import os
import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
from torch.distributions.categorical import Categorical
from torch.utils.data import Subset
import torch_geometric
from torch_geometric.utils.convert import from_networkx
from torch_geometric.data import Data
from torch_geometric.loader import DataLoader
from torch_geometric.nn import GCNConv, GATv2Conv
from torch_geometric.nn import global_mean_pool, global_add_pool, global_max_pool

class Environment():
  """
  Simulation of the scheduling environment
  """
  def __init__(self, num_devices, num_cpu, num_gpu):
    self.num_devices = num_devices
    self.num_cpu = num_cpu
    self.num_gpu = num_gpu
    self.action_space = np.array(range(num_devices))
    self.device_utilization = [0] * num_devices

  def create_random_DAG(self, nodes, edges):
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

  def create_specified_chains_dag(self, num_nodes, num_edges, num_chains):
      """
      Creates a multi-chain directed acyclic graph (DAG) with a specified number of chains, each having equal or almost equal length.

      Parameters:
      num_nodes (int): Number of nodes in the graph.
      num_edges (int): Number of edges in the graph.
      num_chains (int): Number of chains to be created in the graph.

      Returns:
      G (networkx.DiGraph): A multi-chain DAG with the specified number of nodes, edges, and chains.
      """
      # Check if the number of edges and chains is appropriate
      if num_edges > num_nodes - 1 or num_chains > num_nodes:
          raise ValueError("Number of edges must be less than or equal to number of nodes - 1, and number of chains must be less than or equal to number of nodes.")

      if num_chains == 0:
          raise ValueError("Number of chains must be at least 1.")

      # Calculate the approximate length of each chain
      chain_length = num_nodes // num_chains
      extra_nodes = num_nodes % num_chains

      # Create a directed graph
      G = nx.DiGraph()

      # Add nodes
      G.add_nodes_from(range(num_nodes))

      # Add edges to form chains of equal or almost equal length
      edges_added = 0
      current_node = 0
      for chain in range(num_chains):
          # Adjust length for this chain if there are extra nodes
          current_chain_length = chain_length + (1 if extra_nodes > 0 else 0)
          extra_nodes -= 1

          # Add edges for the current chain
          for i in range(current_chain_length - 1):
              if edges_added < num_edges:
                  G.add_edge(current_node + i, current_node + i + 1)
                  edges_added += 1

          current_node += current_chain_length

      return G

  def create_random_chain_dag(self, num_nodes, num_edges):
      """
      Creates a random chain directed acyclic graph (DAG) using the networkx library.

      Parameters:
      num_nodes (int): Number of nodes in the graph.
      num_edges (int): Number of edges in the graph.

      Returns:
      G (networkx.DiGraph): A random chain DAG with the specified number of nodes and edges.
      """
      # Check if the number of edges is appropriate
      if num_edges > num_nodes - 1:
          raise ValueError("Number of edges must be less than or equal to number of nodes - 1.")

      # Create a directed graph
      G = nx.DiGraph()

      # Add nodes
      G.add_nodes_from(range(num_nodes))

      # Add edges randomly to form chains
      edges_added = 0
      while edges_added < num_edges:
          # Randomly pick a source and target node for the edge
          source, target = random.sample(range(num_nodes), 2)

          # Add the edge if it doesn't create a cycle and doesn't already exist
          if not nx.has_path(G, target, source) and not G.has_edge(source, target):
              G.add_edge(source, target)
              edges_added += 1

      return G



  def insert_entry_and_exit_nodes(self, G):
    """
    Connect entry nodes with n_entry and exit nodes with n_exit
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


  def create_task_transfer_times(self, G):
    """
    Creates the communication costs for all tasks and
    all pairs of available devices
    """

    devices = list(range(self.num_devices))

    # Create a pair for every device combination
    device_combinations = []
    device_combinations = list(itertools.combinations_with_replacement(devices, 2))

    # Add the reverse links
    devices.reverse()
    device_combinations += list(itertools.combinations_with_replacement(devices, 2))
    device_combinations = set(device_combinations)

    transfer_rates = {}

    # Create transfer rates for all device pairs
    for link in device_combinations:
        # Assign non zero rates only for different device pairs
        if link != link[::-1]:
            # check if teh reverse link is already inserted
            if link[::-1] not in transfer_rates.keys():
                rate = random.uniform(5, 100)
                transfer_rates[link] = rate  # transfer rates in MB/s
            else:
                # Assign the same value with its reverse link
                transfer_rates[link] = transfer_rates[link[::-1]]
        else:
            # zero transfer rate if the devices are the same
            transfer_rates[link] = 0

    # Average transfer rate of all device pairs
    average_transfer_rate = np.mean(list(transfer_rates.values()))

    transfer_times = {}
    average_transfer_times = {}
    data_sent_dict = {}

    # Calculate communication costs between tasks in the graph
    # 1. The average communication cost between all tasks with a dependencie
    # 2. The communication cost between all tasks with a dependencie and on every
    #    combination of possible device placements for that tasks
    for edge in G.edges():
        # Add zero transfer times to edges connected to entry node
        if edge[0] == "n_entry" or edge[1] == "n_exit":
            transfer_times[edge] = {link: 0 for link in device_combinations}
            average_transfer_times[edge] = 0
        else:
            data_sent = random.uniform(5, 20)  # data transmitted between tasks in MB
            data_sent_dict[edge] = data_sent
            # zero transfer times if both tasks executed on the same device
            transfer_times[edge] = {link: 0 if link == link[::-1] else data_sent/transfer_rates[link] for link in device_combinations}
            average_transfer_times[edge] = data_sent / average_transfer_rate

    return transfer_times, average_transfer_times, transfer_rates


  def create_task_performance_statistics(self, num_tasks):
    """
    task_statistics: Dictionary with executions times of all tasks for all devices
    average_task_statistics: Dictionary with average execution time of all tasks across all devices
    task_power_consuption : Dictionary with power consumption of all tasks for all devices
    """

    num_cpu = self.num_cpu
    num_gpu = self.num_gpu


    #num_cpu = int(self.num_devices-1)
    #num_gpu = int(1)

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
        random.seed(52)
        cpu_times = np.array([random.uniform(1, 10) for j in range(num_cpu)])  # 5 - 10 sec execution times
        mean_cpu_time = np.mean(cpu_times)
        gpu_times = np.array([mean_cpu_time / random.randint(3, 4) for j in range(num_gpu)])

        cpu_power_consumption = np.array([random.uniform(50, 100) for j in range(num_cpu)])
        mean_cpu_power_consumption = np.mean(cpu_power_consumption)
        gpu_power_consumption = np.array([mean_cpu_power_consumption * random.uniform(3, 4) for j in range(num_gpu)])

        key = i
        value = np.concatenate((cpu_times, gpu_times))
        average_value = np.mean(value)
        task_statistics[key] = value
        average_task_statistics[key] = average_value
        task_power_statistics[key] = np.concatenate((cpu_power_consumption, gpu_power_consumption))

    return task_statistics, average_task_statistics, task_power_statistics


  def upward_rank(self):
    """
    Returns a dictionary with the upward rank value for each task
    """
    upward_rank = {}
    upward_rank["n_exit"] = self.task_average_time_statistics["n_exit"]

    topological_order = list(nx.topological_sort(self.task_graph))

    # Traverse the topological sort in inverse order to compute upward rank of nodes
    for i in range(len(topological_order) - 2, -1, -1):
        # Traverse from last node excluding "n_exit" to "n_entry"
        node = topological_order[i]
        successors = list(self.task_graph.successors(node))
        successor_ranks = np.array([upward_rank[succ_node] for succ_node in successors])
        transfer_time_with_successors = np.array([self.average_transfer_times[(node, succ_node)] for succ_node in successors])
        combined = successor_ranks + transfer_time_with_successors
        best = np.max(combined)
        rank = self.task_average_time_statistics[node] + best

        upward_rank[node] = rank

    return upward_rank


  def downward_rank(self):
    """
    Returns a dictionary with the downward rank value for each task
    """
    downward_rank = {}
    downward_rank["n_entry"] = 0

    for i in range(len(self.topological_order)):
        node = self.topological_order[i]
        if node == "n_entry":
            continue
        else:
            predecessors = list(self.task_graph.predecessors(node))
            predecessor_ranks = np.array([downward_rank[pred_node] for pred_node in predecessors])
            transfer_time_with_predecessors = np.array([self.average_transfer_times[(pred_node, node)] for pred_node in predecessors])
            execution_times_of_predecessors = np.array([self.task_average_time_statistics[pred_node] for pred_node in predecessors])
            combined = predecessor_ranks + transfer_time_with_predecessors + execution_times_of_predecessors
            best = np.max(combined)
            downward_rank[node] = best

    return downward_rank


  def prioritize_tasks(self):
    """
    Creates a priority queue of the tasks in nonincreasing order
    Contains tuples of (-rank of task, task) because we want decreasing order
    task is a string
    """
    unscheduled_tasks = PriorityQueue()

    for task in self.topological_order:
      if task == "n_entry":
        unscheduled_tasks.put((-self.rank_u[task], "-" + task)) # we want n_entry to be before the first task with the same rank
      else:
        unscheduled_tasks.put((-self.rank_u[task], str(task)))

    return unscheduled_tasks


  def makespan(self, scheduling):
    """
    Computes the execution time of a given scheduling
    """
    avail = [0] * self.num_devices # list with the time that each device is available
    aft = {}
    aft["n_entry"] = 0

    # Task priorities based on upward rank
    priority_list = sorted(self.rank_u, key=lambda k: self.rank_u[k], reverse=True)
    # Remove n_entry and put it back in the start of the list
    priority_list.remove("n_entry")
    priority_list = ["n_entry"] + priority_list

    #print(f"Priority list: {priority_list}")
    #print(f"rank of first and decond tasks: {self.rank[priority_list[0]]} and {self.rank[priority_list[1]]}")

    for task in priority_list[1:]: # exclude "n_entry"
        device = scheduling[task]
        device_avail_time = avail[device]
        pred_tasks = list(self.task_graph.predecessors(task))
        max_ready_time = -1
        # Compute max ready time
        for pred in pred_tasks:
          pred_device = scheduling[pred]
          # Use the actual transfer times
          #print(f"Previous task: {pred} with type {type(pred)}")
          #print(f"Current task: {task} with type {type(pred)}")
          #print(f" Previous device: {pred_device} with type {type(pred_device)}")
          #print(f" Current device: {device} with type {type(device)}")
          #print(self.transfer_times[(pred, task)][(pred_device, device)])
          #print(aft[pred])
          ready_time = aft[pred] + self.transfer_times[(pred, task)][(pred_device, device)]
          if ready_time > max_ready_time:
            max_ready_time = ready_time

        # Compute finish time of task and update values
        start_time = max(device_avail_time, max_ready_time)
        finish_time = start_time + self.task_time_statistics[task][device]
        aft[task] = finish_time
        avail[device] = finish_time

    for task, device in scheduling.items():
      task_duration = self.task_time_statistics[task][device]
      self.device_utilization[device] += task_duration



    total_execution_time = aft["n_exit"]

    return total_execution_time


  def calculate_idle_time(self):
    # Assuming first half of devices are CPUs
    num_cpu = self.num_devices // 2
    max_time = max(self.device_utilization)
    idle_time_cpu = sum([max_time - self.device_utilization[i] for i in range(num_cpu)])
    return idle_time_cpu



  def initial_task_embeddings(self):
    """
    For each task its embedding is a vector of six elements:

      1. Average execution time
      2. Upward rank
      3. Dwonward rank
      4. Flag indicating if it is visited
      5. Flag indicating if it is the task to be scheduled at current time
      6. Current device placement in one hot encoding

    """
    embeddings = {}
    for task in self.topological_order:
      exec_time = 0#self.task_average_time_statistics[task]
      rank_up = self.rank_u[task]
      rank_down = self.rank_d[task]
      visited = 0
      current = 0
      exec_device = self.current_placement[task]
      exec_device_one_hot = [0] * self.num_devices
      exec_device_one_hot[exec_device] = 1

      embedding = [exec_time] + [rank_up] + [rank_down] + [visited] + [current] + exec_device_one_hot
      embedding = np.array(embedding)
      embeddings[task] = embedding

    # Assign current = 1 to the first task in priority queue except n_entry
    temp1 = self.task_priority.get()
    temp2 = self.task_priority.get()
    first_task = int(temp2[1])
    embeddings[first_task][4] = 1
    self.current_task = first_task  # assign the first task as the current task for the 1st iteration (don't know if n_entry is needed)

    return embeddings


  def reset(self):
    """
    Resets the environment and returns an initial observation
    which is a PyG Data object that represents current state of the task graph
    """
    #num_nodes = np.random.choice(range(10, 40)) # random number of tasks between [5, 15]
    random.seed(111111)
    num_nodes = random.randint(10, 50)
    
    #graph_density = 2
    #graph_density = np.random.choice([1.5, 2])
    #num_edges = num_nodes * graph_density
    #num_edges = random.randint(num_nodes, 2 * num_nodes)
    
    num_edges = num_nodes - 1
    num_chains = random.randint(2, 10)


    # Create the graph that will be scheduled

    #self.task_graph = self.create_random_DAG(num_nodes, num_edges)

    self.task_graph = self.create_specified_chains_dag(num_nodes, num_edges, num_chains)
    #self.task_graph = self.create_random_chain_dag(num_nodes, num_edges)
    self.task_graph = self.insert_entry_and_exit_nodes(self.task_graph)
    self.topological_order = list(nx.topological_sort(self.task_graph))

    # Create task graph transfer times
    self.transfer_times, self.average_transfer_times, _ = self.create_task_transfer_times(self.task_graph)

    # Create statistics for each task in the graph
    self.total_task_statistics = self.create_task_performance_statistics(num_nodes)
    self.task_time_statistics = self.total_task_statistics[0]
    self.task_average_time_statistics = self.total_task_statistics[1]
    self.task_power_statistics = self.total_task_statistics[2]

    # Create an initial random assignment of tasks to devices
    #self.current_placement = np.random.choice(range(self.num_devices), num_nodes)
    self.current_placement = np.array([3]*num_nodes)
    self.current_placement = dict(enumerate(self.current_placement))  # conversion to dict for compatibility reasons
    self.current_placement["n_entry"] = np.random.choice(range(self.num_devices))
    self.current_placement["n_exit"] = np.random.choice(range(self.num_devices))

    # Calculate the current makespan
    #self.current_makespan = self.makespan(self.current_placement)
    self.current_makespan = 0  # first makespan = 0
    self.device_utilization = [0] * self.num_devices  # hmmm
    # Calculate upward and downward rank for each task
    # Choose to update each task according to the non-increasing
    # order of upward rank, instead of choosing each node randomly
    self.rank_u = self.upward_rank()
    self.rank_d = self.downward_rank()
    self.task_priority = self.prioritize_tasks() # n_entry and n_exit must be excluded from the priority queue

    # Create initial task features
    self.task_features = self.initial_task_embeddings()
    nx.set_node_attributes(self.task_graph, values=self.task_features, name="x")
    nx.set_edge_attributes(self.task_graph, values=self.average_transfer_times, name="edge_weight")

    # Convert to pytorch geometric data object
    pyg_graph = from_networkx(self.task_graph)
    self.state = pyg_graph

    return self.state, self.task_graph, self.task_time_statistics, self.task_average_time_statistics, self.transfer_times, self.average_transfer_times


  def step(self, action):
    """
    Performs the state update given an action in one hot encoding and returns:

      1. the next state
      2. the observed reward
      3. a flag indicating if the new state is terminal

    """
    action_to_int = np.argmax(action)
    # Update the device placement for the current task
    self.current_placement[self.current_task] = action_to_int

    # Calculate reward
    new_makespan = self.makespan(self.current_placement)
    idle_time_cpu = self.calculate_idle_time()
    alpha = 0.0001
    # zero reward in first action for stability reasons
    if self.current_makespan == 0:
      reward = 0
    else:
      reward = -(new_makespan - self.current_makespan) #- alpha * idle_time_cpu
    self.current_makespan = new_makespan

    # It hasn't been done very efficiently (could change directly the attributes on the graph)
    # Change the info for the already scheduled task

    # Change the first feature with total makespan so far (and dont take into account unvisited nodes)
    #
    self.task_features[self.current_task][0] = self.current_makespan
    self.task_features[self.current_task][3] = 1         # change to visited
    self.task_features[self.current_task][4] = 0         # not the current anymore
    self.task_features[self.current_task][5:] = action  # change the device placement

    # Change the info for the new task to be scheduled
    self.current_task = self.task_priority.get()[1]
    if self.current_task != "n_exit":
      self.current_task =int(self.current_task)
    self.task_features[self.current_task][4] = 1

    # Add features to task_graph and convert to pyg graph
    nx.set_node_attributes(self.task_graph, values=self.task_features, name="x")
    pyg_graph = from_networkx(self.task_graph)

    self.state = pyg_graph

    done = (self.current_task == "n_exit")

    return self.state, reward, done