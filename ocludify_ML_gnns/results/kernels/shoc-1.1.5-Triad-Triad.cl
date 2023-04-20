#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global const float* a, __global const float* b, __global float* c, const float d) {
  int e = get_global_id(0);
  c[e] = a[e] + d * b[e];
}

