#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global float* a, __global float* b) {
  int c = get_global_id(0);
  int d = get_group_id(0);
  int e = get_local_id(0);

  __local float f[1];

  if (e == 0) {
    f[0] = a[d];
  }
  barrier(1);

  b[c] += f[0];
}
