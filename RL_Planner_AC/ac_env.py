import matplotlib.pyplot as plt
import random
import numpy as np
import networkx as nx
from queue import PriorityQueue
from torch.utils.data import Subset
from optimizer.Heft import HeftScheduler
from optimizer.utils import total_power_consumption
import copy

class ACEnv():
  """
  Simulation of the scheduling environment
  """
  def __init__(self, operator_graph, operator_time_statistics, operator_average_time_statistics, operator_power_statistics,
                                  transfer_times, average_transfer_times, available_devices, constraints, devices_info, num_cpu, num_gpu, actual_operator_time_statistics, actual_operator_power_statistics, weights):
    self.operator_graph = operator_graph
    self.operator_time_statistics = operator_time_statistics
    self.operator_average_time_statistics = operator_average_time_statistics
    self.operator_power_statistics = operator_power_statistics
    self.transfer_times = transfer_times
    self.average_transfer_times = average_transfer_times
    self.available_devices = available_devices
    self.num_devices = len(available_devices)
    self.constraints = constraints
    self.devices_info = devices_info
    self.action_space = np.array(range(self.num_devices))
    self.device_utilization = [0] * self.num_devices
    self.num_cpu = num_cpu
    self.num_gpu = num_gpu
    self.actual_operator_time_statistics = actual_operator_time_statistics
    self.actual_operator_power_statistics = actual_operator_power_statistics
    self.weights = weights

  def upward_rank(self):
    """
    Returns a dictionary with the upward rank value for each task
    """
    upward_rank = {}
    upward_rank["n_exit"] =  self.operator_average_time_statistics["n_exit"]

    topological_order = list(nx.topological_sort(self.operator_graph))

    # Traverse the topological sort in inverse order to compute upward rank of nodes
    for i in range(len(topological_order) - 2, -1, -1):
        # Traverse from last node excluding "n_exit" to "n_entry"
        node = topological_order[i]
        successors = list(self.operator_graph.successors(node))
        successor_ranks = np.array([upward_rank[succ_node] for succ_node in successors])
        transfer_time_with_successors = np.array([self.average_transfer_times[(node, succ_node)] for succ_node in successors])
        combined = successor_ranks + transfer_time_with_successors
        best = np.max(combined)
        rank = self.operator_average_time_statistics[node] + best

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
            predecessors = list(self.operator_graph.predecessors(node))
            predecessor_ranks = np.array([downward_rank[pred_node] for pred_node in predecessors])
            transfer_time_with_predecessors = np.array([self.average_transfer_times[(pred_node, node)] for pred_node in predecessors])
            execution_times_of_predecessors = np.array([self.operator_average_time_statistics[pred_node] for pred_node in predecessors])
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

  def check(self, done):
    if done == True:
      return self.all_placements


  def makespan(self, scheduling, flag):
    """
    Computes the execution time of a given scheduling
    """
    avail = [0] * self.num_devices # list with the time that each device is available
    aft = {}
    aft["n_entry"] = 0
    total_power_consumption = 0
    priority_list = list(scheduling.keys()) # Task priorities based on upward rank, already calculated from HEFT
    
    for task in priority_list[1:]: # exclude "n_entry"
        device = scheduling[task]
        device_avail_time = avail[device]
        pred_tasks = list(self.operator_graph.predecessors(task))
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
        if flag == False:
          #print("task: ", task, self.operator_time_statistics[task][device])
          finish_time = start_time + self.operator_time_statistics[task][device]
        else:
          finish_time = start_time + self.actual_operator_time_statistics[task][device]
        aft[task] = finish_time
        avail[device] = finish_time

    for task, device in scheduling.items():
      if task == "n_entry" or task == "n_exit":
         task_duration = 0
         task_power = 0
      else:
        if flag == False:
          task_power = self.operator_power_statistics[task][device]
        else:
          task_power = self.actual_operator_power_statistics[task][device]          
      total_power_consumption += task_power



    total_execution_time = aft["n_exit"]

    return total_execution_time, total_power_consumption


  def initial_task_embeddings(self):
    """
    For each task its embedding is a vector of five elements:

      1. Average execution time
      2. Upward rank (don't know if necessery and whether downward is needed and maybe needs to be normalized)
      3. Current device placement in one hot encoding
      4. Flag indicating if it is visited
      5. Flag indicating if it is the task to be scheduled at current time

    """
    embeddings = {}
    for task in self.topological_order:
      exec_time = self.operator_average_time_statistics[task]
      rank = self.rank_u[task]
      visited = 0
      current = 0
      exec_device = self.current_placement[task]
      exec_device_one_hot = [0] * self.num_devices
      exec_device_one_hot[exec_device] = 1

      embedding = [exec_time] + [rank] + [visited] + [current] + exec_device_one_hot 
      embedding = np.array(embedding)
      embeddings[task] = embedding 

    # Assign current = 1 to the first task in priority queue except n_entry
    temp1 = self.task_priority.get()
    temp2 = self.task_priority.get()
    first_task = int(temp2[1])
    embeddings[first_task][3] = 1
    self.current_task = first_task  # assign the first task as the current task for the 1st iteration (don't know if n_entry is needed)

    return embeddings

  def trans_constraints(self):
    new_constraints = {}
    for key, value in self.constraints.items():
        #map node constraints with the devices the node has
        devs = []
        for x, y in self.devices_info.items():
            # print(y["node_id"])
            if int(value[0]) == int(''.join(filter(str.isdigit, y["node_id"]))):
                parts = y["nes_device_id"].split("-")
                if value[1] == y["device_type"]:
                    devs.append(x)
                elif value[1] == parts[1]:
                    devs.append(x)
        new_constraints[key] = devs
    return new_constraints

  def node_groups(self):
    """
    Returns the upstreamm downstream and parallel
    tasks for the current node
    """
    upstream = {n for n in nx.traversal.bfs_tree(self.operator_graph, self.current_task, reverse=True) if n != self.current_task}
    downstream = {n for n in nx.traversal.bfs_tree(self.operator_graph, self.current_task) if n != self.current_task}
    parallel = (set(self.operator_graph.nodes()).difference(upstream)).difference(downstream) - {self.current_task}
    
    return upstream, downstream, parallel 


  def node_group_embeddings(self):
    """
    Calculates the embeddings for upsteam, 
    downstream and parallel nodes 
    """
    groups = self.node_groups()
    upstream_embeddings = np.array([self.task_embeddings[node] for node in groups[0]])
    downstream_embeddings = np.array([self.task_embeddings[node] for node in groups[1]])

    if groups[2]:  # handle nodes that have zero size parallel set
      parallel_embeddings = np.array([self.task_embeddings[node] for node in groups[2]])
      parallel_embeddings_mean = np.mean(parallel_embeddings, axis=0)
    else:
      parallel_embeddings_mean = np.zeros(4+self.num_devices)

    # Aggregate the values on each group by calculating the mean by column (not sure for the mean of one hot encoding maybe neads median or max)
    upstream_embeddings_mean = np.mean(upstream_embeddings, axis=0)
    downstream_embeddings_mean = np.mean(downstream_embeddings, axis=0)
    #parallel_embeddings_mean = np.mean(parallel_embeddings, axis=0)

    return upstream_embeddings_mean, downstream_embeddings_mean, parallel_embeddings_mean

  def state_embeddings(self):
    """
    Calculates the vector representation of the state which
    is a concatenation of :

      1. Embedding of current task
      2. Embedding of upstream tasks
      3. Embedding of downstream tasks
      4. Embedding of parallel tasks

    """
    current_task_embeddings = self.task_embeddings[self.current_task]
    upstream_embeddings, downstream_embeddings, parallel_embeddings = self.node_group_embeddings()
    if self.current_task == "n_exit":
      downstream_embeddings = np.zeros(4+self.num_devices)
      parallel_embeddings = np.zeros(4+self.num_devices)   # problem with parallel 
    #print("upstream_embeddings: ", upstream_embeddings)
    #print("downstream_embeddings: ", downstream_embeddings)
    #rint("parallel_embeddings: ", parallel_embeddings)
    state_emb = np.concatenate((current_task_embeddings, upstream_embeddings, downstream_embeddings, parallel_embeddings))

    return state_emb 

  def reset(self):
    """
    Resets the environment and returns an initial observation
    which is a PyG Data object that represents current state of the task graph
    """
    
    self.topological_order = list(nx.topological_sort(self.operator_graph))
    self.new_constraints = self.trans_constraints()
    
    scheduler = HeftScheduler(self.operator_graph, self.operator_time_statistics, self.operator_average_time_statistics, self.operator_power_statistics,
                              self.transfer_times, self.average_transfer_times, list(range(self.num_cpu + self.num_gpu)), self.constraints, 
                              self.devices_info, self.actual_operator_time_statistics, self.actual_operator_power_statistics)
    
    
    scheduling = scheduler.schedule(self.weights,self.constraints,self.devices_info)
    self.initial_makespan = scheduler.compute_scheduling_time_execution(scheduling, flag=False)
    self.initial_power = total_power_consumption(scheduling, self.operator_power_statistics)
    self.current_placement = {operator_id: device_id for operator_id, device_id in scheduling.items()}
    # Create an initial random assignment of tasks to devices
    #self.current_placement = np.random.choice(range(self.num_devices), self.operator_graph.number_of_nodes())
    #self.current_placement = np.array([0]*self.operator_graph.number_of_nodes())
    #self.current_placement = {element: np.random.choice(range(self.num_devices)) for element in list(self.operator_graph.nodes)}
    #self.current_placement = dict(enumerate(self.current_placement))  # conversion to dict for compatibility reasons
    #self.current_placement["n_entry"] = np.random.choice(range(self.num_devices))
    #self.current_placement["n_exit"] = np.random.choice(range(self.num_devices))

    # Calculate the current makespan
    #self.current_makespan = self.makespan(self.current_placement)
    self.current_makespan = self.initial_makespan  # first makespan = 0
    self.current_power = self.initial_power
    self.all_placements = {}
    self.all_placements[self.initial_makespan] = copy.deepcopy(self.current_placement)
    #print("Inside HEFT scheduling:", self.current_placement)
    #print("Inside HEFT makespan:", self.current_makespan)
    #self.device_utilization = [0] * self.num_devices  # hmmm
    # Calculate upward and downward rank for each task
    # Choose to update each task according to the non-increasing
    # order of upward rank, instead of choosing each node randomly
    self.rank_u = self.upward_rank()
    #self.rank_d = self.downward_rank()
    self.task_priority = self.prioritize_tasks() # n_entry and n_exit must be excluded from the priority queue

    # Create initial task features
    self.task_embeddings = self.initial_task_embeddings()
    #nx.set_node_attributes(self.operator_graph, values=self.task_features, name="x")
    #nx.set_edge_attributes(self.operator_graph, values=self.average_transfer_times, name="edge_weight")

    # Convert to pytorch geometric data object
    #pyg_graph = from_networkx(self.operator_graph)
    #self.state = pyg_graph
    self.state = self.state_embeddings()

    return self.state, self.operator_graph, self.operator_time_statistics, self.operator_average_time_statistics, self.transfer_times, self.average_transfer_times, self.new_constraints, self.initial_makespan


  def step(self, action):
    """
    Performs the state update given an action in one hot encoding and returns:
      1. the next state
      2. the observed reward
      3. a flag indicating if the new state is terminal
    """
    #print("action before: ", action)
    #print("type action: ", type(action))
    #print("action_to_int: ", action_to_int)
    # Update the device placement for the current task
    #print("self.current_placement: ", self.current_placement)
    #print("self.current_task: ", self.current_task)
    #print("Constraints",self.constraints)
    #print("Devices Info", self.devices_info)
    #print("Available devices:",self.available_devices)
            
    #print("New Device Constraints: ", self.new_constraints)

    action_to_int = np.argmax(action)
    big_m = 999999
    
    if self.current_task in self.new_constraints:
      self.current_placement[self.current_task] = random.choice(self.new_constraints[self.current_task])
      
      # messes up with what the agent thinks it took as an action and what he actually did
      # u can't change here the decision of the action
      action_to_int = self.current_placement[self.current_task]
      action[:] = 0
      action[action_to_int] = 1
      new_makespan, new_power = self.makespan(self.current_placement, flag=False)
       #print("action after: ", action)
    
    else:
    # Calculate reward
      
      self.current_placement[self.current_task] = action_to_int
      new_makespan, new_power = self.makespan(self.current_placement, flag=False)
      #self.current_placement[self.current_task] = action_to_int
    
    if new_makespan > big_m:
      if self.current_task != "n_entry":
        pred_tasks = list(self.operator_graph.predecessors(self.current_task)) 
        for pred in pred_tasks:
          pred_device = self.current_placement[pred]
          if self.transfer_times[(pred, self.current_task)][(pred_device, action_to_int)] < big_m and self.task_embeddings[self.current_task][2] == 1:
            break
          else:
            for i in range(action.size):
                if self.transfer_times[(pred, self.current_task)][(pred_device, i)] < big_m:
                  action[:] = 0
                  action[i] = 1
                  self.current_placement[self.current_task] = i
                  new_makespan, new_power = self.makespan(self.current_placement, flag=False)
                  break
      #idle_time_cpu = self.calculate_idle_time()
      reward = -300

    else:      
      #idle_time_cpu = self.calculate_idle_time()
      # zero reward in first action for stability reasons
      if self.weights[0] == 1:
        # makespan minimization
        if new_makespan < self.initial_makespan:
          reward = 20 + self.task_embeddings[self.current_task][1]
          print("WOW!", reward)
          #self.all_placements[new_makespan] = self.current_placement
        elif ((new_makespan <= self.initial_makespan*1.2) and (new_makespan>=self.initial_makespan)):
          reward = 5 + self.task_embeddings[self.current_task][1]
          print("okay.")
          #self.all_placements[new_makespan] = self.current_placement
        #FIX REWARD FOR COMBINED OBJECTIVE (include weights etc)
        # STANDARDIZE TIME AND POWER (different scales so they need to be standardized in
        # order to have an accurate combined objective)
        #reward = -(new_makespan - self.current_makespan) #- alpha * idle_time_cpu
        else:  
          reward = -(new_makespan - self.current_makespan) + self.task_embeddings[self.current_task][1]
          print("fak", reward)
          #self.all_placements[new_makespan] = self.current_placement
      
      elif self.weights[0] == 0:
        #power minimization
        if new_power < self.initial_power:
          reward = 500
          print("WOW power!", new_power)
          #self.all_placements[new_makespan] = self.current_placement
        elif ((new_power <= self.initial_power*1.2) and (new_power>=self.initial_power)):
          reward = 100 
          print("okay power.")
          #self.all_placements[new_makespan] = self.current_placement
        #FIX REWARD FOR COMBINED OBJECTIVE (include weights etc)
        # STANDARDIZE TIME AND POWER (different scales so they need to be standardized in
        # order to have an accurate combined objective)
        #reward = -(new_makespan - self.current_makespan) #- alpha * idle_time_cpu
        else:  
          reward = -(new_power - self.current_power) 
          print("fak power", reward)
          #self.all_placements[new_makespan] = self.current_placement
    
    self.current_makespan = new_makespan
    self.current_power = new_power
    
    # Change the info for the already scheduled task
    self.task_embeddings[self.current_task][2] = 1         # change to visited
    self.task_embeddings[self.current_task][3] = 0         # not the current anymore
    self.task_embeddings[self.current_task][4:] = action  # change the device placement
    
    # Change the info for the new task to be scheduled
    self.current_task = self.task_priority.get()[1]   
    if self.current_task != "n_exit":
      self.current_task =int(self.current_task)
    self.task_embeddings[self.current_task][3] = 1
    new_state = self.state_embeddings()
    self.state = new_state
    done = (self.current_task == "n_exit")  
    self.all_placements[new_makespan] = copy.deepcopy(self.current_placement) 
    return self.state, reward, done