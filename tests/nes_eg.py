import requests, json, base64

BASE = "http://127.0.0.1:8080/planner/"

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
    
with open("./llvm_ir/amd-app-sdk-3.0-SimpleConvolution-simpleNonSeparableConvolution.ll", 'rb') as f_5:
    src_5 = f_5.read()
    src_5_encoded = base64.b64encode(src_5).decode()
    
with open("./llvm_ir/amd-app-sdk-3.0-ScanLargeArrays-prefixSum.ll", 'rb') as f_6:
    src_6 = f_6.read()
    src_6_encoded = base64.b64encode(src_6).decode()


request_data1 = {
    "operatorGraph": [
        {
            "operatorId": "4",
            "children": ["7","10"],
            "sourceCode": src_0_encoded,
            "inputData": "2048",
            "constraint": ""
        },
        {
            "operatorId": "7",
            "children": ["6"],
            "sourceCode": src_1_encoded,
            "inputData": "2048",
            "constraint": ""
        },
        {
            "operatorId": "6",
            "children": ["5"],
            "sourceCode": src_2_encoded,
            "inputData": "2048",
            "constraint": "node_3"
        },
        {
            "operatorId": "5",
            "children": [],
            "sourceCode": src_3_encoded,
            "inputData": "2048",
            "constraint": ""
        },
        {
            "operatorId": "10",
            "children": ["9"],
            "sourceCode": src_1_encoded,
            "inputData": "2048",
            "constraint": ""
        },
        {
            "operatorId": "9",
            "children": ["8"],
            "sourceCode": src_2_encoded,
            "inputData": "2048",
            "constraint": "node_3"
        },
        {
            "operatorId": "8",
            "children": [],
            "sourceCode": src_3_encoded,
            "inputData": "2048",
            "constraint": ""
        }
    ],
    "availNodes": [
        {
            "nodeId": "node_1",
            "devices": [
                {
                    "deviceId": "node_1-device_1",
                    "deviceType": "CPU",
                    "modelName": "intel_xeon_gold_5120",
                    "memory": "768"
                    
                }
            ],
            "nodeType": "stationary"
        },
        {
            "nodeId": "node_2",
            "devices": [
                {
                    "deviceId": "node_2-device_1",
                    "deviceType": "CPU",
                    "modelName": "intel_xeon_gold_5120",
                    "memory": "768"
                }
            ],
            "nodeType": "stationary"
        },
        {
            "nodeId": "node_3",
            "devices": [
                {
                    "deviceId": "node_3-device_1",
                    "deviceType": "CPU",
                    "modelName": "intel_xeon_gold_5120",
                    "memory": "768"
                },
                                {
                    "deviceId": "node_3-device_2",
                    "deviceType": "GPU",
                    "modelName": "amd_gold_5120",
                    "memory": "768"
                }
            ],
            "nodeType": "stationary"
        }
    ],
    "networkDelays": [
        {
            "linkID": "1-2",
            "transferRate": "1000"
        },
        {
            "linkID": "2-1",
            "transferRate": "500"
        },
        {
            "linkID": "1-3",
            "transferRate": "1000"
        },
        {
            "linkID": "3-1",
            "transferRate": "500"
        }
    ],
    "optimObjectives": "execution time"
}


# Print the results 
response = requests.post(BASE + "schedule", json=request_data1)
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

save_file = open("nes_eg.json", "w")  
json.dump(response_json, save_file, indent = 6)  
save_file.close()  
#response2 = requests.post(BASE + "configure_objectives", json=request_data2)
#print(response2.json())

#print(src_3_encoded)
