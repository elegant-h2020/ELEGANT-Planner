#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global float* a, __global float* b, __global int* c, const uint2 d, const uint e, const uint2 f) {
  int g = 0, h = 0;

  uint i = d.x;
  uint j = d.y;

  uint k = get_global_id(0);
  uint l = k % j;
  uint m = k / j;

  if (m >= i || l >= j)
    return;

  float n = 0.0f;

  for (uint g = l; g < (l + e); ++g) {
    n = mad(a[m * f.y + g], b[h++], n);
  }

  n += 0.5f;
  c[l * i + m] = (int)n;
}
