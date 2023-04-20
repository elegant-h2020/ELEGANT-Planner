#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global float2* a, __global float* b, const int c, const float d, const float e) {
  int f = get_global_id(0);

  if (f < c) {
    __global float2* g = a + f;

    __global float* h = b + f;
    *h = (float)sqrt((d - g[f].x) * (d - g[f].x) + (e - g[f].y) * (e - g[f].y));
  }
}
