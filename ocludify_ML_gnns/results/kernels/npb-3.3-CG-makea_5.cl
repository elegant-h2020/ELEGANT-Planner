#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global int* a, __global int* b, __global int* c, __global int* d, int e, int f) {
  int g = get_global_id(0);
  int h = get_global_size(0);
  int i = c[g];
  if (i >= e)
    return;
  int j = d[g];

  int k = 0;
  if (g < h) {
    for (int l = 0; l < g; l++) {
      k = k + b[l];
    }
  }
  if (k > 0) {
    __global int* m = &a[f];
    for (int n = i; n < j; n++) {
      m[n] = m[n] + k;
    }
  }
}
