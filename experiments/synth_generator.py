import networkx as nx 
import random
import json

fixed_info = {"availNodes": [
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
                }],
            "nodeType": "stationary"
        },
        {
            "nodeId": "node_4",
            "devices": [
                {
                    "deviceId": "node_4-device_1",
                    "deviceType": "CPU",
                    "modelName": "intel_xeon_gold_5120",
                    "memory": "768"
                }
            ],
            "nodeType": "stationary"
        },
        {
            "nodeId": "node_5",
            "devices": [
                {
                    "deviceId": "node_5-device_1",
                    "deviceType": "GPU",
                    "modelName": "intel_xeon_gold_5120",
                    "memory": "768"
                }
            ],
            "nodeType": "stationary"
        }
    ],
    "networkDelays": [
    {
        "linkID": "1-2",
        "transferRate": "500"
    },
    {
        "linkID": "2-5",
        "transferRate": "250"
    },
        {
        "linkID": "3-4",
        "transferRate": "500"
    },
    {
        "linkID": "4-5",
        "transferRate": "250"
    }

],
    "time_weight": "1"
}



def create_random_DAG(nodes, edges):
    """
    Generate a random Directed Acyclic Graph (DAG) with a given number of nodes and edges.
    """
    G = nx.DiGraph()
    for i in range(nodes):
        G.add_node(i)

    while edges > 0:
        a = random.randint(0, nodes-1)
        b = a

        while b == a:
            b = random.randint(0, nodes-1)
        G.add_edge(a, b)

        if nx.is_directed_acyclic_graph(G):
            edges -= 1
        else:
            # we closed a loop!
            G.remove_edge(a, b)

    return G


def create_specified_chains_dag(num_nodes, num_edges, num_chains):
    """
    Creates a multi-chain directed acyclic graph (DAG) with a specified number of chains, 
    each having equal or almost equal length, and ends up in a node that connects them all.

    Parameters:
    num_nodes (int): Number of nodes in the graph.
    num_edges (int): Number of edges in the graph.
    num_chains (int): Number of chains to be created in the graph.

    Returns:
    G (networkx.DiGraph): A multi-chain DAG with the specified number of nodes, edges, and chains.
    """
    # Check if the number of edges and chains is appropriate
    if num_edges > num_nodes - 1 or num_chains > num_nodes:
        raise ValueError("Number of edges must be less than or equal to number of nodes - 1, and number of chains must be less than or equal to number of nodes.")

    if num_chains == 0:
        raise ValueError("Number of chains must be at least 1.")

    # Calculate the approximate length of each chain
    chain_length = (num_nodes - 1) // num_chains  # Reserve one node as the connecting node
    extra_nodes = (num_nodes - 1) % num_chains

    # Create a directed graph
    G = nx.DiGraph()

    # Add nodes
    G.add_nodes_from(range(num_nodes))

    # Add edges to form chains of equal or almost equal length
    edges_added = 0
    current_node = 0
    connecting_node = num_nodes - 1  # The last node as the connecting node

    for chain in range(num_chains):
        # Adjust length for this chain if there are extra nodes
        current_chain_length = chain_length + (1 if extra_nodes > 0 else 0)
        extra_nodes -= 1

        # Add edges for the current chain
        for i in range(current_chain_length - 1):
            if edges_added < num_edges:
                G.add_edge(current_node + i, current_node + i + 1)
                edges_added += 1

        # Connect the end of the chain to the connecting node
        if edges_added < num_edges:
            G.add_edge(current_node + current_chain_length - 1, connecting_node)
            edges_added += 1

        current_node += current_chain_length

    return G





random.seed(100) # test seed
#random.seed(14365) # train seed


num_G = 200
list_G = []

for i in range(num_G):
    #sparse graphs
    num_nodes = random.randint(10, 50)
    #num_edges = random.randint(num_nodes, 2 * num_nodes)
    num_edges = num_nodes -1
    num_chains = random.randint(2, 10)
    #G = create_random_DAG(num_nodes, num_edges)
    G = create_specified_chains_dag(num_nodes, num_edges, num_chains)
    list_G.append(G)

sorted_graphs = sorted(list_G, key=lambda g: g.number_of_nodes())
#choices = [""] * 10 + ["node_1-CPU", "node_2-CPU", "node_3-CPU", "node_4-CPU", "node_5-GPU"]
cnt = 0
for G in sorted_graphs:
    file_name = f"exp_jsons_network/exp_graph_{cnt:04}.json"
    graph_info = [{"operatorId": node, 
                   "children": list(G.successors(node)), 
                   "sourceCode": "\n#include <cstdint>\nextern \"C\" void execute(uint8_t* var_0_117 ,uint8_t* var_0_118 ,uint8_t* var_0_119 ){\n//variable declarations\nuint64_t var_0_0;\nuint64_t var_0_1;\nuint64_t var_0_2;\nuint64_t var_0_3;\nuint64_t var_0_4;\nuint64_t var_0_6;\nuint64_t var_0_8;\nuint8_t* var_0_10;\nuint64_t var_0_11;\nuint8_t* var_0_12;\nuint64_t var_0_13;\nuint8_t* var_0_14;\nuint8_t* var_0_15;\nuint64_t var_0_16;\nuint8_t* var_0_17;\nuint64_t var_0_18;\nuint8_t* var_5_102;\nuint8_t* var_5_103;\nuint8_t* var_5_104;\nuint64_t var_5_105;\nuint64_t var_5_106;\nuint64_t var_5_107;\nuint64_t var_5_108;\nuint64_t var_5_109;\nuint64_t var_5_110;\nuint8_t* var_5_111;\nuint8_t* var_5_112;\nuint8_t* var_5_113;\nuint8_t* var_5_114;\nbool var_0_19;\nuint8_t* var_1_139;\nuint8_t* var_1_140;\nuint64_t var_1_141;\nuint64_t var_1_142;\nuint64_t var_1_143;\nuint64_t var_1_144;\nuint64_t var_1_145;\nuint8_t* var_1_146;\nuint64_t var_1_147;\nuint8_t* var_1_148;\nuint8_t* var_1_149;\nuint8_t* var_1_150;\nuint8_t* var_1_151;\nuint64_t var_1_0;\nuint64_t var_1_1;\nuint8_t* var_1_2;\nuint64_t var_1_3;\nuint8_t* var_1_4;\ndouble var_1_5;\nuint64_t var_1_6;\nuint8_t* var_1_7;\ndouble var_1_8;\nuint8_t* var_1_9;\nuint8_t* var_1_10;\nint32_t var_1_11;\nint32_t var_1_13;\nuint8_t* var_1_15;\nuint8_t* var_1_17;\nint32_t var_1_18;\ndouble var_1_19;\nint32_t var_1_20;\ndouble var_1_21;\nuint64_t var_1_23;\nuint64_t var_1_24;\nuint8_t* var_1_25;\nuint64_t var_1_26;\nuint8_t* var_1_27;\nuint64_t var_1_29;\nuint8_t* var_1_30;\nuint64_t var_1_32;\nuint64_t var_1_33;\nuint64_t var_1_35;\nbool var_1_36;\nbool var_1_37;\nbool var_1_38;\nuint8_t* var_3_109;\nuint8_t* var_3_110;\nuint64_t var_3_111;\nuint64_t var_3_112;\nuint64_t var_3_113;\nuint64_t var_3_114;\nuint64_t var_3_115;\nuint8_t* var_3_116;\nuint64_t var_3_117;\nuint8_t* var_3_118;\nuint8_t* var_3_119;\nuint8_t* var_3_120;\nuint8_t* var_3_5;\nuint8_t* var_3_7;\nuint64_t var_3_9;\nuint8_t* var_6_103;\nuint8_t* var_6_104;\nuint8_t* var_6_105;\nuint64_t var_6_106;\nuint64_t var_6_107;\nuint64_t var_6_108;\nuint64_t var_6_109;\nuint64_t var_6_110;\nuint64_t var_6_111;\nuint8_t* var_6_112;\nuint8_t* var_6_113;\nuint8_t* var_6_114;\nuint8_t* var_6_115;\nuint64_t var_3_11;\nuint64_t var_3_12;\nuint8_t* var_4_101;\nuint8_t* var_4_102;\nuint8_t* var_4_103;\nuint64_t var_4_104;\nuint64_t var_4_105;\nuint64_t var_4_106;\nuint64_t var_4_107;\nuint64_t var_4_108;\nuint64_t var_4_109;\nuint8_t* var_4_110;\nuint8_t* var_4_111;\nuint8_t* var_4_112;\nuint8_t* var_4_113;\nuint8_t* var_2_107;\nuint8_t* var_2_108;\nuint8_t* var_2_109;\nuint64_t var_2_110;\nuint64_t var_2_111;\nuint64_t var_2_112;\nuint64_t var_2_113;\n//function definitions\nauto NES__Runtime__TupleBuffer__Watermark = (uint64_t(*)(uint8_t*))0x121cbb4dc;\nauto NES__Runtime__TupleBuffer__getOriginId = (uint64_t(*)(uint8_t*))0x121cbb47c;\nauto NES__Runtime__TupleBuffer__getSequenceNumber = (uint64_t(*)(uint8_t*))0x121cbb5c4;\nauto allocateBufferProxy = (uint8_t*(*)(uint8_t*))0x121a98d84;\nauto NES__Runtime__TupleBuffer__getBuffer = (uint8_t*(*)(uint8_t*))0x121cbb3c4;\nauto getGlobalOperatorHandlerProxy = (uint8_t*(*)(uint8_t*,uint64_t))0x121a99c7c;\nauto getInstance = (uint8_t*(*)(uint8_t*))0x121a100d8;\nauto NES__Runtime__TupleBuffer__getNumberOfTuples = (uint64_t(*)(uint8_t*))0x121cbb41c;\nauto findInputClass = (uint8_t*(*)(uint8_t*))0x121a040c4;\nauto allocateObject = (uint8_t*(*)(uint8_t*))0x121a04598;\nauto setDoubleField = (void(*)(uint8_t*,uint8_t*,uint8_t*,int32_t,double))0x121a0a1a8;\nauto executeMapUdf = (uint8_t*(*)(uint8_t*,uint8_t*,uint8_t*))0x1219f8420;\nauto freeObject = (void(*)(uint8_t*))0x121a04574;\nauto getObjectClass = (uint8_t*(*)(uint8_t*))0x121a047e0;\nauto getDoubleField = (double(*)(uint8_t*,uint8_t*,uint8_t*,int32_t))0x121a05e84;\nauto NES__Runtime__TupleBuffer__setNumberOfTuples = (void(*)(uint8_t*,uint64_t))0x121cbb448;\nauto NES__Runtime__TupleBuffer__setWatermark = (void(*)(uint8_t*,uint64_t))0x121cbb508;\nauto NES__Runtime__TupleBuffer__setOriginId = (void(*)(uint8_t*,uint64_t))0x121cbb4a8;\nauto NES__Runtime__TupleBuffer__setSequenceNr = (void(*)(uint8_t*,uint64_t))0x121cbb590;\nauto emitBufferProxy = (void(*)(uint8_t*,uint8_t*,uint8_t*))0x121a99190;\nauto detachJVM = (void(*)())0x1013dde08;\n//basic blocks\nBlock_0:\nvar_0_0 = 0;\nvar_0_1 = 0;\nvar_0_2 = 0;\nvar_0_3 = 0;\nvar_0_4 = NES__Runtime__TupleBuffer__Watermark(var_0_119);\nvar_0_6 = NES__Runtime__TupleBuffer__getOriginId(var_0_119);\nvar_0_8 = NES__Runtime__TupleBuffer__getSequenceNumber(var_0_119);\nvar_0_10 = allocateBufferProxy(var_0_118);\nvar_0_11 = 0;\nvar_0_12 = NES__Runtime__TupleBuffer__getBuffer(var_0_10);\nvar_0_13 = 0;\nvar_0_14 = getGlobalOperatorHandlerProxy(var_0_117,var_0_13);\nvar_0_15 = getInstance(var_0_14);\nvar_0_16 = NES__Runtime__TupleBuffer__getNumberOfTuples(var_0_119);\nvar_0_17 = NES__Runtime__TupleBuffer__getBuffer(var_0_119);\nvar_0_18 = 0;\n// prepare block arguments\nvar_5_102 = var_0_118;\nvar_5_103 = var_0_117;\nvar_5_104 = var_0_10;\nvar_5_105 = var_0_8;\nvar_5_106 = var_0_6;\nvar_5_107 = var_0_4;\nvar_5_108 = var_0_11;\nvar_5_109 = var_0_18;\nvar_5_110 = var_0_16;\nvar_5_111 = var_0_12;\nvar_5_112 = var_0_14;\nvar_5_113 = var_0_15;\nvar_5_114 = var_0_17;\ngoto Block_5;\n\nBlock_5:\nvar_0_19 = var_5_109 < var_5_110;\nif (var_0_19){\n// prepare block arguments\nvar_1_139 = var_5_102;\nvar_1_140 = var_5_103;\nvar_1_141 = var_5_105;\nvar_1_142 = var_5_106;\nvar_1_143 = var_5_107;\nvar_1_144 = var_5_110;\nvar_1_145 = var_5_109;\nvar_1_146 = var_5_104;\nvar_1_147 = var_5_108;\nvar_1_148 = var_5_111;\nvar_1_149 = var_5_112;\nvar_1_150 = var_5_113;\nvar_1_151 = var_5_114;\ngoto Block_1;\n}else{\n// prepare block arguments\nvar_2_107 = var_5_102;\nvar_2_108 = var_5_103;\nvar_2_109 = var_5_104;\nvar_2_110 = var_5_105;\nvar_2_111 = var_5_106;\nvar_2_112 = var_5_107;\nvar_2_113 = var_5_108;\ngoto Block_2;}\n\nBlock_1:\nvar_1_0 = 16;\nvar_1_1 = var_1_0*var_1_145;\nvar_1_2 = var_1_151+var_1_1;\nvar_1_3 = 0;\nvar_1_4 = var_1_2+var_1_3;\nvar_1_5 = *reinterpret_cast<double*>(var_1_4);\nvar_1_6 = 8;\nvar_1_7 = var_1_2+var_1_6;\nvar_1_8 = *reinterpret_cast<double*>(var_1_7);\nvar_1_9 = findInputClass(var_1_149);\nvar_1_10 = allocateObject(var_1_9);\nvar_1_11 = 0;\nsetDoubleField(var_1_149,var_1_9,var_1_10,var_1_11,var_1_5);\nvar_1_13 = 1;\nsetDoubleField(var_1_149,var_1_9,var_1_10,var_1_13,var_1_8);\nvar_1_15 = executeMapUdf(var_1_149,var_1_150,var_1_10);\nfreeObject(var_1_10);\nvar_1_17 = getObjectClass(var_1_15);\nvar_1_18 = 0;\nvar_1_19 = getDoubleField(var_1_149,var_1_17,var_1_15,var_1_18);\nvar_1_20 = 1;\nvar_1_21 = getDoubleField(var_1_149,var_1_17,var_1_15,var_1_20);\nfreeObject(var_1_15);\nvar_1_23 = 16;\nvar_1_24 = var_1_23*var_1_147;\nvar_1_25 = var_1_148+var_1_24;\nvar_1_26 = 0;\nvar_1_27 = var_1_25+var_1_26;\n*reinterpret_cast<double*>(var_1_27) = var_1_19;\nvar_1_29 = 8;\nvar_1_30 = var_1_25+var_1_29;\n*reinterpret_cast<double*>(var_1_30) = var_1_21;\nvar_1_32 = 1;\nvar_1_33 = var_1_147+var_1_32;\nvar_1_35 = 65536;\nvar_1_36 = var_1_33 > var_1_35;\nvar_1_37 = var_1_33 == var_1_35;\nvar_1_38 = var_1_36||var_1_37;\nif (var_1_38){\n// prepare block arguments\nvar_3_109 = var_1_139;\nvar_3_110 = var_1_140;\nvar_3_111 = var_1_141;\nvar_3_112 = var_1_142;\nvar_3_113 = var_1_143;\nvar_3_114 = var_1_144;\nvar_3_115 = var_1_145;\nvar_3_116 = var_1_146;\nvar_3_117 = var_1_33;\nvar_3_118 = var_1_149;\nvar_3_119 = var_1_150;\nvar_3_120 = var_1_151;\ngoto Block_3;\n}else{\n// prepare block arguments\nvar_4_101 = var_1_139;\nvar_4_102 = var_1_140;\nvar_4_103 = var_1_146;\nvar_4_104 = var_1_141;\nvar_4_105 = var_1_142;\nvar_4_106 = var_1_143;\nvar_4_107 = var_1_33;\nvar_4_108 = var_1_144;\nvar_4_109 = var_1_145;\nvar_4_110 = var_1_148;\nvar_4_111 = var_1_149;\nvar_4_112 = var_1_150;\nvar_4_113 = var_1_151;\ngoto Block_4;}\n\nBlock_3:\nNES__Runtime__TupleBuffer__setNumberOfTuples(var_3_116,var_3_117);\nNES__Runtime__TupleBuffer__setWatermark(var_3_116,var_3_113);\nNES__Runtime__TupleBuffer__setOriginId(var_3_116,var_3_112);\nNES__Runtime__TupleBuffer__setSequenceNr(var_3_116,var_3_111);\nemitBufferProxy(var_3_109,var_3_110,var_3_116);\nvar_3_5 = allocateBufferProxy(var_3_109);\nvar_3_7 = NES__Runtime__TupleBuffer__getBuffer(var_3_5);\nvar_3_9 = 0;\n// prepare block arguments\nvar_6_103 = var_3_109;\nvar_6_104 = var_3_110;\nvar_6_105 = var_3_5;\nvar_6_106 = var_3_111;\nvar_6_107 = var_3_112;\nvar_6_108 = var_3_113;\nvar_6_109 = var_3_9;\nvar_6_110 = var_3_114;\nvar_6_111 = var_3_115;\nvar_6_112 = var_3_7;\nvar_6_113 = var_3_118;\nvar_6_114 = var_3_119;\nvar_6_115 = var_3_120;\ngoto Block_6;\n\nBlock_6:\nvar_3_11 = 1;\nvar_3_12 = var_6_111+var_3_11;\n// prepare block arguments\nvar_5_102 = var_6_103;\nvar_5_103 = var_6_104;\nvar_5_104 = var_6_105;\nvar_5_105 = var_6_106;\nvar_5_106 = var_6_107;\nvar_5_107 = var_6_108;\nvar_5_108 = var_6_109;\nvar_5_109 = var_3_12;\nvar_5_110 = var_6_110;\nvar_5_111 = var_6_112;\nvar_5_112 = var_6_113;\nvar_5_113 = var_6_114;\nvar_5_114 = var_6_115;\ngoto Block_5;\n\nBlock_4:\n// prepare block arguments\nvar_6_103 = var_4_101;\nvar_6_104 = var_4_102;\nvar_6_105 = var_4_103;\nvar_6_106 = var_4_104;\nvar_6_107 = var_4_105;\nvar_6_108 = var_4_106;\nvar_6_109 = var_4_107;\nvar_6_110 = var_4_108;\nvar_6_111 = var_4_109;\nvar_6_112 = var_4_110;\nvar_6_113 = var_4_111;\nvar_6_114 = var_4_112;\nvar_6_115 = var_4_113;\ngoto Block_6;\n\nBlock_2:\ndetachJVM();\nNES__Runtime__TupleBuffer__setNumberOfTuples(var_2_109,var_2_113);\nNES__Runtime__TupleBuffer__setWatermark(var_2_109,var_2_112);\nNES__Runtime__TupleBuffer__setOriginId(var_2_109,var_2_111);\nNES__Runtime__TupleBuffer__setSequenceNr(var_2_109,var_2_110);\nemitBufferProxy(var_2_107,var_2_108,var_2_109);\nreturn;\n\n}\n", 
                   "inputData": random.choice([1024, 2048]), 
                   "constraint": ""} for node in G.nodes()]
    final_json = {
        "operatorGraph": graph_info,
        **fixed_info
    }
    with open(file_name, 'w') as file:
        json.dump(final_json, file, indent=4)
        cnt += 1

