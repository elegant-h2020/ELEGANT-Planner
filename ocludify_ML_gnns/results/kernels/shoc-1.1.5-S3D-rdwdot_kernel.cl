#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global const float* a, __global const float* b, __global float* c, const float d, __global const float* e) {
  float f = ((a[(((5) - 1) * (8)) + (get_global_id(0))]) - (b[(((5) - 1) * (8)) + (get_global_id(0))])) + ((a[(((6) - 1) * (8)) + (get_global_id(0))]) - (b[(((6) - 1) * (8)) + (get_global_id(0))])) + ((a[(((7) - 1) * (8)) + (get_global_id(0))]) - (b[(((7) - 1) * (8)) + (get_global_id(0))])) + ((a[(((8) - 1) * (8)) + (get_global_id(0))]) - (b[(((8) - 1) * (8)) + (get_global_id(0))]));
  float g = ((a[(((12) - 1) * (8)) + (get_global_id(0))]) - (b[(((12) - 1) * (8)) + (get_global_id(0))])) + ((a[(((13) - 1) * (8)) + (get_global_id(0))]) - (b[(((13) - 1) * (8)) + (get_global_id(0))])) + ((a[(((14) - 1) * (8)) + (get_global_id(0))]) - (b[(((14) - 1) * (8)) + (get_global_id(0))])) + ((a[(((15) - 1) * (8)) + (get_global_id(0))]) - (b[(((15) - 1) * (8)) + (get_global_id(0))]));

  (c[(((2) - 1) * (8)) + (get_global_id(0))]) =
      (-((a[(((1) - 1) * (8)) + (get_global_id(0))]) - (b[(((1) - 1) * (8)) + (get_global_id(0))])) + ((a[(((2) - 1) * (8)) + (get_global_id(0))]) - (b[(((2) - 1) * (8)) + (get_global_id(0))])) + ((a[(((3) - 1) * (8)) + (get_global_id(0))]) - (b[(((3) - 1) * (8)) + (get_global_id(0))])) - f - f - ((a[(((9) - 1) * (8)) + (get_global_id(0))]) - (b[(((9) - 1) * (8)) + (get_global_id(0))])) - ((a[(((10) - 1) * (8)) + (get_global_id(0))]) - (b[(((10) - 1) * (8)) + (get_global_id(0))])) - g -
       ((a[(((17) - 1) * (8)) + (get_global_id(0))]) - (b[(((17) - 1) * (8)) + (get_global_id(0))])) - ((a[(((18) - 1) * (8)) + (get_global_id(0))]) - (b[(((18) - 1) * (8)) + (get_global_id(0))])) - ((a[(((19) - 1) * (8)) + (get_global_id(0))]) - (b[(((19) - 1) * (8)) + (get_global_id(0))])) - ((a[(((24) - 1) * (8)) + (get_global_id(0))]) - (b[(((24) - 1) * (8)) + (get_global_id(0))])) - ((a[(((25) - 1) * (8)) + (get_global_id(0))]) - (b[(((25) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((30) - 1) * (8)) + (get_global_id(0))]) - (b[(((30) - 1) * (8)) + (get_global_id(0))])) + ((a[(((34) - 1) * (8)) + (get_global_id(0))]) - (b[(((34) - 1) * (8)) + (get_global_id(0))])) + ((a[(((35) - 1) * (8)) + (get_global_id(0))]) - (b[(((35) - 1) * (8)) + (get_global_id(0))])) + ((a[(((36) - 1) * (8)) + (get_global_id(0))]) - (b[(((36) - 1) * (8)) + (get_global_id(0))])) + ((a[(((37) - 1) * (8)) + (get_global_id(0))]) - (b[(((37) - 1) * (8)) + (get_global_id(0))])) -
       ((a[(((41) - 1) * (8)) + (get_global_id(0))]) - (b[(((41) - 1) * (8)) + (get_global_id(0))])) - ((a[(((42) - 1) * (8)) + (get_global_id(0))]) - (b[(((42) - 1) * (8)) + (get_global_id(0))])) + ((a[(((44) - 1) * (8)) + (get_global_id(0))]) - (b[(((44) - 1) * (8)) + (get_global_id(0))])) + ((a[(((46) - 1) * (8)) + (get_global_id(0))]) - (b[(((46) - 1) * (8)) + (get_global_id(0))])) - ((a[(((48) - 1) * (8)) + (get_global_id(0))]) - (b[(((48) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((49) - 1) * (8)) + (get_global_id(0))]) - (b[(((49) - 1) * (8)) + (get_global_id(0))])) + ((a[(((50) - 1) * (8)) + (get_global_id(0))]) - (b[(((50) - 1) * (8)) + (get_global_id(0))])) + ((a[(((52) - 1) * (8)) + (get_global_id(0))]) - (b[(((52) - 1) * (8)) + (get_global_id(0))])) + ((a[(((52) - 1) * (8)) + (get_global_id(0))]) - (b[(((52) - 1) * (8)) + (get_global_id(0))])) + ((a[(((53) - 1) * (8)) + (get_global_id(0))]) - (b[(((53) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((57) - 1) * (8)) + (get_global_id(0))]) - (b[(((57) - 1) * (8)) + (get_global_id(0))])) - ((a[(((60) - 1) * (8)) + (get_global_id(0))]) - (b[(((60) - 1) * (8)) + (get_global_id(0))])) + ((a[(((62) - 1) * (8)) + (get_global_id(0))]) - (b[(((62) - 1) * (8)) + (get_global_id(0))])) + ((a[(((63) - 1) * (8)) + (get_global_id(0))]) - (b[(((63) - 1) * (8)) + (get_global_id(0))])) + ((a[(((64) - 1) * (8)) + (get_global_id(0))]) - (b[(((64) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((65) - 1) * (8)) + (get_global_id(0))]) - (b[(((65) - 1) * (8)) + (get_global_id(0))])) - ((a[(((71) - 1) * (8)) + (get_global_id(0))]) - (b[(((71) - 1) * (8)) + (get_global_id(0))])) - ((a[(((72) - 1) * (8)) + (get_global_id(0))]) - (b[(((72) - 1) * (8)) + (get_global_id(0))])) + ((a[(((77) - 1) * (8)) + (get_global_id(0))]) - (b[(((77) - 1) * (8)) + (get_global_id(0))])) - ((a[(((78) - 1) * (8)) + (get_global_id(0))]) - (b[(((78) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((79) - 1) * (8)) + (get_global_id(0))]) - (b[(((79) - 1) * (8)) + (get_global_id(0))])) + ((a[(((87) - 1) * (8)) + (get_global_id(0))]) - (b[(((87) - 1) * (8)) + (get_global_id(0))])) + ((a[(((91) - 1) * (8)) + (get_global_id(0))]) - (b[(((91) - 1) * (8)) + (get_global_id(0))])) + ((a[(((92) - 1) * (8)) + (get_global_id(0))]) - (b[(((92) - 1) * (8)) + (get_global_id(0))])) + ((a[(((94) - 1) * (8)) + (get_global_id(0))]) - (b[(((94) - 1) * (8)) + (get_global_id(0))])) -
       ((a[(((96) - 1) * (8)) + (get_global_id(0))]) - (b[(((96) - 1) * (8)) + (get_global_id(0))])) - ((a[(((97) - 1) * (8)) + (get_global_id(0))]) - (b[(((97) - 1) * (8)) + (get_global_id(0))])) - ((a[(((98) - 1) * (8)) + (get_global_id(0))]) - (b[(((98) - 1) * (8)) + (get_global_id(0))])) - ((a[(((102) - 1) * (8)) + (get_global_id(0))]) - (b[(((102) - 1) * (8)) + (get_global_id(0))])) + ((a[(((105) - 1) * (8)) + (get_global_id(0))]) - (b[(((105) - 1) * (8)) + (get_global_id(0))])) -
       ((a[(((108) - 1) * (8)) + (get_global_id(0))]) - (b[(((108) - 1) * (8)) + (get_global_id(0))])) + ((a[(((109) - 1) * (8)) + (get_global_id(0))]) - (b[(((109) - 1) * (8)) + (get_global_id(0))])) + ((a[(((115) - 1) * (8)) + (get_global_id(0))]) - (b[(((115) - 1) * (8)) + (get_global_id(0))])) + ((a[(((116) - 1) * (8)) + (get_global_id(0))]) - (b[(((116) - 1) * (8)) + (get_global_id(0))])) + ((a[(((118) - 1) * (8)) + (get_global_id(0))]) - (b[(((118) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((124) - 1) * (8)) + (get_global_id(0))]) - (b[(((124) - 1) * (8)) + (get_global_id(0))])) - ((a[(((126) - 1) * (8)) + (get_global_id(0))]) - (b[(((126) - 1) * (8)) + (get_global_id(0))])) - ((a[(((127) - 1) * (8)) + (get_global_id(0))]) - (b[(((127) - 1) * (8)) + (get_global_id(0))])) - ((a[(((128) - 1) * (8)) + (get_global_id(0))]) - (b[(((128) - 1) * (8)) + (get_global_id(0))])) - ((a[(((132) - 1) * (8)) + (get_global_id(0))]) - (b[(((132) - 1) * (8)) + (get_global_id(0))])) -
       ((a[(((133) - 1) * (8)) + (get_global_id(0))]) - (b[(((133) - 1) * (8)) + (get_global_id(0))])) - ((a[(((134) - 1) * (8)) + (get_global_id(0))]) - (b[(((134) - 1) * (8)) + (get_global_id(0))])) + ((a[(((135) - 1) * (8)) + (get_global_id(0))]) - (b[(((135) - 1) * (8)) + (get_global_id(0))])) + ((a[(((146) - 1) * (8)) + (get_global_id(0))]) - (b[(((146) - 1) * (8)) + (get_global_id(0))])) - ((a[(((148) - 1) * (8)) + (get_global_id(0))]) - (b[(((148) - 1) * (8)) + (get_global_id(0))])) -
       ((a[(((149) - 1) * (8)) + (get_global_id(0))]) - (b[(((149) - 1) * (8)) + (get_global_id(0))])) - ((a[(((150) - 1) * (8)) + (get_global_id(0))]) - (b[(((150) - 1) * (8)) + (get_global_id(0))])) - ((a[(((156) - 1) * (8)) + (get_global_id(0))]) - (b[(((156) - 1) * (8)) + (get_global_id(0))])) - ((a[(((157) - 1) * (8)) + (get_global_id(0))]) - (b[(((157) - 1) * (8)) + (get_global_id(0))])) + ((a[(((165) - 1) * (8)) + (get_global_id(0))]) - (b[(((165) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((167) - 1) * (8)) + (get_global_id(0))]) - (b[(((167) - 1) * (8)) + (get_global_id(0))])) - ((a[(((170) - 1) * (8)) + (get_global_id(0))]) - (b[(((170) - 1) * (8)) + (get_global_id(0))])) - ((a[(((171) - 1) * (8)) + (get_global_id(0))]) - (b[(((171) - 1) * (8)) + (get_global_id(0))])) + ((a[(((173) - 1) * (8)) + (get_global_id(0))]) - (b[(((173) - 1) * (8)) + (get_global_id(0))])) - ((a[(((180) - 1) * (8)) + (get_global_id(0))]) - (b[(((180) - 1) * (8)) + (get_global_id(0))])) -
       ((a[(((185) - 1) * (8)) + (get_global_id(0))]) - (b[(((185) - 1) * (8)) + (get_global_id(0))])) - ((a[(((186) - 1) * (8)) + (get_global_id(0))]) - (b[(((186) - 1) * (8)) + (get_global_id(0))])) - ((a[(((190) - 1) * (8)) + (get_global_id(0))]) - (b[(((190) - 1) * (8)) + (get_global_id(0))])) - ((a[(((191) - 1) * (8)) + (get_global_id(0))]) - (b[(((191) - 1) * (8)) + (get_global_id(0))])) - ((a[(((192) - 1) * (8)) + (get_global_id(0))]) - (b[(((192) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((193) - 1) * (8)) + (get_global_id(0))]) - (b[(((193) - 1) * (8)) + (get_global_id(0))])) - ((a[(((199) - 1) * (8)) + (get_global_id(0))]) - (b[(((199) - 1) * (8)) + (get_global_id(0))])) - ((a[(((200) - 1) * (8)) + (get_global_id(0))]) - (b[(((200) - 1) * (8)) + (get_global_id(0))]))) *
      d * e[1];
}

