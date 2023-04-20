#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global int* a, __global int* b, __global int* c, __global int* d, __global int* e, __global int* f, int g) {
  __global int(*h)[1 + 1] = (__global int(*)[1 + 1])c;

  int i, j, k, l, m;

  int n = get_global_id(0);
  int o = get_global_size(0);
  int p = e[n];
  if (p >= g)
    return;
  int q = f[n];

  k = p + 1;
  l = q + 1;

  for (i = 0; i < g; i++) {
    for (m = 0; m < b[i]; m++) {
      j = h[i][m];
      if (j >= p && j < q) {
        j = j + 1;
        a[j] = a[j] + b[i];
      }
    }
  }

  if (n == 0) {
    a[0] = 0;
    k = 0;
  }
  for (j = k + 1; j < l; j++) {
    a[j] = a[j] + a[j - 1];
  }
  if (n < o)
    d[n] = a[l - 1];
}
