from utils import Environment
from ddqn_agent import Agent
import numpy as np
import matplotlib.pyplot as plt
from random import random
n_dev = 4
n_cpu = 2
n_gpu = 2
env = Environment(n_dev, n_cpu, n_gpu)
state_dims = 5 + n_dev
agent = Agent(lr=0.001, gamma=0.99, epsilon=1.0, state_dims=state_dims, n_actions=len(env.action_space),
              batch_size=64, tau=0.05, chkpt_dir='models/')  # state_dims is the number of input features for each node in the task_graph

episodes = 1000
best_score = -100000000
score_history = []
makespans = []
avg_scores = []
training_loss = []

for i in range(episodes):
  observation, _, _, _, _, _ = env.reset()
  observation = observation.to(agent.Q_eval.device)
  #print(env.transfer_times)
  #print("--------------------------")
  #print(env.average_transfer_times)
  done = False
  score = 0
  while not done:
    action = agent.choose_action(observation)
    #print(f"Action: {action}")
    new_observation, reward, done = env.step(action)
    new_observation = new_observation.to(agent.Q_eval.device)
    agent.store_transition(observation, action, reward, new_observation, done)
    score += reward
    loss = agent.learn()
    training_loss.append(loss)
    observation = new_observation

  print(f"Episode: {i}, Score: {env.makespan(env.current_placement)}")
  print("-------------------------------")
  score_history.append(-env.makespan(env.current_placement))
  makespans.append(env.makespan(env.current_placement))

  avg_score = np.mean(score_history[-20:])
  avg_scores.append(avg_score)
  #if avg_score > best_score:
     #if not load_checkpoint:
     #  agent.save_models()
agent.save_models()
best_score = avg_score


x = [i+1 for i in range(episodes)]
plt.figure()
plt.plot(x, score_history)
plt.show()

plt.figure()
plt.plot(avg_scores)
plt.show()


plt.figure()
plt.plot(training_loss)
plt.show()