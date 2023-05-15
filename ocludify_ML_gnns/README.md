# Preprocessing of kernel runs #

* I have one dataset for the cpu, and one for the gpu.

1. Merge all the data from the cpu in one cpu_dataset, and all the data from the gpu in one gpu_dataset.
2. Remove all the initialization kernels (if for the same kernel, we have gsize!=0 and InputByte constant, or 0 with OutputByte!=0 remove this kernel). 


## Codes for preprocessing:
      1. compiled_and_not_compilded_kernels.py
      2. visualization.py
      3. preprocessing_kernels_runs.py
      4. random_split_dataset_step0.py
      5. random_split_dataset_step1.py
