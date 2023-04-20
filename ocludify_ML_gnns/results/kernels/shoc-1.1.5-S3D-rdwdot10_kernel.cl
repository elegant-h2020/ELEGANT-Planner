#pragma OPENCL EXTENSION cl_khr_fp64 : enable

__kernel void A(__global const float* a, __global const float* b, __global float* c, const float d, __global const float* e) {
  float f = ((a[(((12) - 1) * (8)) + (get_global_id(0))]) - (b[(((12) - 1) * (8)) + (get_global_id(0))])) + ((a[(((13) - 1) * (8)) + (get_global_id(0))]) - (b[(((13) - 1) * (8)) + (get_global_id(0))])) + ((a[(((14) - 1) * (8)) + (get_global_id(0))]) - (b[(((14) - 1) * (8)) + (get_global_id(0))])) + ((a[(((15) - 1) * (8)) + (get_global_id(0))]) - (b[(((15) - 1) * (8)) + (get_global_id(0))]));
  float g = ((a[(((22) - 1) * (8)) + (get_global_id(0))]) - (b[(((22) - 1) * (8)) + (get_global_id(0))])) + ((a[(((23) - 1) * (8)) + (get_global_id(0))]) - (b[(((23) - 1) * (8)) + (get_global_id(0))]));
  float h = ((a[(((27) - 1) * (8)) + (get_global_id(0))]) - (b[(((27) - 1) * (8)) + (get_global_id(0))])) + ((a[(((28) - 1) * (8)) + (get_global_id(0))]) - (b[(((28) - 1) * (8)) + (get_global_id(0))]));
  float i = ((a[(((5) - 1) * (8)) + (get_global_id(0))]) - (b[(((5) - 1) * (8)) + (get_global_id(0))])) + ((a[(((6) - 1) * (8)) + (get_global_id(0))]) - (b[(((6) - 1) * (8)) + (get_global_id(0))])) + ((a[(((7) - 1) * (8)) + (get_global_id(0))]) - (b[(((7) - 1) * (8)) + (get_global_id(0))])) + ((a[(((8) - 1) * (8)) + (get_global_id(0))]) - (b[(((8) - 1) * (8)) + (get_global_id(0))]));

  (c[(((1) - 1) * (8)) + (get_global_id(0))]) =
      (-((a[(((2) - 1) * (8)) + (get_global_id(0))]) - (b[(((2) - 1) * (8)) + (get_global_id(0))])) - ((a[(((3) - 1) * (8)) + (get_global_id(0))]) - (b[(((3) - 1) * (8)) + (get_global_id(0))])) + i + ((a[(((18) - 1) * (8)) + (get_global_id(0))]) - (b[(((18) - 1) * (8)) + (get_global_id(0))])) + ((a[(((24) - 1) * (8)) + (get_global_id(0))]) - (b[(((24) - 1) * (8)) + (get_global_id(0))])) - ((a[(((31) - 1) * (8)) + (get_global_id(0))]) - (b[(((31) - 1) * (8)) + (get_global_id(0))])) -
       ((a[(((36) - 1) * (8)) + (get_global_id(0))]) - (b[(((36) - 1) * (8)) + (get_global_id(0))])) + ((a[(((42) - 1) * (8)) + (get_global_id(0))]) - (b[(((42) - 1) * (8)) + (get_global_id(0))])) - ((a[(((49) - 1) * (8)) + (get_global_id(0))]) - (b[(((49) - 1) * (8)) + (get_global_id(0))])) + ((a[(((58) - 1) * (8)) + (get_global_id(0))]) - (b[(((58) - 1) * (8)) + (get_global_id(0))])) + ((a[(((60) - 1) * (8)) + (get_global_id(0))]) - (b[(((60) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((61) - 1) * (8)) + (get_global_id(0))]) - (b[(((61) - 1) * (8)) + (get_global_id(0))])) - ((a[(((64) - 1) * (8)) + (get_global_id(0))]) - (b[(((64) - 1) * (8)) + (get_global_id(0))])) + ((a[(((72) - 1) * (8)) + (get_global_id(0))]) - (b[(((72) - 1) * (8)) + (get_global_id(0))])) + ((a[(((96) - 1) * (8)) + (get_global_id(0))]) - (b[(((96) - 1) * (8)) + (get_global_id(0))])) + ((a[(((102) - 1) * (8)) + (get_global_id(0))]) - (b[(((102) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((127) - 1) * (8)) + (get_global_id(0))]) - (b[(((127) - 1) * (8)) + (get_global_id(0))])) + ((a[(((133) - 1) * (8)) + (get_global_id(0))]) - (b[(((133) - 1) * (8)) + (get_global_id(0))])) + ((a[(((134) - 1) * (8)) + (get_global_id(0))]) - (b[(((134) - 1) * (8)) + (get_global_id(0))])) + ((a[(((150) - 1) * (8)) + (get_global_id(0))]) - (b[(((150) - 1) * (8)) + (get_global_id(0))])) + ((a[(((155) - 1) * (8)) + (get_global_id(0))]) - (b[(((155) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((157) - 1) * (8)) + (get_global_id(0))]) - (b[(((157) - 1) * (8)) + (get_global_id(0))])) + ((a[(((171) - 1) * (8)) + (get_global_id(0))]) - (b[(((171) - 1) * (8)) + (get_global_id(0))])) + ((a[(((180) - 1) * (8)) + (get_global_id(0))]) - (b[(((180) - 1) * (8)) + (get_global_id(0))])) + ((a[(((192) - 1) * (8)) + (get_global_id(0))]) - (b[(((192) - 1) * (8)) + (get_global_id(0))])) + ((a[(((200) - 1) * (8)) + (get_global_id(0))]) - (b[(((200) - 1) * (8)) + (get_global_id(0))]))) *
      d * e[0];

  (c[(((3) - 1) * (8)) + (get_global_id(0))]) =
      (+((a[(((1) - 1) * (8)) + (get_global_id(0))]) - (b[(((1) - 1) * (8)) + (get_global_id(0))])) - ((a[(((2) - 1) * (8)) + (get_global_id(0))]) - (b[(((2) - 1) * (8)) + (get_global_id(0))])) + ((a[(((4) - 1) * (8)) + (get_global_id(0))]) - (b[(((4) - 1) * (8)) + (get_global_id(0))])) - ((a[(((10) - 1) * (8)) + (get_global_id(0))]) - (b[(((10) - 1) * (8)) + (get_global_id(0))])) - ((a[(((11) - 1) * (8)) + (get_global_id(0))]) - (b[(((11) - 1) * (8)) + (get_global_id(0))])) -
       ((a[(((11) - 1) * (8)) + (get_global_id(0))]) - (b[(((11) - 1) * (8)) + (get_global_id(0))])) + ((a[(((17) - 1) * (8)) + (get_global_id(0))]) - (b[(((17) - 1) * (8)) + (get_global_id(0))])) - ((a[(((20) - 1) * (8)) + (get_global_id(0))]) - (b[(((20) - 1) * (8)) + (get_global_id(0))])) - ((a[(((26) - 1) * (8)) + (get_global_id(0))]) - (b[(((26) - 1) * (8)) + (get_global_id(0))])) - ((a[(((29) - 1) * (8)) + (get_global_id(0))]) - (b[(((29) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((32) - 1) * (8)) + (get_global_id(0))]) - (b[(((32) - 1) * (8)) + (get_global_id(0))])) - ((a[(((34) - 1) * (8)) + (get_global_id(0))]) - (b[(((34) - 1) * (8)) + (get_global_id(0))])) + ((a[(((38) - 1) * (8)) + (get_global_id(0))]) - (b[(((38) - 1) * (8)) + (get_global_id(0))])) - ((a[(((43) - 1) * (8)) + (get_global_id(0))]) - (b[(((43) - 1) * (8)) + (get_global_id(0))])) - ((a[(((44) - 1) * (8)) + (get_global_id(0))]) - (b[(((44) - 1) * (8)) + (get_global_id(0))])) -
       ((a[(((50) - 1) * (8)) + (get_global_id(0))]) - (b[(((50) - 1) * (8)) + (get_global_id(0))])) - ((a[(((61) - 1) * (8)) + (get_global_id(0))]) - (b[(((61) - 1) * (8)) + (get_global_id(0))])) - ((a[(((62) - 1) * (8)) + (get_global_id(0))]) - (b[(((62) - 1) * (8)) + (get_global_id(0))])) - ((a[(((73) - 1) * (8)) + (get_global_id(0))]) - (b[(((73) - 1) * (8)) + (get_global_id(0))])) - ((a[(((79) - 1) * (8)) + (get_global_id(0))]) - (b[(((79) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((82) - 1) * (8)) + (get_global_id(0))]) - (b[(((82) - 1) * (8)) + (get_global_id(0))])) - ((a[(((99) - 1) * (8)) + (get_global_id(0))]) - (b[(((99) - 1) * (8)) + (get_global_id(0))])) - ((a[(((103) - 1) * (8)) + (get_global_id(0))]) - (b[(((103) - 1) * (8)) + (get_global_id(0))])) - ((a[(((109) - 1) * (8)) + (get_global_id(0))]) - (b[(((109) - 1) * (8)) + (get_global_id(0))])) - ((a[(((116) - 1) * (8)) + (get_global_id(0))]) - (b[(((116) - 1) * (8)) + (get_global_id(0))])) -
       ((a[(((117) - 1) * (8)) + (get_global_id(0))]) - (b[(((117) - 1) * (8)) + (get_global_id(0))])) - ((a[(((123) - 1) * (8)) + (get_global_id(0))]) - (b[(((123) - 1) * (8)) + (get_global_id(0))])) - ((a[(((129) - 1) * (8)) + (get_global_id(0))]) - (b[(((129) - 1) * (8)) + (get_global_id(0))])) - ((a[(((130) - 1) * (8)) + (get_global_id(0))]) - (b[(((130) - 1) * (8)) + (get_global_id(0))])) - ((a[(((135) - 1) * (8)) + (get_global_id(0))]) - (b[(((135) - 1) * (8)) + (get_global_id(0))])) -
       ((a[(((136) - 1) * (8)) + (get_global_id(0))]) - (b[(((136) - 1) * (8)) + (get_global_id(0))])) + ((a[(((139) - 1) * (8)) + (get_global_id(0))]) - (b[(((139) - 1) * (8)) + (get_global_id(0))])) - ((a[(((151) - 1) * (8)) + (get_global_id(0))]) - (b[(((151) - 1) * (8)) + (get_global_id(0))])) - ((a[(((158) - 1) * (8)) + (get_global_id(0))]) - (b[(((158) - 1) * (8)) + (get_global_id(0))])) - ((a[(((159) - 1) * (8)) + (get_global_id(0))]) - (b[(((159) - 1) * (8)) + (get_global_id(0))])) -
       ((a[(((160) - 1) * (8)) + (get_global_id(0))]) - (b[(((160) - 1) * (8)) + (get_global_id(0))])) - ((a[(((172) - 1) * (8)) + (get_global_id(0))]) - (b[(((172) - 1) * (8)) + (get_global_id(0))])) - ((a[(((173) - 1) * (8)) + (get_global_id(0))]) - (b[(((173) - 1) * (8)) + (get_global_id(0))])) - ((a[(((181) - 1) * (8)) + (get_global_id(0))]) - (b[(((181) - 1) * (8)) + (get_global_id(0))])) - ((a[(((193) - 1) * (8)) + (get_global_id(0))]) - (b[(((193) - 1) * (8)) + (get_global_id(0))])) -
       ((a[(((194) - 1) * (8)) + (get_global_id(0))]) - (b[(((194) - 1) * (8)) + (get_global_id(0))])) - ((a[(((195) - 1) * (8)) + (get_global_id(0))]) - (b[(((195) - 1) * (8)) + (get_global_id(0))])) - ((a[(((201) - 1) * (8)) + (get_global_id(0))]) - (b[(((201) - 1) * (8)) + (get_global_id(0))]))) *
      d * e[2];

  (c[(((4) - 1) * (8)) + (get_global_id(0))]) =
      (-((a[(((1) - 1) * (8)) + (get_global_id(0))]) - (b[(((1) - 1) * (8)) + (get_global_id(0))])) + ((a[(((11) - 1) * (8)) + (get_global_id(0))]) - (b[(((11) - 1) * (8)) + (get_global_id(0))])) - f + ((a[(((18) - 1) * (8)) + (get_global_id(0))]) - (b[(((18) - 1) * (8)) + (get_global_id(0))])) + ((a[(((20) - 1) * (8)) + (get_global_id(0))]) - (b[(((20) - 1) * (8)) + (get_global_id(0))])) + ((a[(((21) - 1) * (8)) + (get_global_id(0))]) - (b[(((21) - 1) * (8)) + (get_global_id(0))])) + g -
       ((a[(((32) - 1) * (8)) + (get_global_id(0))]) - (b[(((32) - 1) * (8)) + (get_global_id(0))])) - ((a[(((38) - 1) * (8)) + (get_global_id(0))]) - (b[(((38) - 1) * (8)) + (get_global_id(0))])) - ((a[(((47) - 1) * (8)) + (get_global_id(0))]) - (b[(((47) - 1) * (8)) + (get_global_id(0))])) - ((a[(((51) - 1) * (8)) + (get_global_id(0))]) - (b[(((51) - 1) * (8)) + (get_global_id(0))])) - ((a[(((52) - 1) * (8)) + (get_global_id(0))]) - (b[(((52) - 1) * (8)) + (get_global_id(0))])) -
       ((a[(((65) - 1) * (8)) + (get_global_id(0))]) - (b[(((65) - 1) * (8)) + (get_global_id(0))])) - ((a[(((66) - 1) * (8)) + (get_global_id(0))]) - (b[(((66) - 1) * (8)) + (get_global_id(0))])) - ((a[(((75) - 1) * (8)) + (get_global_id(0))]) - (b[(((75) - 1) * (8)) + (get_global_id(0))])) - ((a[(((82) - 1) * (8)) + (get_global_id(0))]) - (b[(((82) - 1) * (8)) + (get_global_id(0))])) - ((a[(((83) - 1) * (8)) + (get_global_id(0))]) - (b[(((83) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((84) - 1) * (8)) + (get_global_id(0))]) - (b[(((84) - 1) * (8)) + (get_global_id(0))])) - ((a[(((101) - 1) * (8)) + (get_global_id(0))]) - (b[(((101) - 1) * (8)) + (get_global_id(0))])) - ((a[(((110) - 1) * (8)) + (get_global_id(0))]) - (b[(((110) - 1) * (8)) + (get_global_id(0))])) - ((a[(((125) - 1) * (8)) + (get_global_id(0))]) - (b[(((125) - 1) * (8)) + (get_global_id(0))])) - ((a[(((138) - 1) * (8)) + (get_global_id(0))]) - (b[(((138) - 1) * (8)) + (get_global_id(0))])) -
       ((a[(((139) - 1) * (8)) + (get_global_id(0))]) - (b[(((139) - 1) * (8)) + (get_global_id(0))])) - ((a[(((140) - 1) * (8)) + (get_global_id(0))]) - (b[(((140) - 1) * (8)) + (get_global_id(0))])) - ((a[(((153) - 1) * (8)) + (get_global_id(0))]) - (b[(((153) - 1) * (8)) + (get_global_id(0))])) - ((a[(((154) - 1) * (8)) + (get_global_id(0))]) - (b[(((154) - 1) * (8)) + (get_global_id(0))])) - ((a[(((162) - 1) * (8)) + (get_global_id(0))]) - (b[(((162) - 1) * (8)) + (get_global_id(0))])) -
       ((a[(((174) - 1) * (8)) + (get_global_id(0))]) - (b[(((174) - 1) * (8)) + (get_global_id(0))])) + ((a[(((175) - 1) * (8)) + (get_global_id(0))]) - (b[(((175) - 1) * (8)) + (get_global_id(0))])) + ((a[(((187) - 1) * (8)) + (get_global_id(0))]) - (b[(((187) - 1) * (8)) + (get_global_id(0))])) - ((a[(((203) - 1) * (8)) + (get_global_id(0))]) - (b[(((203) - 1) * (8)) + (get_global_id(0))]))) *
      d * e[3];
  (c[(((6) - 1) * (8)) + (get_global_id(0))]) =
      (+((a[(((3) - 1) * (8)) + (get_global_id(0))]) - (b[(((3) - 1) * (8)) + (get_global_id(0))])) + ((a[(((4) - 1) * (8)) + (get_global_id(0))]) - (b[(((4) - 1) * (8)) + (get_global_id(0))])) + ((a[(((9) - 1) * (8)) + (get_global_id(0))]) - (b[(((9) - 1) * (8)) + (get_global_id(0))])) + ((a[(((17) - 1) * (8)) + (get_global_id(0))]) - (b[(((17) - 1) * (8)) + (get_global_id(0))])) + ((a[(((21) - 1) * (8)) + (get_global_id(0))]) - (b[(((21) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((25) - 1) * (8)) + (get_global_id(0))]) - (b[(((25) - 1) * (8)) + (get_global_id(0))])) + h - ((a[(((37) - 1) * (8)) + (get_global_id(0))]) - (b[(((37) - 1) * (8)) + (get_global_id(0))])) + ((a[(((45) - 1) * (8)) + (get_global_id(0))]) - (b[(((45) - 1) * (8)) + (get_global_id(0))])) + ((a[(((54) - 1) * (8)) + (get_global_id(0))]) - (b[(((54) - 1) * (8)) + (get_global_id(0))])) + ((a[(((66) - 1) * (8)) + (get_global_id(0))]) - (b[(((66) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((74) - 1) * (8)) + (get_global_id(0))]) - (b[(((74) - 1) * (8)) + (get_global_id(0))])) + ((a[(((80) - 1) * (8)) + (get_global_id(0))]) - (b[(((80) - 1) * (8)) + (get_global_id(0))])) + ((a[(((81) - 1) * (8)) + (get_global_id(0))]) - (b[(((81) - 1) * (8)) + (get_global_id(0))])) + ((a[(((98) - 1) * (8)) + (get_global_id(0))]) - (b[(((98) - 1) * (8)) + (get_global_id(0))])) + ((a[(((100) - 1) * (8)) + (get_global_id(0))]) - (b[(((100) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((104) - 1) * (8)) + (get_global_id(0))]) - (b[(((104) - 1) * (8)) + (get_global_id(0))])) + ((a[(((131) - 1) * (8)) + (get_global_id(0))]) - (b[(((131) - 1) * (8)) + (get_global_id(0))])) + ((a[(((137) - 1) * (8)) + (get_global_id(0))]) - (b[(((137) - 1) * (8)) + (get_global_id(0))])) + ((a[(((152) - 1) * (8)) + (get_global_id(0))]) - (b[(((152) - 1) * (8)) + (get_global_id(0))])) + ((a[(((161) - 1) * (8)) + (get_global_id(0))]) - (b[(((161) - 1) * (8)) + (get_global_id(0))])) +
       ((a[(((182) - 1) * (8)) + (get_global_id(0))]) - (b[(((182) - 1) * (8)) + (get_global_id(0))])) + ((a[(((196) - 1) * (8)) + (get_global_id(0))]) - (b[(((196) - 1) * (8)) + (get_global_id(0))])) + ((a[(((202) - 1) * (8)) + (get_global_id(0))]) - (b[(((202) - 1) * (8)) + (get_global_id(0))]))) *
      d * e[5];
}

