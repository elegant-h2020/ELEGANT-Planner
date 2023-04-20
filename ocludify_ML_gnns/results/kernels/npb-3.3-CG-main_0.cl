#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global int* a, __global int* b, int c, int d) {
  int e = (int)(get_global_id(0) / 64);
  int f = get_local_id(0);

  int g = b[e];
  int h = b[e + 1];
  for (int i = g + f; i < h; i += 64) {
    a[i] = a[i] - c;
  }
}
