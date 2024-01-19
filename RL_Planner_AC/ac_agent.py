import numpy as np
import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
from RL_Planner_AC.actor_critic import Actor, Critic, ReplayBuffer
from torch.distributions.categorical import Categorical


class ACAgent():
  def __init__(self, critic_lr, actor_lr, gamma, state_dims, n_actions, batch_size, 
               chkpt_dir, name, max_mem_size=100000):
    self.critic_lr = critic_lr
    self.actor_lr = actor_lr
    self.gamma = gamma
    self.state_dims = state_dims
    self.n_actions = n_actions
    self.action_space = [i for i in range(self.n_actions)]
    self.batch_size = batch_size
    self.chkpt_dir = chkpt_dir
    self.name = name
    # Initialize agent's networks
    self.Actor = Actor(self.state_dims, self.n_actions, 512, 256, 128, self.actor_lr, chkpt_dir, name = f'{name}_Actor')
    self.Critic = Critic(self.state_dims, 512, 256, 128, self.critic_lr, chkpt_dir, name = f'{name}_Critic')

    # Initialize replay memory
    self.buffer = ReplayBuffer(max_mem_size, state_dims, n_actions)

  def store_transition(self, state, action, reward, new_state, done):
    self.buffer.store_transition(state, action, reward, new_state, done)

  def choose_action(self, observation):
    # Convert to tensor and put an extra dimension because input needs to be in batch
    state = torch.tensor([observation], dtype=torch.float32).to(self.Actor.device)
    action_probs = self.Actor(state)

    # Sample an action based on action probabilities
    actions_distribution = Categorical(action_probs)
    sample_action = actions_distribution.sample()

    # Convert to one hot
    action_one_hot = np.zeros(self.n_actions)
    action_one_hot[sample_action.item()] = 1
  
    return action_one_hot

  def learn(self):
    # We don't want to learn from random data
    if self.buffer.counter < self.batch_size:
      return

    states, new_states, actions, rewards, dones = self.buffer.sample(self.batch_size)

    # Convert to torch tensors
    states = torch.tensor(states, dtype=torch.float32).to(self.Critic.device)
    actions = torch.tensor(actions, dtype=torch.int32).to(self.Critic.device)
    rewards = torch.tensor(rewards, dtype=torch.float32).to(self.Critic.device)
    new_states = torch.tensor(new_states, dtype=torch.float32).to(self.Critic.device)
    dones = torch.tensor(dones).to(self.Critic.device)

    # Critic loss
    state_values = torch.squeeze(self.Critic.forward(states))
    new_state_values = torch.squeeze(self.Critic.forward(new_states))

    delta = rewards + self.gamma * new_state_values * torch.logical_not(dones) - state_values  
    critic_loss = delta ** 2
    critic_loss = torch.mean(critic_loss)

    # Actor loss
    action_probs = self.Actor.forward(states)
    action_probs = Categorical(action_probs)
    # log probabilities of the selected action at each transition
    log_probs = action_probs.log_prob(torch.argmax(actions, dim=1))
    actor_loss = -log_probs * delta
    actor_loss = torch.mean(actor_loss)

    # Network updates
    self.Actor.optimizer.zero_grad()
    actor_loss.backward(retain_graph=True)
    self.Actor.optimizer.step()

    self.Critic.optimizer.zero_grad()
    critic_loss.backward()
    self.Critic.optimizer.step()

  def save_models(self):
    self.Actor.save_checkpoint()
    self.Critic.save_checkpoint()

  def load_models(self):
    self.Actor.load_checkpoint()
    self.Critic.load_checkpoint()
    