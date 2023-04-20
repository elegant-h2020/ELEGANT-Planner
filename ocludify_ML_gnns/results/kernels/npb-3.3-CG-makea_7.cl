#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global int* a, __global int* b, int c, int d) {
  int e = get_global_id(0) + 1;
  if (e >= (c + 1))
    return;

  __global int* f = &b[d];

  a[e] = a[e] - f[e - 1];
}
