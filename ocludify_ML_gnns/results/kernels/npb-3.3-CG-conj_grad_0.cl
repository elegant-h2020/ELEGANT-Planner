#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global double* a, __global double* b, __global double* c, __global double* d, __global double* e) {
  int f = get_global_id(0);
  if (f >= (128 + 1))
    return;

  a[f] = 0.0;
  b[f] = 0.0;
  double g = d[f];
  c[f] = g;
  e[f] = g;
}
