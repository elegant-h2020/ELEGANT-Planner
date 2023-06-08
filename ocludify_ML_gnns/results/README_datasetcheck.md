## Checking for Kernels common across all the machines ##

- **[check_common_values_kernels_inputbytes.py](https://github.com/elegant-h2020/ELEGANT-Planner/blob/ML-GNNs/ocludify_ML_gnns/results/check_common_values_kernels_inputbytes.py)** is the source code for finding kernels common across all the machines which have also common input bytes.
The above python code consists of the following functions:
  1. ```def check_common_value(df)``` # This function finds kernels across all groups created by machines

  2. ``` def create_final_df(filtered_df, finalkernels, finalbytes)``` <br>
