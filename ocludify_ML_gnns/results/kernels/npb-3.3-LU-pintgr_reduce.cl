#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global double* a, __global double* b, __global double* c, __local double* d, int e, int f, int g, int h) {
  int i, j, k;
  double l = 0.0;

  j = get_global_id(0) + g;
  k = get_local_id(0);

  if (j < h) {
    __global double(*m)[12 + 2] = (__global double(*)[12 + 2])a;
    __global double(*n)[12 + 2] = (__global double(*)[12 + 2])b;

    for (i = e; i < f; i++) {
      l = l + (m[j][i] + m[j][i + 1] + m[j + 1][i] + m[j + 1][i + 1] + n[j][i] + n[j][i + 1] + n[j + 1][i] + n[j + 1][i + 1]);
    }
  }
  d[k] = l;

  barrier(1);

  if (k == 0) {
    for (i = 1; i < get_local_size(0); i++) {
      l += d[i];
    }

    c[get_group_id(0)] = l;
  }
}
