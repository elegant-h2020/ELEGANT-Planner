#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global double* a, __global double* b, __local double* c, int d, int e, int f, int g, int h) {
  int i, j, k, l, m;
  __global double(*n)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5];
  __local double* o;

  k = get_global_id(0) + 1;
  m = get_local_id(0);
  o = &c[m * 5];

  for (l = 0; l < 5; l++) {
    o[l] = 0.0;
  }

  if (k < 12 - 1) {
    n = (__global double(*)[12 / 2 * 2 + 1][12 / 2 * 2 + 1][5])a;

    for (j = g; j < h; j++) {
      for (i = e; i < f; i++) {
        for (l = 0; l < 5; l++) {
          o[l] = o[l] + n[k][j][i][l] * n[k][j][i][l];
        }
      }
    }
  }

  barrier(1);

  if (m == 0) {
    for (i = 1; i < get_local_size(0); i++) {
      __local double* p = &c[i * 5];
      for (l = 0; l < 5; l++) {
        o[l] += p[l];
      }
    }

    __global double* q = &b[get_group_id(0) * 5];
    for (l = 0; l < 5; l++) {
      q[l] = o[l];
    }
  }
}

