## Checking for Kernels common across all the machines ##

- **[check_common_values_kernels_inputbytes.py](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/check_common_values_kernels_inputbytes.py)** is the source code for finding kernels common across all the machines which have also common input bytes.
The above python code consists of the following functions:
  1. ```def check_common_value(df)``` : This function takes as input ***final_cpu.csv***[^1] or ***final_gpu.csv***[^1] and finds kernels across all groups created by machines

  2. ```def create_df(commonkernels, df)```: This function creates a dataframe out of the initial dataframe, based on the kernels common accross all groups

  3. ```def check_input_bytes(args, filtered_df)```: This function groups the output of ```def create_df()``` function (filtered_df) based on the **kernel** and **machine** columns, and finds the common across all machines, kernels (see 1), that have at least one common input_byte.

  4. ``` def create_final_df(filtered_df, finalkernels, finalbytes)```: This function creates a dataframe out of the initial dataframe, based on the kernels and bytes that are common accross all groups

**Output** of the .py code is 2 csv files, ***commonkernelsinputbytes_acrossmachines_gpu.csv*** for gpu and ***commonkernelsinputbytes_acrossmachines_cpu.csv*** for cpu.
 <br>

[^1]: All the input csv for all the machines into one for cpu and one for gpu.
