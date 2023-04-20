#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global char* a, short b, int c) {
  const int d = get_global_id(0);
  a[d] = b;
}
