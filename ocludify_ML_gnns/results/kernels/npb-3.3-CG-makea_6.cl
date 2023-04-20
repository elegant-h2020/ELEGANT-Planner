#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global double* a, __global double* b, __global int* c, __global int* d, __global int* e, int f, int g) {
  int h, i, j;
  int k = get_global_id(0);
  if (k >= g)
    return;

  __global int* l = &e[f];

  if (k > 0) {
    h = c[k] - l[k - 1];
  } else {
    h = 0;
  }
  i = c[k + 1] - l[k];
  j = c[k];
  for (int m = h; m < i; m++) {
    a[m] = b[j];
    d[m] = e[j];
    j = j + 1;
  }
}
