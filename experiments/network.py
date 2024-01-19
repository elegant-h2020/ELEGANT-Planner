import itertools
import random
import json
# List of devices
devices = [1, 2, 3, 4, 5, 6, 7, 8]

# Possible transfer rates
transfer_rates = [250, 500, 1000]

# Generating all possible combinations of linkIDs for 8 devices
link_combinations = list(itertools.permutations(devices, 2))

# Assigning random transfer rates to each linkID
network_delays = [{
    "linkID": f"{pair[0]}-{pair[1]}", 
    "transferRate": str(random.choice(transfer_rates))
} for pair in link_combinations]

file_name = "network.json"
with open(file_name, 'w') as file:
    json.dump(network_delays, file, indent=4)



