import requests, json
from argparse import ArgumentParser

BASE = "http://127.0.0.1:5000/planner/"


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("-t", "--time", type=float, help="Exec time weight")
    parser.add_argument("-p", "--power", type=float, help="Power weight")
    args = parser.parse_args()
    exec_time = args.time
    power = args.power
    
    request_data = {
        "execTime": exec_time,
        "power": power
    }
    
    response = requests.post(BASE + "configure_objectives", 	
     		             json=request_data)
    print(response.json())
