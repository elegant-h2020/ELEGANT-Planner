import requests, json, time
import os
BASE = "http://0.0.0.0:8085/planner/"
#BASE = "http://172.17.0.2:8081/planner/"


start_file_number = 0
end_file_number = 199

for file_number in range(start_file_number, end_file_number + 1):
    file_id = f'exp_graph_{file_number:04d}.json'
    with open(f"exp_jsons_network/{file_id}", "r") as f:
        request_data1 = json.load(f)

    start_time = time.time()
    response = requests.post(BASE + "schedule", json=request_data1)
    end_time = time.time()
    execution_time = end_time - start_time

    response_json = response.json()
    response_json["objective"]["post_time"] = execution_time

    json_data = json.dumps(response_json, indent = 4)
    with open(f'result_jsons_network/rl_jsons/result_{file_number:04d}.json', 'w') as file:
        file.write(json_data)



#save_file = open('received_from_docker.json', "w")  
#json.dump(response_json, save_file, indent = 4)  
#save_file.close()  
