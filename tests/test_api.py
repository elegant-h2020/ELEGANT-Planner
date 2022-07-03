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

with open("./llvm_ir/npb-3.3-CG-makea_4.ll", 'rb') as f_4:
    src_4 = f_4.read()
    src_4_encoded = base64.b64encode(src_4).decode()


request_data1 = {
  "operatorGraph": [
    {
      "operatorId": "0",
      "children": ["1","2"],
      "sourceCode": src_0_encoded,
      "inputData": "100"
    },
    {
      "operatorId": "1",
      "children": ["3"],
      "sourceCode": src_1_encoded,
      "inputData": "100"
    },
    {
      "operatorId": "2",
      "children": ["3"],
      "sourceCode": src_2_encoded,
      "inputData": "100"
    },
    {
      "operatorId": "3",
      "children": ["4"],
      "sourceCode": src_3_encoded,
      "inputData": "100"
    },
    {
      "operatorId": "4",
      "children": [],
      "sourceCode": src_4_encoded,
      "inputData": "100"
    }
  ],
  "availNodes": [
    {
      "nodeId": "node_0",
      "devices": [
        {
          "deviceId": "node_0-device_0",
          "deviceType": "CPU",
          "modelName": "intel_core_i7",
          "memory": "16"
        },
        {
          "deviceId": "node_0-device_1",
          "deviceType": "GPU",
          "modelName": "geforce_rtx_3070",
          "memory": "8"
        }
      ],
      "nodeType": "cloud"
    },
    {
      "nodeId": "node_1",
      "devices": [
        {
          "deviceId": "node_1-device_0",
          "deviceType": "CPU",
          "modelName": "intel_core_i7",
          "memory": "8"
        }
      ],
      "nodeType": "mobile"
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

request_data2 = {
  "execTime": 0.6,
  "power": 0.4
}

response1 = requests.post(BASE + "schedule", json=request_data1)
print(response1.json())

#response2 = requests.post(BASE + "configure_objectives", json=request_data2)
#print(response2.json())

#response3 = requests.post(BASE + "schedule", json=request_data1)
#print(response3.json())
