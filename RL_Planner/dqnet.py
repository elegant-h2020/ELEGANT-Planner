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
import numpy as np

class ReplayBuffer:
  """
  Buffer that serves for experience replay and stores
  the state, new_state, reward, done pairs
  """
  def __init__(self, max_size, state_dims, n_actions):
    self.mem_size = max_size
    self.counter = 0  # current memory position
    # State and new state memories need to be lists of PyG Data objects
    self.state_mem = [0] * self.mem_size
    self.new_state_mem = [0] * self.mem_size
    self.action_mem = np.zeros((self.mem_size, n_actions), dtype=np.int32)
    self.reward_mem = np.zeros((self.mem_size), dtype=np.float32)
    self.terminal_mem = np.zeros(self.mem_size, dtype=bool)
    # np.empty((self.mem_size,), dtype=torch_geometric.data.data.Data)

  def store_transition(self, state, action, reward, new_state, done):
    index = self.counter % self.mem_size  # determine where to store the new transition

    self.state_mem[index] = state
    self.new_state_mem[index] = new_state
    self.action_mem[index] = action
    self.reward_mem[index] = reward
    self.terminal_mem[index] = done

    self.counter += 1

  def sample(self, batch_size):
    """
    Returns a batch_size sample of the replay buffer
    """
    max_mem = min(self.counter, self.mem_size)

    batch = np.random.choice(max_mem, batch_size, replace=False)  # don't sample again the same memory

    # DataLoader samples the specific indices in the batch list
    # We need to know which indices we are sampling to use them for actions, rewards and dones
    states_subset = Subset(self.state_mem, batch)
    states_train_loader = DataLoader(states_subset, batch_size=batch_size, shuffle=False)

    new_states_subset = Subset(self.new_state_mem, batch)
    new_states_train_loader = DataLoader(new_states_subset, batch_size=batch_size, shuffle=False)

    #states = self.state_mem[batch]
    #new_states = self.new_state_mem[batch]
    actions = self.action_mem[batch]
    rewards = self.reward_mem[batch]
    dones = self.terminal_mem[batch]

    return states_train_loader, new_states_train_loader, actions, rewards, dones
  


class SeqAggregator(nn.Module):

  def __init__(self, gcn_dims):
    super(SeqAggregator, self).__init__()
    self.input_dims = gcn_dims
    self.hidden_dims = gcn_dims
    #self.
    self.device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
    self.to(self.device)  # run network in GPU if available


  def forward():
    pass


class DeepQNetwork(nn.Module):

  def __init__(self, lr, state_dims, gcn_dims, fc1_dims, fc2_dims, n_actions, chkpt_dir, name):
    super(DeepQNetwork, self).__init__()
    self.input_shape = state_dims
    self.gcn_dims = gcn_dims
    self.fc1_dims = fc1_dims
    self.fc2_dims = fc2_dims
    self.n_actions = n_actions
    self.checkpoint_dir = chkpt_dir
    self.checkpoint_file = os.path.join(self.checkpoint_dir, name)
    self.conv1 = GATv2Conv(self.input_shape, self.gcn_dims, edge_dim=1)
    self.conv2 = GATv2Conv(self.gcn_dims, self.gcn_dims, edge_dim=1)
    self.conv3 = GATv2Conv(self.gcn_dims, self.gcn_dims, edge_dim=1)
    #self.conv4 = GATv2Conv(self.gcn_dims, self.gcn_dims, edge_dim=1)
    self.fc1 = nn.Linear(self.gcn_dims, self.fc1_dims)
    self.fc2 = nn.Linear(self.fc1_dims, self.fc2_dims)
    self.fc3 = nn.Linear(self.fc2_dims, int(self.fc2_dims/2))
    self.fc4 = nn.Linear(int(self.fc2_dims/2), self.n_actions)
    self.dropout1 = nn.Dropout(0.4)
    self.dropout2 = nn.Dropout(0.4)
    #self.norm = nn.BatchNorm1d(self.gcn_dims)
    self.optim = optim.Adam(self.parameters(), lr=lr)
    #self.loss = nn.MSELoss()
    self.loss = nn.SmoothL1Loss()
    self.device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
    self.to(self.device)  # run network in GPU if available

  def forward(self, data):
    x, edge_index, edge_weight, batch = data.x, data.edge_index, data.edge_weight, data.batch
    x = F.relu(self.conv1(x, edge_index, edge_weight))
    x = F.relu(self.conv2(x, edge_index, edge_weight))
    x = F.relu(self.conv3(x, edge_index, edge_weight))
    #x = F.relu(self.conv4(x, edge_index, edge_weight))
    x = global_mean_pool(x, batch)
    #x = self.norm(x)
    x = F.relu(self.fc1(x))
    x = self.dropout1(x)
    x = F.relu(self.fc2(x))
    x = self.dropout2(x)
    x = F.relu(self.fc3(x))
    actions = self.fc4(x)

    return actions

  def save_checkpoint(self):
    print('... saving checkpoint ...')
    torch.save(self.state_dict(), self.checkpoint_file)

  def load_checkpoint(self):
    print('... loading checkpoint ...')
    self.load_state_dict(torch.load(self.checkpoint_file))