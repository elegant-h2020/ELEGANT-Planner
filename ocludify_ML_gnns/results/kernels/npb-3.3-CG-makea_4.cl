#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global int* a, __global int* b, __global int* c, __global int* d, int e, int f) {
  int g = get_global_id(0);
  int h = get_global_size(0);
  int i = c[g];
  if (i >= e)
    return;
  int j = d[g];

  __global int* k = &a[f];

  for (int l = i + 1; l < j; l++) {
    k[l] = k[l] + k[l - 1];
  }
  if (g < h)
    b[g] = k[j - 1];
}
