#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global double* a, __global double* b, __global double* c, __global double* d, int e) {
  int f = get_global_id(0);
  if (f >= e)
    return;

  a[f] = 0.0;
  b[f] = 0.0;
  c[f] = 0;
  d[f] = 0;
}
