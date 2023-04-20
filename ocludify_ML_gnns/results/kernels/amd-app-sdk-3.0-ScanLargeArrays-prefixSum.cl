#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global float* a, __global float* b, __local float* c, const uint d) {
  int e = get_local_id(0);
  int f = get_global_id(0);
  int g = get_group_id(0);

  c[2 * e] = b[2 * f];
  c[2 * e + 1] = b[2 * f + 1];
  barrier(1);

  float h = c[0];
  float i = h + c[1];

  for (int j = 1; j < d; j *= 2) {
    if (2 * e >= j) {
      h = c[2 * e - j] + c[2 * e];
      i = c[2 * e + 1 - j] + c[2 * e + 1];
    }
    barrier(1);

    c[2 * e] = h;
    c[2 * e + 1] = i;

    barrier(1);
  }

  if (e == 0) {
    a[2 * f] = 0;
    a[2 * f + 1] = c[2 * e];
  } else {
    a[2 * f] = c[2 * e - 1];
    a[2 * f + 1] = c[2 * e];
  }
}
