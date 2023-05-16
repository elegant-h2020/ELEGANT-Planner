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
   This script reads results.csv from the different runs, and returns which kernels are compiled and which are not, in the form of two dataframes converted into csv.<br>
   **Argument List:** <br>
   ['compiled_and_not_compiled_kernels.py', 'results/cpu/results_epyc7_cpu_exp2.csv', 'results/analyzing_compiled_uncompiled_kernels/uncompiled_kernels_epyc7_cpu_exp1.csv', 'epyc7', 'cpu', 'exp2']

2. [visualization.py](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/visualization.py)   
   Count all the compiled and uncompiled kernels for each machine, and for each device. Then, we print how many unique kernels I have for compiled kernels.
   **Argument List:**<br>
   ['visualization.py', 'results/cpu/', 'results/analyzing_compiled_uncompiled_kernels/', 'compiledkernels', 'silver1', 'cpu', 'CPU']
3.     
4. 
5. 
     
      2. visualization.py
      3. preprocessing_kernels_runs.py
      4. random_split_dataset_step0.py
      5. random_split_dataset_step1.py
      
