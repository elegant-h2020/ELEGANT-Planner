import requests, json, base64

BASE = "http://127.0.0.1:5000/planner/"

with open("./llvm_ir/shoc-1.1.5-Triad-Triad.ll", 'rb') as f_0:
    src_0 = f_0.read()
    src_0_encoded = base64.b64encode(src_0).decode()
    
with open("./llvm_ir/shoc-1.1.5-Sort-reduce.ll", 'rb') as f_1:
    src_1 = f_1.read()
    src_1_encoded = base64.b64encode(src_1).decode()
    
with open("./llvm_ir/shoc-1.1.5-S3D-ratx_kernel.ll", 'rb') as f_2:
    src_2 = f_2.read()
    src_2_encoded = base64.b64encode(src_2).decode()
    
with open("./llvm_ir/rodinia-3.1-nn-NearestNeighbor.ll", 'rb') as f_3:
    src_3 = f_3.read()
    src_3_encoded = base64.b64encode(src_3).decode()


request_data = {
  "operatorGraph": [
    {
      "operatorId": "0",
      "children": ["1","2"],
      "sourceCode": src_0_encoded,
      "inputData": "2000"
    },
    {
      "operatorId": "1",
      "children": ["3"],
      "sourceCode": src_1_encoded,
      "inputData": "2000"
    },
    {
      "operatorId": "2",
      "children": [],
      "sourceCode": src_2_encoded,
      "inputData": "2000"
    },
    {
      "operatorId": "3",
      "children": [],
      "sourceCode": src_3_encoded,
      "inputData": "2000"
    }
  ],
  "availNodes": [
    {
      "nodeId": "node_0",
      "devices": [
        {
          "deviceId": "node_0-device_0",
          "deviceType": "CPU",
          "modelName": "intel_xeon_gold_5120",
          "memory": "768"
        },
        {
          "deviceId": "node_0-device_1",
          "deviceType": "GPU",
          "modelName": "geforce_gtx_1060",
          "memory": "6"
        }
      ],
      "nodeType": "cloud"
    },
    {
      "nodeId": "node_1",
      "devices": [
        {
          "deviceId": "node_1-device_0",
          "deviceType": "GPU",
          "modelName": "geforce_gtx_1060",
          "memory": "6"
        }
      ],
      "nodeType": "cloud"
    }
  ],
  "networkDelays": [
    {
      "linkID": "0-1",
      "transferRate": "20 MBps"
    }
  ],
  "optimObjectives": "execution time"
}

# Print the results 
response = requests.post(BASE + "schedule", json=request_data)
response_json = response.json()
placement = response_json["placement"]
objectives = response_json["objective"]
makespan = objectives["time"]
power = objectives["power"]

for operator_info in placement:
    print(f"Operator: {operator_info['operator_id']} assigned to {operator_info['device_id']} ({operator_info['device_type']}) at {operator_info['node_id']}")

print()
print("----------- Scheduling statistics -----------")
print()
print(f"Makespan: {makespan} sec")
print(f"Power consumption: {power} Watt")

