#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global float* a, __global float* b, __local float* c, const uint d, const uint e) {
  int f = get_local_id(0);
  int g = get_local_size(0);
  int h = get_group_id(0);

  h = (e * (2 * (h * g + f) + 1)) - 1;
  if (h < d) {
    c[2 * f] = b[h];
  }
  if (h + e < d) {
    c[2 * f + 1] = b[h + e];
  }

  int i = 1;
  for (int j = d >> 1; j > 0; j >>= 1) {
    barrier(1);
    if (f < j) {
      int k = i * (2 * f + 1) - 1;
      int l = i * (2 * f + 2) - 1;
      c[l] += c[k];
    }
    i <<= 1;
  }

  if (d > 2) {
    if (i < d) {
      i <<= 1;
    }

    int m = i >> 1;
    for (int n = 0; n < m; n <<= 1) {
      n += 1;
      i >>= 1;
      barrier(1);

      if (f < n) {
        int k = i * (f + 1) - 1;
        int l = k + (i >> 1);
        c[l] += c[k];
      }
    }
  }
  barrier(1);

  if (h < d) {
    a[h] = c[2 * f];
  }
  if (h + e < d) {
    a[h + e] = c[2 * f + 1];
  }
}

