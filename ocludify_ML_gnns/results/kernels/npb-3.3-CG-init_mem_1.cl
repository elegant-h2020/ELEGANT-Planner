#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global double* a, int b) {
  int c = get_global_id(0);
  if (c >= b)
    return;
  a[c] = 0.0;
}
