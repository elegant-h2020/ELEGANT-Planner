#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global int* a, __global int* b, __global int* c, __global int* d) {
  int e = get_global_id(0);
  int f = get_global_size(0);

  int g = 0;
  if (e < f) {
    for (int h = 0; h < e; h++) {
      g = g + b[h];
    }
  }
  if (g > 0) {
    int i = (e == 0) ? 0 : (c[e] + 1);
    int j = d[e] + 1;

    for (int k = i; k < j; k++) {
      a[k] = a[k] + g;
    }
  }
}
