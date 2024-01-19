import numpy as np
import torch
from RL_Planner.dqnet import DeepQNetwork, ReplayBuffer
#from dqnet import DeepQNetwork, ReplayBuffer

class Agent():

  def __init__(self, lr, gamma, epsilon, state_dims, n_actions, batch_size, tau,
               max_mem_size=8000, epsilon_end=0.01, epsilon_dec=1e-6, chkpt_dir='RL_Planner/models/'):
    self.lr = lr
    self.gamma = gamma
    self.epsilon = epsilon
    self.epsilon_min = epsilon_end
    self.epsilon_dec = epsilon_dec
    self.tau = tau
    self.state_dims = state_dims
    self.n_actions = n_actions  
    self.action_space = [i for i in range(self.n_actions)]
    self.batch_size = batch_size
    self.learn_step_counter = 0
    self.replace_target = 1000
    self.chkpt_dir = chkpt_dir

    # Initialize agent's networks
    self.Q_eval = DeepQNetwork(lr, state_dims, 32, 256, 128, n_actions, chkpt_dir=self.chkpt_dir, name = '_q_eval').double()   # not sure if the .double() solution is correct
    self.q_next = DeepQNetwork(lr, state_dims, 32, 256, 128, n_actions, chkpt_dir=self.chkpt_dir, name = '_q_next').double()

    # Initialize replay memory
    self.buffer = ReplayBuffer(max_mem_size, state_dims, n_actions)

  def store_transition(self, state, action, reward, new_state, done):
    self.buffer.store_transition(state, action, reward, new_state, done)

  def choose_action(self, observation):
    """
    E-greedy choice of the next action based on q value
    """
    if np.random.random() > self.epsilon:
      state = observation
      state = state.to(self.Q_eval.device)
      actions = self.Q_eval.forward(state)
      print(f"Action values: {actions}")
      action = torch.argmax(actions).item()
    else:
      action = np.random.choice(self.action_space)
      #action = np.random.choice([0,1])

    # Convert to one hot
    action_one_hot = np.zeros(self.n_actions)
    action_one_hot[action] = 1

    return action_one_hot

  def learn(self):
    # We don't want to learn from random data
    if self.buffer.counter < self.batch_size:
      return 0

    self.Q_eval.optim.zero_grad()

    if self.learn_step_counter % self.replace_target == 0:
      self.q_next.load_state_dict(self.Q_eval.state_dict())

    # Data loaders for states and new states graphs and corresponding arrays of actions, rewards, dones
    states_train_loader, new_states_train_loader, actions, rewards, dones = self.buffer.sample(self.batch_size)

    # Convert to torch tensors
    rewards = torch.tensor(rewards, dtype=torch.float32).to(self.Q_eval.device)
    dones = torch.tensor(dones).to(self.Q_eval.device)

    # Extract the batch data from the data loaders
    states_batch = next(iter(states_train_loader))
    states_batch = states_batch.to(self.Q_eval.device)
    new_states_batch = next(iter(new_states_train_loader))
    new_states_batch = new_states_batch.to(self.Q_eval.device)

    # Actions that we actually took at each step
    action_indices = np.argmax(actions, axis=1)
    batch_indices = [range(self.batch_size)]

    # We want to calculate the q values only for the actions that we actually took
    q_pred = self.Q_eval.forward(states_batch)[batch_indices, action_indices]
    q_next = self.q_next.forward(new_states_batch)
    q_eval = self.Q_eval.forward(new_states_batch)

    max_actions = torch.argmax(q_eval, dim=1)
    q_next[dones] = 0.0

    q_target = rewards + self.gamma * q_next[batch_indices, max_actions]
    #q_target = rewards + self.gamma * torch.max(q_next_target, dim=1)[0]

    #print("*******************************************")
    #print(f"State representations: {states}")
    #print(f"Predicted values: {q_pred}")
    #print(f"Target values: {q_target}")
    #print("*******************************************")
    #print(f"Rewards: {rewards}")

    loss = self.Q_eval.loss(q_target, q_pred).to(self.Q_eval.device)
    #print(f"Loss: {loss.item()}")
    loss.backward()
    self.Q_eval.optim.step()

    # Decrease epsilon
    if self.epsilon > self.epsilon_min:
      self.epsilon -= self.epsilon_dec
    else:
      self.epsilon = self.epsilon_min

    # target network update
    #for target_param, param in zip(self.Q_target.parameters(), self.Q_eval.parameters()):
    #    target_param.data.copy_(self.tau * param + (1 - self.tau) * target_param)

    self.learn_step_counter += 1
    return loss.item()
  
  def save_models(self):
    self.Q_eval.save_checkpoint()
    self.q_next.save_checkpoint()

  def load_models(self):
    self.Q_eval.load_checkpoint()
    self.q_next.load_checkpoint()


    