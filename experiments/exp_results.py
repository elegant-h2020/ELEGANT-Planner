import json
import matplotlib.pyplot as plt

start_file_number = 0
end_file_number = 199

def results(num_devices):
    num_devices = num_devices
    rl_actual_times = []
    rl_actual_powers = []
    rl_actual_post_times = []
    heft_actual_times = []
    heft_actual_powers = []
    heft_actual_post_times = []
    successful_schedules_rl = 0
    unsuccessful_schedules_rl = 0
    successful_schedules_heft = 0
    unsuccessful_schedules_heft = 0
    big_M = 999999
    planners = ["rl","heft"]
    for planner in planners:
        #path = f"result_jsons_{num_devices}/{planner}_jsons"
        path = f"result_jsons_network/{planner}_jsons"
        for file_number in range(start_file_number, end_file_number + 1):
            file_id = f'result_{file_number:04d}.json'
            with open(f"{path}/{file_id}", "r") as f:
                data = json.load(f)
                if planner == "rl":
                    rl_actual_times.append(float(data["objective"]["actual_time"]))
                    rl_actual_powers.append(float(data["objective"]["actual_power"]))
                    rl_actual_post_times.append(float(data["objective"]["post_time"]))
                    if float(data["objective"]["actual_time"]) > big_M:
                        unsuccessful_schedules_rl += 1
                    else:
                        successful_schedules_rl +=1

                else:
                    heft_actual_times.append(float(data["objective"]["actual_time"]))
                    heft_actual_powers.append(float(data["objective"]["actual_power"]))
                    heft_actual_post_times.append(float(data["objective"]["post_time"])) 
                    if float(data["objective"]["actual_time"]) > big_M:
                        unsuccessful_schedules_heft += 1
                    else:
                        successful_schedules_heft +=1            
    return rl_actual_times, rl_actual_powers, rl_actual_post_times, successful_schedules_rl, unsuccessful_schedules_rl, heft_actual_times, heft_actual_powers, heft_actual_post_times, successful_schedules_heft, unsuccessful_schedules_heft


#_, _, post_time_4_rl, _, _, post_time_4_heft = results(4)
#_, _, post_time_8_rl, _, _, post_time_8_heft = results(8)
#_, _, post_time_16_rl, _, _, post_time_16_heft = results(16)
rl_actual_times, rl_actual_powers, rl_actual_post_times, successful_schedules_rl, unsuccessful_schedules_rl, heft_actual_times, heft_actual_powers, heft_actual_post_times, successful_schedules_heft, unsuccessful_schedules_heft = results(5)

plt.plot(rl_actual_times, color='blue', label='RL')  # Plotting the first list in blue
#plt.plot(heft_actual_times, color='red', label='HEFT')   # Plotting the second list in red
# Adding labels and legend
plt.xlabel('Sample Graphs')
plt.ylabel('Makespan (sec)')
plt.title('Makespan of RL and HEFT Generated Scedulings, 4 Devices')
plt.legend()
# Show the plot
plt.show()

plt.plot(rl_actual_powers, color='blue', label='RL')  # Plotting the first list in blue
plt.plot(heft_actual_powers, color='red', label='HEFT')   # Plotting the second list in red
# Adding labels and legend
plt.xlabel('Sample Graphs')
plt.ylabel('Power Consumption (Watt)')
plt.title('Power Consumption of RL and HEFT Generated Scedulings, 4 Devices')
plt.legend()
# Show the plot
plt.show()




'''
plt.plot(post_time_4_rl[1:], color='lightsteelblue', label='RL - 4 Devices')  
plt.plot(post_time_8_rl[1:], color='cornflowerblue', label='RL - 8 Devices')  
plt.plot(post_time_16_rl[1:], color='mediumblue', label='RL - 16 Devices')  
plt.plot(post_time_4_heft[1:], color='lightcoral', label='HEFT - 4 Devices') 
plt.plot(post_time_8_heft[1:], color='tomato', label='HEFT - 8 Devices')   
plt.plot(post_time_16_heft[1:], color='darkred', label='HEFT - 16 Devices')   
# Adding labels and legend
plt.xlabel('Sample Graphs')
plt.ylabel('Overhead (sec)')
plt.title('Overhead of the web service based on RL and HEFT')
plt.legend()
# Show the plot
plt.show()
'''

'''
# Sample data
categories = ['HEFT', 'RL']
values1 = [unsuccessful_schedules_heft, successful_schedules_heft]
values2 = [unsuccessful_schedules_rl, successful_schedules_rl]
colors1 = ['red', 'green']  
colors2 = ['red', 'green']
# Creating x positions for the bars
x_pos = [0, 1, 3, 4]  # Notice the gap between 1 and 3

# Creating the bar plot
plt.figure(figsize=(8, 6))
plt.bar(x_pos[0:2], values1, width=0.4, color=colors1)
plt.bar(x_pos[2:4], values2, width=0.4, color=colors2)

# Adding category labels
plt.xticks([0.5, 3.5], categories)

plt.xlabel('Planner ')
plt.ylabel('Number of schedules')
plt.title('Succesful (green) and unsuccessful (red) schedules of HEFT and RL algorithms')
plt.legend()
plt.show()

print(unsuccessful_schedules_heft)
'''


