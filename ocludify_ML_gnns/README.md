# Oclude runs #

* **[ocludify.py](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/ocludify.py)** runs the **oclude profiler** (which must be installed) on a list of OpenCL kernels and times them. To run it expects 3 files:
  
   1. a **csv file** with the list of kernels to run. The name of this csv is stored in the **constant [KERNELS_FILE](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/cgo17-amd.csv)** in the GLOBAL VARIABLE SECTION.
   2. a **csv file** with the list of configurations to use for each kernel. The name of this csv is stored in the **CONFIG_FILE**. The script will only deal with the kernels listed in the **CONFIG_FILE**, regardless of how many kernels are listed in the [KERNELS_FILE](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/cgo17-amd.csv). This is because the **CONFIG_FILE** is expected to be manually edited by the user to specify the kernels to run and their respective configurations.
   3. a **simple text file** with the list of OpenCL devices to run  the kernels on.

   > As listed below, I used 4 machines for my experiments. An **example** of running the oclude profiler in epyc7, based on the three aforementioned csvs' is the following:

   > I'm using the [ocludify_epyc7.py](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/ocludify_epyc7.py) file, and I change the parameters accordingly.
   > ```python3 
   > # Change the arguments each time.
   > machine = 'epyc7'
   > model = 'CPU'
   > #model = 'NvidiaA100'
   > exp = 'exp2' #'exp1'
   > ```

   > ```
   > KERNELS_FILE = 'cgo17-amd.csv'
   > CONFIG_FILE = 'uncompiledkernels_epyc7_cpu_exp1.csv' #uncompiled kernels from experiment1
   > #CONFIG_FILE = 'benchmarks_config.csv'
   > DEVICES_FILE = f'devices_{machine}.txt'
   > ```





## Machines 

* I used 4 machines for my experiments.

1. **dungani**
2. **silver1**
3. **gold2**
4. **epyc7**


## Oclude runs

- **Experiment1**

| Machines        | Device Type         | Platform Type  | Platform ID         |Device ID  |Gsizes  |Samples  |Timeouts  |Output File  |Compiled Kernels  |
| ------------- |:-------------:|:-----:|:-------------:|:-------------:|:-------------:|:-------------:|:-------------:|:-------------:|:-------------:|
| epyc7      | NVIDIA A100-PCIE-40GB | NVIDIA CUDA | 0 | 0 |[1000,21000,2000] |200 |[10,15,20] |[results_epyc7_NvidiaA100_exp1.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/gpu/results_epyc7_NvidiaA100_exp1.csv) |855 #runs and 112 unique kernels |
| epyc7      | pthread-AMD EPYC 7402 24-Core Processor   | Portable Computing Language | 1 | 0 |[1000,21000,2000] |200 |[10,15,20] |[results_epyc7_CPU_exp1.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/cpu/results_epyc7_CPU_exp1.csv) |293 (#runs) 55 (unique kernels) |
| silver1      | Tesla V100-SXM2-32GB | NVIDIA CUDA | 0 | 0 |[1000,21000,2000] |200 |[10,15,20] |[results_silver1_Tesla_exp1.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/gpu/results_silver1_Tesla_exp1.csv) |853 (#runs) 110 (unique kernels) |
| silver1      | pthread-Intel(R) Xeon(R) Silver 4114 CPU @ 2.20GHz   |  Portable Computing Language | 1 | 0 |[1000,21000,2000] |200 |[10,15,20] |[results_silver1_CPU_exp1.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/cpu/results_silver1_CPU_exp1.csv) |61 (#runs) 7 (unique kernels) | 
| gold2      | GeForce GTX 1060 6GB | NVIDIA CUDA | 0 | 0 |[1000,21000,2000] |200 |[10,15,20] |[results_gold2_GeForceGTX_IntelXeonCPU_exp1.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/gpu_cpu_together/results_gold2_GeForceGTX_IntelXeonCPU_exp1.csv) |1248 (#runs) 120 (unique kernels) numbers with cpu|
| gold2      | Intel(R) Xeon(R) Gold 5120 CPU @ 2.20GHz   |  Intel(R) OpenCL | 1 | 0 |[1000,21000,2000] |200 |[10,15,20] |[results_gold2_GeForceGTX_IntelXeonCPU_exp1.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/gpu_cpu_together/results_gold2_GeForceGTX_IntelXeonCPU_exp1.csv) |1248 (#runs) 120 (unique kernels) numbers with gpu | 
| dungani      | Quadro M4000 | NVIDIA CUDA | 1 | 0 |[1000,21000,2000] |200 |[10,15,20] |[results_dungani_QuadroTesla_exp1.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/gpu/results_dungani_QuadroTesla_exp1.csv) |1648 (#runs) 110 (unique kernels) together with TeslaK40 |
| dungani      | Tesla K40     |  NVIDIA CUDA | 0 | 2 |[1000,21000,2000] |200 |[10,15,20] |[results_dungani_QuadroTesla_exp1.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/gpu/results_dungani_QuadroTesla_exp1.csv) |1648 (#runs) 110 (unique kernels) together with Quadro M4000 | 
| dungani | pthread-Intel(R) Core(TM) i7-4820K CPU @ 3.70GHz      |    Portable Computing Language | 1 | 0 |[1000,21000,2000] |200 |[10,15,20] |[results_dungani_CPU_exp1.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/cpu/results_dungani_CPU_exp1.csv) |296 (#runs) 58 (unique kernels) |

- **Experiment2**

| Machines        | Device Type         | Platform Type  | Platform ID         |Device ID  |Gsizes  |Samples  |Timeouts  |Output File  |Compiled Kernels  |
| ------------- |:-------------:|:-----:|:-------------:|:-------------:|:-------------:|:-------------:|:-------------:|:-------------:|:-------------:|
| epyc7      | NVIDIA A100-PCIE-40GB | NVIDIA CUDA | 0 | 0 |[100,1000,100] |200 |[10,35] |[results_epyc7_NvidiaA100_exp1.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/gpu/results_epyc7_NvidiaA100_exp2.csv) |322 (#runs) 54 (unique kernels) |
| epyc7      | pthread-AMD EPYC 7402 24-Core Processor   | Portable Computing Language | 1 | 0 |[100,1000,100] |200 |~~[10,35]~~ [35,40] |[results_epyc7_CPU_exp2.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/cpu/results_epyc7_CPU_exp2.csv) |15 (#runs) 9 (unique kernels) |
| silver1      | Tesla V100-SXM2-32GB | NVIDIA CUDA | 0 | 0 |[100,1000,100] |200 |~~[10,35]~~ [35,40] |[results_silver1_Tesla_exp2.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/gpu/results_silver1_Tesla_exp2.csv) |344 (#runs) 56 (unique kernels)  |
| silver1      | pthread-Intel(R) Xeon(R) Silver 4114 CPU @ 2.20GHz   |  Portable Computing Language | 1 | 0 |[100,1000,100] |200 |~~[10,35]~~ [35,40] |[results_silver1_CPU_exp2.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/cpu/results_silver1_CPU_exp2.csv) |387 (#runs) 56 (unique kernels) | 
| gold2      | GeForce GTX 1060 6GB | NVIDIA CUDA | 0 | 0 |[100,1000,100] |200 |[10,35] |[results_gold2_GeForceGTX_IntelXeonCPU_exp2.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/gpu_cpu_together/results_gold2_GeForceGTX_IntelXeonCPU_exp2.csv) |302 (#runs) 48 (unique kernels) together with cpu |
| gold2      | Intel(R) Xeon(R) Gold 5120 CPU @ 2.20GHz   |  Intel(R) OpenCL | 1 | 0 |[100,1000,100] |200 |[10,35] |[results_gold2_GeForceGTX_IntelXeonCPU_exp2.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/gpu_cpu_together/results_gold2_GeForceGTX_IntelXeonCPU_exp2.csv) |302 (#runs) 48 (unique kernels) together with gpu | 
| dungani      | Quadro M4000 | NVIDIA CUDA | 1 | 0 |[100,1000,100] |200 |[10,35] |[results_dungani_QuadroTesla_exp2.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/gpu/results_dungani_QuadroTesla_exp2.csv) |443 (#runs) 55 (unique kernels) together with TeslaK40 |
| dungani      | Tesla K40     |  NVIDIA CUDA | 0 | 2 |[100,1000,100] |200 |[10,35] |[results_dungani_QuadroTesla_exp2.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/gpu/results_dungani_QuadroTesla_exp2.csv) |443 (#runs) 55 (unique kernels) together with Quadro M4000 | 
| dungani | pthread-Intel(R) Core(TM) i7-4820K CPU @ 3.70GHz      |    Portable Computing Language | 1 | 0 |[100,1000,100] |200 |[10,35] |[results_dungani_CPU_exp2.csv](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/cpu/results_dungani_CPU_exp2.csv) |4 (#runs) 2 (unique kernels) |



# Preprocessing of kernel runs #

* I have one dataset for the cpu, and one for the gpu.

1. Merge all the data from the cpu in one cpu_dataset, and all the data from the gpu in one gpu_dataset.
2. Remove all the initialization kernels (if for the same kernel, we have gsize!=0 and InputByte constant, or 0 with OutputByte!=0 remove this kernel). 

* Clean dataset

3. Keep only the average time.
4. In the final csv, I'll have one column for the device time, and one other for the device+transfer time together. I also check their distribution.
5. Split the dataset based on unique kernels.

## Codes from oclude:

1. [clinfaux.py](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/clinfaux.py) <br>
   Instead of running the **clinfo -l** opencl command, I run [clinfaux.py](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/clinfaux.py) so as to check how opencl splits the machines.
2. [lextab.py](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/lextab.py) <br>
   This file is automatically created by PLY (version 3.10). Don't edit!
3. [ocludify.ipynb](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/ocludify.ipynb) <br>
   This script runs the **oclude profiler**, which must be installed, on a list of OpenCL kernels.
4. [yacctab.py](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/yacctab.py) <br>
   This file is automatically generated. Do not edit!
   
## Codes to run oclude:

## Codes for preprocessing (after oclude compilation and before training):

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
   
   - ```def split_on_teams(args)``` <br>
  
      For each team, before I split it into kfolder and testfolder, I keep the name of the unique kerenls, and I compare them with the llvm ir files. For every llvm ir file that have correspondence to the unique kernels of the team, I copy them to the corresponding team folder. <br>
      
      *(Create for each team the corresponding ir folder, based on its unique kernels).*
      
      ex. for team1 folder, I create ir_cpu with ir files which belong to the kernels of team1 (for cpu).
   
   - ```class split_llvmir()``` <br>
   
     ```python
     def __init__(self, pathlife) #ex. the pathfile of ir_cpu folder.
     def __init__(self) : #len of files in the ir_cpu folder.
     def __getitem__(self,args)
     ```
     
     Split a file (ex. ir_cpu folder) into kfolder and testfolder, *given the percentage to go in the large file*. <br> 
     ex. **folder ir_cpu** : kfolder_cpu **+** testfolder_cpu.
   
   - ```def fold_into_df(args,fold)``` <br>
   
      - For each filename, inside the **kfolder**, where the llvm ir code exists, if there is any row of the team dataframe, with the same kernel name, I keep the rows in a new dataframe. So, *I create a new dataframe, corresponding to all the runs of the kernels of the kfolder (kfold_df)*.  <br>
      - I'm doing the same with the **testforlder**, so as to *create a new dataframe, corresponding to all the runs of the kernels that belong to the testfolder*.
   
   - ```def kfolds_split(kfold_df, k)``` <br>
   
      - For the cross validation, I need to create the *k chunks*. I'm taking the **kfold_df** dataframe (kfolder_cpu, kfolder_gpu), and at first I shuffle the rows. Then I split the dataframe into k parts that have equal size. From this function I return the *k chunks*.
   
   - ```def makedirectories(args,chunks)``` <br>
   
      - I create **dynamically directories**, so for range (0, kfold), I create the directories 0, 1, 2, ... kfold (ex.kfold=5). For every chunk, I have to save its data into every corresponding directory. So, for the data from chunk0, I have to first copy the llvm ir files from kfolder_cpu (or kfolder_gpu), into the directory of chunk0. Then for these runs I create a new csv, called cpu.csv (or gpu.csv).
      
         (*Instead of splitting the kfolds ir files based on kernels, I split the ir files of the kfolds based on runs*).
         
         ex. I want to split randomly in chunks the files inside the kfolder_cpu. I'm taking the rows of team1_cpu.csv (after converting it into dataframe), and if there is a row belonging to some of the k_i, create the corresponding csv.
     
 
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
  
