; ModuleID = './kernels/kernels/shoc-1.1.5-S3D-ratt6_kernel.cl'
source_filename = "./kernels/kernels/shoc-1.1.5-S3D-ratt6_kernel.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(float* nocapture readonly %a, float* readonly %b, float* %c, float* readonly %d, float %e) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #2
  %arrayidx = getelementptr inbounds float, float* %a, i64 %call
  %0 = load float, float* %arrayidx, align 4, !tbaa !8
  %mul = fmul float %0, %e
  %mul2 = fmul float %mul, 0x4193D2C640000000
  %div = fdiv float 1.000000e+00, %mul2, !fpmath !12
  %mul3 = fmul float %div, 1.013250e+06
  %add = add i64 %call, 24
  %arrayidx5 = getelementptr inbounds float, float* %d, i64 %add
  %1 = load float, float* %arrayidx5, align 4, !tbaa !8
  %add7 = add i64 %call, 136
  %arrayidx8 = getelementptr inbounds float, float* %d, i64 %add7
  %2 = load float, float* %arrayidx8, align 4, !tbaa !8
  %mul9 = fmul float %1, %2
  %add11 = add i64 %call, 48
  %arrayidx12 = getelementptr inbounds float, float* %d, i64 %add11
  %3 = load float, float* %arrayidx12, align 4, !tbaa !8
  %add14 = add i64 %call, 128
  %arrayidx15 = getelementptr inbounds float, float* %d, i64 %add14
  %4 = load float, float* %arrayidx15, align 4, !tbaa !8
  %mul16 = fmul float %3, %4
  %div17 = fdiv float 1.000000e+00, %mul16, !fpmath !12
  %mul18 = fmul float %mul9, %div17
  %add20 = add i64 %call, 800
  %arrayidx21 = getelementptr inbounds float, float* %b, i64 %add20
  %5 = load float, float* %arrayidx21, align 4, !tbaa !8
  %call22 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul18, float 0x4415AF1D80000000) #2
  %mul23 = fmul float %5, %call22
  %arrayidx26 = getelementptr inbounds float, float* %c, i64 %add20
  store float %mul23, float* %arrayidx26, align 4, !tbaa !8
  %add28 = add i64 %call, 8
  %arrayidx29 = getelementptr inbounds float, float* %d, i64 %add28
  %6 = load float, float* %arrayidx29, align 4, !tbaa !8
  %add31 = add i64 %call, 96
  %arrayidx32 = getelementptr inbounds float, float* %d, i64 %add31
  %7 = load float, float* %arrayidx32, align 4, !tbaa !8
  %mul33 = fmul float %6, %7
  %arrayidx36 = getelementptr inbounds float, float* %d, i64 %call
  %8 = load float, float* %arrayidx36, align 4, !tbaa !8
  %add38 = add i64 %call, 88
  %arrayidx39 = getelementptr inbounds float, float* %d, i64 %add38
  %9 = load float, float* %arrayidx39, align 4, !tbaa !8
  %mul40 = fmul float %8, %9
  %div41 = fdiv float 1.000000e+00, %mul40, !fpmath !12
  %mul42 = fmul float %mul33, %div41
  %add44 = add i64 %call, 808
  %arrayidx45 = getelementptr inbounds float, float* %b, i64 %add44
  %10 = load float, float* %arrayidx45, align 4, !tbaa !8
  %call46 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul42, float 0x4415AF1D80000000) #2
  %mul47 = fmul float %10, %call46
  %arrayidx50 = getelementptr inbounds float, float* %c, i64 %add44
  store float %mul47, float* %arrayidx50, align 4, !tbaa !8
  %add52 = add i64 %call, 16
  %arrayidx53 = getelementptr inbounds float, float* %d, i64 %add52
  %11 = load float, float* %arrayidx53, align 4, !tbaa !8
  %12 = load float, float* %arrayidx32, align 4, !tbaa !8
  %mul57 = fmul float %11, %12
  %add59 = add i64 %call, 32
  %arrayidx60 = getelementptr inbounds float, float* %d, i64 %add59
  %13 = load float, float* %arrayidx60, align 4, !tbaa !8
  %14 = load float, float* %arrayidx39, align 4, !tbaa !8
  %mul64 = fmul float %13, %14
  %div65 = fdiv float 1.000000e+00, %mul64, !fpmath !12
  %mul66 = fmul float %mul57, %div65
  %add68 = add i64 %call, 816
  %arrayidx69 = getelementptr inbounds float, float* %b, i64 %add68
  %15 = load float, float* %arrayidx69, align 4, !tbaa !8
  %call70 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul66, float 0x4415AF1D80000000) #2
  %mul71 = fmul float %15, %call70
  %arrayidx74 = getelementptr inbounds float, float* %c, i64 %add68
  store float %mul71, float* %arrayidx74, align 4, !tbaa !8
  %16 = load float, float* %arrayidx60, align 4, !tbaa !8
  %17 = load float, float* %arrayidx32, align 4, !tbaa !8
  %mul81 = fmul float %16, %17
  %add83 = add i64 %call, 40
  %arrayidx84 = getelementptr inbounds float, float* %d, i64 %add83
  %18 = load float, float* %arrayidx84, align 4, !tbaa !8
  %19 = load float, float* %arrayidx39, align 4, !tbaa !8
  %mul88 = fmul float %18, %19
  %div89 = fdiv float 1.000000e+00, %mul88, !fpmath !12
  %mul90 = fmul float %mul81, %div89
  %add92 = add i64 %call, 824
  %arrayidx93 = getelementptr inbounds float, float* %b, i64 %add92
  %20 = load float, float* %arrayidx93, align 4, !tbaa !8
  %call94 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul90, float 0x4415AF1D80000000) #2
  %mul95 = fmul float %20, %call94
  %arrayidx98 = getelementptr inbounds float, float* %c, i64 %add92
  store float %mul95, float* %arrayidx98, align 4, !tbaa !8
  %add100 = add i64 %call, 64
  %arrayidx101 = getelementptr inbounds float, float* %d, i64 %add100
  %21 = load float, float* %arrayidx101, align 4, !tbaa !8
  %22 = load float, float* %arrayidx32, align 4, !tbaa !8
  %mul105 = fmul float %21, %22
  %23 = load float, float* %arrayidx29, align 4, !tbaa !8
  %add110 = add i64 %call, 168
  %arrayidx111 = getelementptr inbounds float, float* %d, i64 %add110
  %24 = load float, float* %arrayidx111, align 4, !tbaa !8
  %mul112 = fmul float %23, %24
  %div113 = fdiv float 1.000000e+00, %mul112, !fpmath !12
  %mul114 = fmul float %mul105, %div113
  %add116 = add i64 %call, 832
  %arrayidx117 = getelementptr inbounds float, float* %b, i64 %add116
  %25 = load float, float* %arrayidx117, align 4, !tbaa !8
  %call118 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul114, float 0x4415AF1D80000000) #2
  %mul119 = fmul float %25, %call118
  %arrayidx122 = getelementptr inbounds float, float* %c, i64 %add116
  store float %mul119, float* %arrayidx122, align 4, !tbaa !8
  %add124 = add i64 %call, 72
  %arrayidx125 = getelementptr inbounds float, float* %d, i64 %add124
  %26 = load float, float* %arrayidx125, align 4, !tbaa !8
  %27 = load float, float* %arrayidx32, align 4, !tbaa !8
  %mul129 = fmul float %26, %27
  %28 = load float, float* %arrayidx39, align 4, !tbaa !8
  %mul136 = fmul float %28, %28
  %div137 = fdiv float 1.000000e+00, %mul136, !fpmath !12
  %mul138 = fmul float %mul129, %div137
  %add140 = add i64 %call, 840
  %arrayidx141 = getelementptr inbounds float, float* %b, i64 %add140
  %29 = load float, float* %arrayidx141, align 4, !tbaa !8
  %call142 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul138, float 0x4415AF1D80000000) #2
  %mul143 = fmul float %29, %call142
  %arrayidx146 = getelementptr inbounds float, float* %c, i64 %add140
  store float %mul143, float* %arrayidx146, align 4, !tbaa !8
  %add148 = add i64 %call, 80
  %arrayidx149 = getelementptr inbounds float, float* %d, i64 %add148
  %30 = load float, float* %arrayidx149, align 4, !tbaa !8
  %31 = load float, float* %arrayidx32, align 4, !tbaa !8
  %mul153 = fmul float %30, %31
  %32 = load float, float* %arrayidx39, align 4, !tbaa !8
  %mul160 = fmul float %32, %32
  %div161 = fdiv float 1.000000e+00, %mul160, !fpmath !12
  %mul162 = fmul float %mul153, %div161
  %add164 = add i64 %call, 848
  %arrayidx165 = getelementptr inbounds float, float* %b, i64 %add164
  %33 = load float, float* %arrayidx165, align 4, !tbaa !8
  %call166 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul162, float 0x4415AF1D80000000) #2
  %mul167 = fmul float %33, %call166
  %arrayidx170 = getelementptr inbounds float, float* %c, i64 %add164
  store float %mul167, float* %arrayidx170, align 4, !tbaa !8
  %34 = load float, float* %arrayidx29, align 4, !tbaa !8
  %add175 = add i64 %call, 192
  %arrayidx176 = getelementptr inbounds float, float* %d, i64 %add175
  %35 = load float, float* %arrayidx176, align 4, !tbaa !8
  %mul177 = fmul float %34, %35
  %36 = load float, float* %arrayidx149, align 4, !tbaa !8
  %add182 = add i64 %call, 104
  %arrayidx183 = getelementptr inbounds float, float* %d, i64 %add182
  %37 = load float, float* %arrayidx183, align 4, !tbaa !8
  %mul184 = fmul float %36, %37
  %div185 = fdiv float 1.000000e+00, %mul184, !fpmath !12
  %mul186 = fmul float %mul177, %div185
  %add188 = add i64 %call, 856
  %arrayidx189 = getelementptr inbounds float, float* %b, i64 %add188
  %38 = load float, float* %arrayidx189, align 4, !tbaa !8
  %call190 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul186, float 0x4415AF1D80000000) #2
  %mul191 = fmul float %38, %call190
  %arrayidx194 = getelementptr inbounds float, float* %c, i64 %add188
  store float %mul191, float* %arrayidx194, align 4, !tbaa !8
  %39 = load float, float* %arrayidx53, align 4, !tbaa !8
  %40 = load float, float* %arrayidx176, align 4, !tbaa !8
  %mul201 = fmul float %39, %40
  %41 = load float, float* %arrayidx29, align 4, !tbaa !8
  %42 = load float, float* %arrayidx183, align 4, !tbaa !8
  %mul208 = fmul float %41, %42
  %mul212 = fmul float %42, %mul208
  %mul213 = fmul float %mul3, %mul212
  %div214 = fdiv float 1.000000e+00, %mul213, !fpmath !12
  %mul215 = fmul float %mul201, %div214
  %add217 = add i64 %call, 864
  %arrayidx218 = getelementptr inbounds float, float* %b, i64 %add217
  %43 = load float, float* %arrayidx218, align 4, !tbaa !8
  %call219 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul215, float 0x4415AF1D80000000) #2
  %mul220 = fmul float %43, %call219
  %arrayidx223 = getelementptr inbounds float, float* %c, i64 %add217
  store float %mul220, float* %arrayidx223, align 4, !tbaa !8
  %44 = load float, float* %arrayidx5, align 4, !tbaa !8
  %45 = load float, float* %arrayidx176, align 4, !tbaa !8
  %mul230 = fmul float %44, %45
  %46 = load float, float* %arrayidx60, align 4, !tbaa !8
  %47 = load float, float* %arrayidx183, align 4, !tbaa !8
  %mul237 = fmul float %46, %47
  %mul241 = fmul float %47, %mul237
  %mul242 = fmul float %mul3, %mul241
  %div243 = fdiv float 1.000000e+00, %mul242, !fpmath !12
  %mul244 = fmul float %mul230, %div243
  %add246 = add i64 %call, 872
  %arrayidx247 = getelementptr inbounds float, float* %b, i64 %add246
  %48 = load float, float* %arrayidx247, align 4, !tbaa !8
  %call248 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul244, float 0x4415AF1D80000000) #2
  %mul249 = fmul float %48, %call248
  %arrayidx252 = getelementptr inbounds float, float* %c, i64 %add246
  store float %mul249, float* %arrayidx252, align 4, !tbaa !8
  %49 = load float, float* %arrayidx101, align 4, !tbaa !8
  %50 = load float, float* %arrayidx176, align 4, !tbaa !8
  %mul259 = fmul float %49, %50
  %51 = load float, float* %arrayidx183, align 4, !tbaa !8
  %add264 = add i64 %call, 144
  %arrayidx265 = getelementptr inbounds float, float* %d, i64 %add264
  %52 = load float, float* %arrayidx265, align 4, !tbaa !8
  %mul266 = fmul float %51, %52
  %div267 = fdiv float 1.000000e+00, %mul266, !fpmath !12
  %mul268 = fmul float %mul259, %div267
  %add270 = add i64 %call, 880
  %arrayidx271 = getelementptr inbounds float, float* %b, i64 %add270
  %53 = load float, float* %arrayidx271, align 4, !tbaa !8
  %call272 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul268, float 0x4415AF1D80000000) #2
  %mul273 = fmul float %53, %call272
  %arrayidx276 = getelementptr inbounds float, float* %c, i64 %add270
  store float %mul273, float* %arrayidx276, align 4, !tbaa !8
  %54 = load float, float* %arrayidx125, align 4, !tbaa !8
  %55 = load float, float* %arrayidx176, align 4, !tbaa !8
  %mul283 = fmul float %54, %55
  %56 = load float, float* %arrayidx183, align 4, !tbaa !8
  %add288 = add i64 %call, 160
  %arrayidx289 = getelementptr inbounds float, float* %d, i64 %add288
  %57 = load float, float* %arrayidx289, align 4, !tbaa !8
  %mul290 = fmul float %56, %57
  %div291 = fdiv float 1.000000e+00, %mul290, !fpmath !12
  %mul292 = fmul float %mul283, %div291
  %add294 = add i64 %call, 888
  %arrayidx295 = getelementptr inbounds float, float* %b, i64 %add294
  %58 = load float, float* %arrayidx295, align 4, !tbaa !8
  %call296 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul292, float 0x4415AF1D80000000) #2
  %mul297 = fmul float %58, %call296
  %arrayidx300 = getelementptr inbounds float, float* %c, i64 %add294
  store float %mul297, float* %arrayidx300, align 4, !tbaa !8
  %59 = load float, float* %arrayidx176, align 4, !tbaa !8
  %mul307 = fmul float %59, %59
  %60 = load float, float* %arrayidx183, align 4, !tbaa !8
  %mul314 = fmul float %60, %60
  %61 = load float, float* %arrayidx265, align 4, !tbaa !8
  %mul318 = fmul float %mul314, %61
  %mul319 = fmul float %mul3, %mul318
  %div320 = fdiv float 1.000000e+00, %mul319, !fpmath !12
  %mul321 = fmul float %mul307, %div320
  %add323 = add i64 %call, 896
  %arrayidx324 = getelementptr inbounds float, float* %b, i64 %add323
  %62 = load float, float* %arrayidx324, align 4, !tbaa !8
  %call325 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul321, float 0x4415AF1D80000000) #2
  %mul326 = fmul float %62, %call325
  %arrayidx329 = getelementptr inbounds float, float* %c, i64 %add323
  store float %mul326, float* %arrayidx329, align 4, !tbaa !8
  %63 = load float, float* %arrayidx265, align 4, !tbaa !8
  %add334 = add i64 %call, 152
  %arrayidx335 = getelementptr inbounds float, float* %d, i64 %add334
  %64 = load float, float* %arrayidx335, align 4, !tbaa !8
  %div336 = fdiv float 1.000000e+00, %64, !fpmath !12
  %mul337 = fmul float %63, %div336
  %add339 = add i64 %call, 904
  %arrayidx340 = getelementptr inbounds float, float* %b, i64 %add339
  %65 = load float, float* %arrayidx340, align 4, !tbaa !8
  %call341 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul337, float 0x4415AF1D80000000) #2
  %mul342 = fmul float %65, %call341
  %arrayidx345 = getelementptr inbounds float, float* %c, i64 %add339
  store float %mul342, float* %arrayidx345, align 4, !tbaa !8
  %66 = load float, float* %arrayidx289, align 4, !tbaa !8
  %67 = load float, float* %arrayidx29, align 4, !tbaa !8
  %68 = load float, float* %arrayidx265, align 4, !tbaa !8
  %mul355 = fmul float %67, %68
  %mul356 = fmul float %mul3, %mul355
  %div357 = fdiv float 1.000000e+00, %mul356, !fpmath !12
  %mul358 = fmul float %66, %div357
  %add360 = add i64 %call, 912
  %arrayidx361 = getelementptr inbounds float, float* %b, i64 %add360
  %69 = load float, float* %arrayidx361, align 4, !tbaa !8
  %call362 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul358, float 0x4415AF1D80000000) #2
  %mul363 = fmul float %69, %call362
  %arrayidx366 = getelementptr inbounds float, float* %c, i64 %add360
  store float %mul363, float* %arrayidx366, align 4, !tbaa !8
  %70 = load float, float* %arrayidx53, align 4, !tbaa !8
  %71 = load float, float* %arrayidx265, align 4, !tbaa !8
  %mul373 = fmul float %70, %71
  %72 = load float, float* %arrayidx29, align 4, !tbaa !8
  %73 = load float, float* %arrayidx176, align 4, !tbaa !8
  %mul380 = fmul float %72, %73
  %div381 = fdiv float 1.000000e+00, %mul380, !fpmath !12
  %mul382 = fmul float %mul373, %div381
  %add384 = add i64 %call, 920
  %arrayidx385 = getelementptr inbounds float, float* %b, i64 %add384
  %74 = load float, float* %arrayidx385, align 4, !tbaa !8
  %call386 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul382, float 0x4415AF1D80000000) #2
  %mul387 = fmul float %74, %call386
  %arrayidx390 = getelementptr inbounds float, float* %c, i64 %add384
  store float %mul387, float* %arrayidx390, align 4, !tbaa !8
  %75 = load float, float* %arrayidx53, align 4, !tbaa !8
  %76 = load float, float* %arrayidx265, align 4, !tbaa !8
  %mul397 = fmul float %75, %76
  %77 = load float, float* %arrayidx125, align 4, !tbaa !8
  %78 = load float, float* %arrayidx183, align 4, !tbaa !8
  %mul404 = fmul float %77, %78
  %div405 = fdiv float 1.000000e+00, %mul404, !fpmath !12
  %mul406 = fmul float %mul397, %div405
  %add408 = add i64 %call, 928
  %arrayidx409 = getelementptr inbounds float, float* %b, i64 %add408
  %79 = load float, float* %arrayidx409, align 4, !tbaa !8
  %call410 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul406, float 0x4415AF1D80000000) #2
  %mul411 = fmul float %79, %call410
  %arrayidx414 = getelementptr inbounds float, float* %c, i64 %add408
  store float %mul411, float* %arrayidx414, align 4, !tbaa !8
  %80 = load float, float* %arrayidx60, align 4, !tbaa !8
  %81 = load float, float* %arrayidx265, align 4, !tbaa !8
  %mul421 = fmul float %80, %81
  %82 = load float, float* %arrayidx29, align 4, !tbaa !8
  %add426 = add i64 %call, 200
  %arrayidx427 = getelementptr inbounds float, float* %d, i64 %add426
  %83 = load float, float* %arrayidx427, align 4, !tbaa !8
  %mul428 = fmul float %82, %83
  %div429 = fdiv float 1.000000e+00, %mul428, !fpmath !12
  %mul430 = fmul float %mul421, %div429
  %add432 = add i64 %call, 936
  %arrayidx433 = getelementptr inbounds float, float* %b, i64 %add432
  %84 = load float, float* %arrayidx433, align 4, !tbaa !8
  %call434 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul430, float 0x4415AF1D80000000) #2
  %mul435 = fmul float %84, %call434
  %arrayidx438 = getelementptr inbounds float, float* %c, i64 %add432
  store float %mul435, float* %arrayidx438, align 4, !tbaa !8
  %85 = load float, float* %arrayidx60, align 4, !tbaa !8
  %86 = load float, float* %arrayidx265, align 4, !tbaa !8
  %mul445 = fmul float %85, %86
  %87 = load float, float* %arrayidx39, align 4, !tbaa !8
  %88 = load float, float* %arrayidx183, align 4, !tbaa !8
  %mul452 = fmul float %87, %88
  %div453 = fdiv float 1.000000e+00, %mul452, !fpmath !12
  %mul454 = fmul float %mul445, %div453
  %add456 = add i64 %call, 944
  %arrayidx457 = getelementptr inbounds float, float* %b, i64 %add456
  %89 = load float, float* %arrayidx457, align 4, !tbaa !8
  %call458 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul454, float 0x4415AF1D80000000) #2
  %mul459 = fmul float %89, %call458
  %arrayidx462 = getelementptr inbounds float, float* %c, i64 %add456
  store float %mul459, float* %arrayidx462, align 4, !tbaa !8
  %add464 = add i64 %call, 120
  %arrayidx465 = getelementptr inbounds float, float* %d, i64 %add464
  %90 = load float, float* %arrayidx465, align 4, !tbaa !8
  %91 = load float, float* %arrayidx265, align 4, !tbaa !8
  %mul469 = fmul float %90, %91
  %92 = load float, float* %arrayidx183, align 4, !tbaa !8
  %93 = load float, float* %arrayidx289, align 4, !tbaa !8
  %mul476 = fmul float %92, %93
  %div477 = fdiv float 1.000000e+00, %mul476, !fpmath !12
  %mul478 = fmul float %mul469, %div477
  %add480 = add i64 %call, 952
  %arrayidx481 = getelementptr inbounds float, float* %b, i64 %add480
  %94 = load float, float* %arrayidx481, align 4, !tbaa !8
  %call482 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul478, float 0x4415AF1D80000000) #2
  %mul483 = fmul float %94, %call482
  %arrayidx486 = getelementptr inbounds float, float* %c, i64 %add480
  store float %mul483, float* %arrayidx486, align 4, !tbaa !8
  %95 = load float, float* %arrayidx39, align 4, !tbaa !8
  %96 = load float, float* %arrayidx265, align 4, !tbaa !8
  %mul493 = fmul float %95, %96
  %mul494 = fmul float %mul3, %mul493
  %add496 = add i64 %call, 224
  %arrayidx497 = getelementptr inbounds float, float* %d, i64 %add496
  %97 = load float, float* %arrayidx497, align 4, !tbaa !8
  %div498 = fdiv float 1.000000e+00, %97, !fpmath !12
  %mul499 = fmul float %mul494, %div498
  %add501 = add i64 %call, 960
  %arrayidx502 = getelementptr inbounds float, float* %b, i64 %add501
  %98 = load float, float* %arrayidx502, align 4, !tbaa !8
  %call503 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul499, float 0x4415AF1D80000000) #2
  %mul504 = fmul float %98, %call503
  %arrayidx507 = getelementptr inbounds float, float* %c, i64 %add501
  store float %mul504, float* %arrayidx507, align 4, !tbaa !8
  %99 = load float, float* %arrayidx265, align 4, !tbaa !8
  %100 = load float, float* %arrayidx335, align 4, !tbaa !8
  %div514 = fdiv float 1.000000e+00, %100, !fpmath !12
  %mul515 = fmul float %99, %div514
  %add517 = add i64 %call, 968
  %arrayidx518 = getelementptr inbounds float, float* %b, i64 %add517
  %101 = load float, float* %arrayidx518, align 4, !tbaa !8
  %call519 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul515, float 0x4415AF1D80000000) #2
  %mul520 = fmul float %101, %call519
  %arrayidx523 = getelementptr inbounds float, float* %c, i64 %add517
  store float %mul520, float* %arrayidx523, align 4, !tbaa !8
  %102 = load float, float* %arrayidx53, align 4, !tbaa !8
  %103 = load float, float* %arrayidx335, align 4, !tbaa !8
  %mul530 = fmul float %102, %103
  %104 = load float, float* %arrayidx125, align 4, !tbaa !8
  %105 = load float, float* %arrayidx183, align 4, !tbaa !8
  %mul537 = fmul float %104, %105
  %div538 = fdiv float 1.000000e+00, %mul537, !fpmath !12
  %mul539 = fmul float %mul530, %div538
  %add541 = add i64 %call, 976
  %arrayidx542 = getelementptr inbounds float, float* %b, i64 %add541
  %106 = load float, float* %arrayidx542, align 4, !tbaa !8
  %call543 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul539, float 0x4415AF1D80000000) #2
  %mul544 = fmul float %106, %call543
  %arrayidx547 = getelementptr inbounds float, float* %c, i64 %add541
  store float %mul544, float* %arrayidx547, align 4, !tbaa !8
  %107 = load float, float* %arrayidx60, align 4, !tbaa !8
  %108 = load float, float* %arrayidx335, align 4, !tbaa !8
  %mul554 = fmul float %107, %108
  %109 = load float, float* %arrayidx29, align 4, !tbaa !8
  %110 = load float, float* %arrayidx427, align 4, !tbaa !8
  %mul561 = fmul float %109, %110
  %div562 = fdiv float 1.000000e+00, %mul561, !fpmath !12
  %mul563 = fmul float %mul554, %div562
  %add565 = add i64 %call, 984
  %arrayidx566 = getelementptr inbounds float, float* %b, i64 %add565
  %111 = load float, float* %arrayidx566, align 4, !tbaa !8
  %call567 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul563, float 0x4415AF1D80000000) #2
  %mul568 = fmul float %111, %call567
  %arrayidx571 = getelementptr inbounds float, float* %c, i64 %add565
  store float %mul568, float* %arrayidx571, align 4, !tbaa !8
  %112 = load float, float* %arrayidx5, align 4, !tbaa !8
  %113 = load float, float* %arrayidx335, align 4, !tbaa !8
  %mul578 = fmul float %112, %113
  %114 = load float, float* %arrayidx125, align 4, !tbaa !8
  %add583 = add i64 %call, 112
  %arrayidx584 = getelementptr inbounds float, float* %d, i64 %add583
  %115 = load float, float* %arrayidx584, align 4, !tbaa !8
  %mul585 = fmul float %114, %115
  %div586 = fdiv float 1.000000e+00, %mul585, !fpmath !12
  %mul587 = fmul float %mul578, %div586
  %add589 = add i64 %call, 992
  %arrayidx590 = getelementptr inbounds float, float* %b, i64 %add589
  %116 = load float, float* %arrayidx590, align 4, !tbaa !8
  %call591 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul587, float 0x4415AF1D80000000) #2
  %mul592 = fmul float %116, %call591
  %arrayidx595 = getelementptr inbounds float, float* %c, i64 %add589
  store float %mul592, float* %arrayidx595, align 4, !tbaa !8
  ret void
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_global_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: convergent nounwind readnone
declare dso_local float @"?fmin@@$$J0YAMMM@Z"(float, float) local_unnamed_addr #1

attributes #0 = { convergent nofree norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "uniform-work-group-size"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { convergent nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { convergent nounwind readnone }

!llvm.module.flags = !{!0, !1}
!opencl.ocl.version = !{!2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 2, i32 0}
!3 = !{!"clang version 12.0.0"}
!4 = !{i32 1, i32 1, i32 1, i32 1, i32 0}
!5 = !{!"none", !"none", !"none", !"none", !"none"}
!6 = !{!"float*", !"float*", !"float*", !"float*", !"float"}
!7 = !{!"const", !"const", !"", !"const", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = !{float 2.500000e+00}
