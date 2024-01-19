from collections import Counter
from utils import Environment
from ddqn_agent import Agent
import numpy as np
# Testing on new samples

#env = Environment(4)
score = 0
placements = []
n_dev = 4
n_cpu = 2
n_gpu = 2
env = Environment(n_dev, n_cpu, n_gpu)
state_dims = 5 + n_dev
agent = Agent(lr=0.001, gamma=0.99, epsilon=1.0, state_dims=state_dims, n_actions=len(env.action_space),
              batch_size=64, tau=0.05, chkpt_dir='models/')  # state_dims is the number of input features for each node in the task_graph


agent.load_models()
for i in range(100):
  observation, G, task_time_statistics, task_average_time_statistics, transfer_times, average_transfer_times  = env.reset()
  done = False

  while not done:
    action = agent.choose_action(observation)
    new_observation, reward, done = env.step(action)
    #print(f"Reward: {reward}")
    observation = new_observation


  ###
  ###
  score += env.makespan(env.current_placement)
  placements.append(env.current_placement)

print(f"Mean makespan of {i+1} graphs: {score/(i+1)}")
print(f"Placements: {placements}")

filtered_value_counts = Counter()

# Iterate over each dictionary and update the Counter with its values, excluding 'n_entry' and 'n_exit'
for d in placements:
    for key, value in d.items():
        if key not in ['n_entry', 'n_exit']:
            filtered_value_counts[value] += 1

print(filtered_value_counts)