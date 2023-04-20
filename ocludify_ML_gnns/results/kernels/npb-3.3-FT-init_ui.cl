#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global double* a, __global double* b, __global double* c, int d) {
  int e = get_global_id(0);
  if (e >= d)
    return;

  a[e] = (double)0.0;
  b[e] = (double)0.0;
  c[e] = 0.0;
}
