# Preprocessing of kernel runs #

* I have one dataset for the cpu, and one for the gpu.

1. Merge all the data from the cpu in one cpu_dataset, and all the data from the gpu in one gpu_dataset.
2. Remove all the initialization kernels (if for the same kernel, we have gsize!=0 and InputByte constant, or 0 with OutputByte!=0 remove this kernel). 

* Clean dataset

3. Keep only the average time.
4. In the final csv, I'll have one column for the device time, and one other for the device+transfer time together. I also check their distribution.
5. Split the dataset based on unique kernels.

## Codes for preprocessing:

1. [compiled_and_not_compiled_kernels.py](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/compiled_and_not_compiled_kernels.py) <br>
   - This script reads results.csv from the different runs, and returns which kernels are compiled and which are not, in the form of two dataframes converted into csv.<br>
   **Argument List:** <br>
   ['compiled_and_not_compiled_kernels.py', 'results/cpu/results_epyc7_cpu_exp2.csv', 'results/analyzing_compiled_uncompiled_kernels/uncompiled_kernels_epyc7_cpu_exp1.csv', 'epyc7', 'cpu', 'exp2']

2. [visualization.py](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/visualization.py)   
   - Count all the compiled and uncompiled kernels for each machine, and for each device. Then, we print how many unique kernels I have for compiled kernels. <br>
   **Argument List:**<br>
   ['visualization.py', 'results/cpu/', 'results/analyzing_compiled_uncompiled_kernels/', 'compiledkernels', 'silver1', 'cpu', 'CPU']
   
3. [preprocessing_kernels_runs.py](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/preprocessing_kernels_runs.py) 
   - Separate the csv results file of gold2, into gold2_gpu & gold_cpu. <br>
   - Join the input csv for all the machines into one for cpu, and one for gpu. <br>
   - I group the data __on kernel and on device__, and, 
   - I *remove* the intialization kernels (__Initialization kernels__ are those which have for the same kernel, gsize <> 0, and inputByte = constant or 0, and output <> 0). (For checking the condition for InputByte, I use the function is_unique(s)).
   - I keep the essential kernel attributes: <br>
   ['kernel', 'gsize', 'device', 'input_bytes', 'output_bytes', 'device_mean', 'transfer_mean', 'machine', 'hostcode_mean'] + 'devicetransfer' <br>
   **Argument List:**<br>
   ['preprocessing_kernels_runs.py', 'results/gpu_cpu_together', 'results/cpu', 'results/gpu'] <br>
   **Output:** <br>
   final_gpu.csv and final_cpu.csv
4. [random_split_dataset_step0.py](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/random_split_dataset_step0.py)
    - **team1:** consists of silver1 (Tesla 2018, cpu 2017) and epyc7 (A100 2020, cpu 2019). <br>
    - **team2:** consists of gold2 (GeForce 2018, cpu 2017) and dungani (Quadro 2015, Tesla 2013, cpu 2013). <br>
   
   - When my input (final_csv) is from CPU, then I create a new column, encoding this information (team1['#device']=0). <br> When my input is from GPU, then the encoding goes like this: team1['#device']=1).
   - I create csv, so as to have team1_cpu.csv and team1_gpu.csv (for team1) and team2_cpu.csv and team2_gpu.csv (for team2).
   - Randomly split the dataset based on unique kernels, and for each machine. Create 2 teams, team1 with silver1 and epyc7, and team2 with gold2 and dungani.
   
   
   silver1 **CPU**                     |    epyc7 **CPU**
   ----------------------------  | ----------------------------
   367 runs (54 unique kernels) | 217 runs (54 unique kernels)
   

   gold2 **CPU**                 |    dungani **CPU**
   ---------------------------- | ----------------------------
   318 runs (75 unique kernels) | 209 runs (50 unique kernels)
   
   
5. [random_split_dataset_step1.py](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/random_split_dataset_step1.py)
   
   - I have to run [random_split_dataset_step1.py](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/random_split_dataset_step1.py) for *team1_cpu.csv, team1_gpu.csv, team2_cpu.csv, and team2_gpu.csv*
   
   - **def split_on_teams(args)** <br>
  
      For each team, before I split it into kfolder and testfolder, I keep the name of the unique kerenls, and I compare them with the llvm ir files. For every llvm ir file that have correspondence to the unique kernels of the team, I copy them to the corresponding team folder. <br>
      
      *(Create for each team the corresponding ir folder, based on its unique kernels).*
      
      ex. for team1 folder, I create ir_cpu with ir files which belong to the kernels of team1 (for cpu).
   
   - **class split_llvmir()** <br>
   
     ```python
     def __init__(self, pathlife) #ex. the pathfile of ir_cpu folder.
     def __init__(self) : #len of files in the ir_cpu folder.
     def __getitem__(self,args)
     ```
     
     Split a file (ex. ir_cpu folder) into kfolder and testfolder, *given the percentage to go in the large file*. <br> 
     ex. **folder ir_cpu** : kfolder_cpu **+** testfolder_cpu.
      
     
 
 ```mermaid
  graph TD;
      Team1-->kfolder;
      Team1-->testfolder;
      
      kfolder-->cpu_k;
      kfolder-->gpu_k;
      cpu_k-->k1_cpu;
      cpu_k-->...;
      cpu_k-->k5_cpu;      
      gpu_k-->k1_gpu;
      gpu_k-->..;
      gpu_k-->k5_gpu;
      
      testfolder-->cpu_test;
      testfolder-->gpu_test;
```

 ```mermaid
  graph TD;
      Team2-->kfolder;
      Team2-->testfolder;
      
      kfolder-->cpu_k;
      kfolder-->gpu_k;
      cpu_k-->k1_cpu;
      cpu_k-->...;
      cpu_k-->k5_cpu;      
      gpu_k-->k1_gpu;
      gpu_k-->..;
      gpu_k-->k5_gpu;
      
      testfolder-->cpu_test;
      testfolder-->gpu_test;
```
  
