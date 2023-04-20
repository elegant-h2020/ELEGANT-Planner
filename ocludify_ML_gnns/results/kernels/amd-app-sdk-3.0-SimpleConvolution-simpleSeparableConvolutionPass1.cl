#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global uint* a, __global float* b, __global float* c, const uint2 d, const uint e, const uint2 f) {
  int g = 0, h = 0;

  uint i = d.x;
  uint j = d.y;

  uint k = get_global_id(0);
  uint l = k % i;
  uint m = k / i;

  if (l >= i || m >= (j + e - 1))
    return;

  float n = 0.0f;

  for (uint g = l; g < (l + e); ++g) {
    n = mad((float)a[m * f.x + g], b[h++], n);
  }

  c[l * f.y + m] = n;
}
