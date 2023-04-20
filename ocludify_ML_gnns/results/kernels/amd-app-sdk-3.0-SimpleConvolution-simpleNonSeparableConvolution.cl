#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global uint* a, __global float* b, __global int* c, const uint2 d, const uint2 e, const uint f) {
  uint g = get_global_id(0);

  uint h = d.x;
  uint i = d.y;

  uint j = g % h;
  uint k = g / h;

  uint l = e.x;
  uint m = e.y;

  if (j >= h || k >= i)
    return;

  float n = 0.0f;
  int o = 0, p = 0;

  for (uint q = k; q < (k + m); ++q, o++) {
    p = 0;
    for (uint r = j; r < (j + l); ++r, p++) {
      uint s = o * l + p;
      uint t = q * f + r;

      n += ((float)a[t] * b[s]);
    }
  }

  n += 0.5f;
  c[g] = (int)n;
}
