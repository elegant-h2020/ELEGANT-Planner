#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global double* a) {
  int b = get_global_id(0);
  if (b >= (128 + 1))
    return;

  a[b] = 1.0;
}
