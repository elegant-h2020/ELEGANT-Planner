import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
import numpy as np
import os

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
    self.terminal_mem = np.zeros((self.mem_size), dtype=bool)
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
    states = [self.state_mem[i] for i in batch]
    new_states = [self.new_state_mem[i] for i in batch]
    actions = self.action_mem[batch]
    rewards = self.reward_mem[batch]
    dones = self.terminal_mem[batch]

    return states, new_states, actions, rewards, dones
  


class Critic(nn.Module):
  def __init__(self, state_dims, fc1_dims, fc2_dims, fc3_dims,lr, chkpt_dir, name):
    super(Critic, self).__init__()
    self.input_shape = state_dims 
    self.fc1_dims = fc1_dims
    self.fc2_dims = fc2_dims
    self.fc3_dims = fc3_dims
    self.lr=lr
    self.checkpoint_dir = chkpt_dir
    self.checkpoint_file = os.path.join(self.checkpoint_dir, name)
    self.fc1 = nn.Linear(self.input_shape, fc1_dims)
    self.fc2 = nn.Linear(fc1_dims, fc2_dims)
    self.fc3 = nn.Linear(fc2_dims, fc3_dims)
    self.fc4 = nn.Linear(fc3_dims, 1)
    self.optimizer = optim.Adam(self.parameters(), lr=self.lr)
    self.device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
    self.to(self.device)  # run network in GPU if available

  def forward(self, state):
    x = F.relu(self.fc1(state))
    x = F.relu(self.fc2(x))
    x = F.relu(self.fc3(x))
    value = self.fc4(x)

    return value
  
  def save_checkpoint(self):
    print('... saving checkpoint ...')
    torch.save(self.state_dict(), self.checkpoint_file)

  def load_checkpoint(self):
    print('... loading checkpoint ...')
    self.load_state_dict(torch.load(self.checkpoint_file))

class Actor(nn.Module):
  def __init__(self, state_dims, n_actions, fc1_dims, fc2_dims, fc3_dims, lr, chkpt_dir, name):
    super(Actor, self).__init__()
    self.input_shape = state_dims
    self.fc1_dims = fc1_dims
    self.fc2_dims = fc2_dims
    self.fc3_dims = fc3_dims
    self.fc4_dims = n_actions
    self.lr = lr
    self.checkpoint_dir = chkpt_dir
    self.checkpoint_file = os.path.join(self.checkpoint_dir, name)
    self.fc1 = nn.Linear(self.input_shape, fc1_dims)
    self.fc2 = nn.Linear(fc1_dims, fc2_dims)
    self.fc3 = nn.Linear(fc2_dims, fc3_dims)
    self.fc4 = nn.Linear(fc3_dims, n_actions)
    self.optimizer = optim.Adam(self.parameters(), lr=self.lr)
    self.device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
    self.to(self.device)  # run network in GPU if available

  def forward(self, state):
    x = F.relu(self.fc1(state))
    x = F.relu(self.fc2(x))
    x = F.relu(self.fc3(x))
    action_probs = F.softmax(self.fc4(x))

    return action_probs

  def save_checkpoint(self):
    print('... saving checkpoint ...')
    torch.save(self.state_dict(), self.checkpoint_file)

  def load_checkpoint(self):
    print('... loading checkpoint ...')
    self.load_state_dict(torch.load(self.checkpoint_file))