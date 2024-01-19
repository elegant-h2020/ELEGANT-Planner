import requests, json, base64
import re
BASE = "http://127.0.0.1:8080/planner/"
BASE = "http://147.102.4.20:5000/planner/"
BASE = "http://0.0.0.0:8085/planner/"

with open("input_nes.json", "r") as f:
    request_data1 = json.load(f)

response = requests.post(BASE + "schedule", json=request_data1)

print(response.status_code)
response_json = response.json()
save_file = open('received_vik.json', "w")  
json.dump(response_json, save_file, indent = 4)  
save_file.close()  