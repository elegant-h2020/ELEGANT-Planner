# Preprocessing of kernel runs #

* I have one dataset for the cpu, and one for the gpu.

1. Merge all the data from the cpu in one cpu_dataset, and all the data from the gpu in one gpu_dataset.
2. Remove all the initialization kernels (if for the same kernel, we have gsize!=0 and InputByte constant, or 0 with OutputByte!=0 remove this kernel). 

* Clean dataset

3. Keep only the average time.
4. In the final csv, I'll have one column for the device time, and one other for the device+transfer time together. I also check their distribution.
5. Split the dataset based on unique kernels.

## Codes for preprocessing:
1. [compiled_and_not_compiled_kernels.py](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/compiled_and_not_compiled_kernels.py)
2.
3. 
     
      2. visualization.py
      3. preprocessing_kernels_runs.py
      4. random_split_dataset_step0.py
      5. random_split_dataset_step1.py
      
