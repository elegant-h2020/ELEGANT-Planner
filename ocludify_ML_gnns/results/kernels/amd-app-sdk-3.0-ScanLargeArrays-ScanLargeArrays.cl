#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global float* a, __global float* b, __local float* c, const uint d, __global float* e) {
  int f = get_local_id(0);
  int g = get_global_id(0);
  int h = get_group_id(0);

  c[2 * f] = b[2 * g];
  c[2 * f + 1] = b[2 * g + 1];
  barrier(1);

  float i = c[0];
  float j = i + c[1];

  for (int k = 1; k < d; k *= 2) {
    if (2 * f >= k) {
      i = c[2 * f - k] + c[2 * f];
      j = c[2 * f + 1 - k] + c[2 * f + 1];
    }
    barrier(1);

    c[2 * f] = i;
    c[2 * f + 1] = j;

    barrier(1);
  }

  e[h] = c[d - 1];

  if (f == 0) {
    a[2 * g] = 0;
    a[2 * g + 1] = c[2 * f];
  } else {
    a[2 * g] = c[2 * f - 1];
    a[2 * g + 1] = c[2 * f];
  }
}
