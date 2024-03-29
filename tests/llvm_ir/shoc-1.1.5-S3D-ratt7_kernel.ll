; ModuleID = './kernels/kernels/shoc-1.1.5-S3D-ratt7_kernel.cl'
source_filename = "./kernels/kernels/shoc-1.1.5-S3D-ratt7_kernel.cl"
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
  %add = add i64 %call, 8
  %arrayidx5 = getelementptr inbounds float, float* %d, i64 %add
  %1 = load float, float* %arrayidx5, align 4, !tbaa !8
  %add7 = add i64 %call, 200
  %arrayidx8 = getelementptr inbounds float, float* %d, i64 %add7
  %2 = load float, float* %arrayidx8, align 4, !tbaa !8
  %mul9 = fmul float %1, %2
  %mul10 = fmul float %mul9, %mul3
  %add12 = add i64 %call, 208
  %arrayidx13 = getelementptr inbounds float, float* %d, i64 %add12
  %3 = load float, float* %arrayidx13, align 4, !tbaa !8
  %div14 = fdiv float 1.000000e+00, %3, !fpmath !12
  %mul15 = fmul float %div14, %mul10
  %add17 = add i64 %call, 1000
  %arrayidx18 = getelementptr inbounds float, float* %b, i64 %add17
  %4 = load float, float* %arrayidx18, align 4, !tbaa !8
  %call19 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul15, float 0x4415AF1D80000000) #2
  %mul20 = fmul float %4, %call19
  %arrayidx23 = getelementptr inbounds float, float* %c, i64 %add17
  store float %mul20, float* %arrayidx23, align 4, !tbaa !8
  %5 = load float, float* %arrayidx5, align 4, !tbaa !8
  %6 = load float, float* %arrayidx8, align 4, !tbaa !8
  %mul30 = fmul float %5, %6
  %arrayidx33 = getelementptr inbounds float, float* %d, i64 %call
  %7 = load float, float* %arrayidx33, align 4, !tbaa !8
  %add35 = add i64 %call, 192
  %arrayidx36 = getelementptr inbounds float, float* %d, i64 %add35
  %8 = load float, float* %arrayidx36, align 4, !tbaa !8
  %mul37 = fmul float %7, %8
  %div38 = fdiv float 1.000000e+00, %mul37, !fpmath !12
  %mul39 = fmul float %mul30, %div38
  %add41 = add i64 %call, 1008
  %arrayidx42 = getelementptr inbounds float, float* %b, i64 %add41
  %9 = load float, float* %arrayidx42, align 4, !tbaa !8
  %call43 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul39, float 0x4415AF1D80000000) #2
  %mul44 = fmul float %9, %call43
  %arrayidx47 = getelementptr inbounds float, float* %c, i64 %add41
  store float %mul44, float* %arrayidx47, align 4, !tbaa !8
  %10 = load float, float* %arrayidx5, align 4, !tbaa !8
  %11 = load float, float* %arrayidx8, align 4, !tbaa !8
  %mul54 = fmul float %10, %11
  %add56 = add i64 %call, 88
  %arrayidx57 = getelementptr inbounds float, float* %d, i64 %add56
  %12 = load float, float* %arrayidx57, align 4, !tbaa !8
  %add59 = add i64 %call, 104
  %arrayidx60 = getelementptr inbounds float, float* %d, i64 %add59
  %13 = load float, float* %arrayidx60, align 4, !tbaa !8
  %mul61 = fmul float %12, %13
  %div62 = fdiv float 1.000000e+00, %mul61, !fpmath !12
  %mul63 = fmul float %mul54, %div62
  %add65 = add i64 %call, 1016
  %arrayidx66 = getelementptr inbounds float, float* %b, i64 %add65
  %14 = load float, float* %arrayidx66, align 4, !tbaa !8
  %call67 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul63, float 0x4415AF1D80000000) #2
  %mul68 = fmul float %14, %call67
  %arrayidx71 = getelementptr inbounds float, float* %c, i64 %add65
  store float %mul68, float* %arrayidx71, align 4, !tbaa !8
  %add73 = add i64 %call, 16
  %arrayidx74 = getelementptr inbounds float, float* %d, i64 %add73
  %15 = load float, float* %arrayidx74, align 4, !tbaa !8
  %16 = load float, float* %arrayidx8, align 4, !tbaa !8
  %mul78 = fmul float %15, %16
  %add80 = add i64 %call, 32
  %arrayidx81 = getelementptr inbounds float, float* %d, i64 %add80
  %17 = load float, float* %arrayidx81, align 4, !tbaa !8
  %18 = load float, float* %arrayidx36, align 4, !tbaa !8
  %mul85 = fmul float %17, %18
  %div86 = fdiv float 1.000000e+00, %mul85, !fpmath !12
  %mul87 = fmul float %mul78, %div86
  %add89 = add i64 %call, 1024
  %arrayidx90 = getelementptr inbounds float, float* %b, i64 %add89
  %19 = load float, float* %arrayidx90, align 4, !tbaa !8
  %call91 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul87, float 0x4415AF1D80000000) #2
  %mul92 = fmul float %19, %call91
  %arrayidx95 = getelementptr inbounds float, float* %c, i64 %add89
  store float %mul92, float* %arrayidx95, align 4, !tbaa !8
  %20 = load float, float* %arrayidx74, align 4, !tbaa !8
  %21 = load float, float* %arrayidx8, align 4, !tbaa !8
  %mul102 = fmul float %20, %21
  %add104 = add i64 %call, 72
  %arrayidx105 = getelementptr inbounds float, float* %d, i64 %add104
  %22 = load float, float* %arrayidx105, align 4, !tbaa !8
  %add107 = add i64 %call, 112
  %arrayidx108 = getelementptr inbounds float, float* %d, i64 %add107
  %23 = load float, float* %arrayidx108, align 4, !tbaa !8
  %mul109 = fmul float %22, %23
  %div110 = fdiv float 1.000000e+00, %mul109, !fpmath !12
  %mul111 = fmul float %mul102, %div110
  %add113 = add i64 %call, 1032
  %arrayidx114 = getelementptr inbounds float, float* %b, i64 %add113
  %24 = load float, float* %arrayidx114, align 4, !tbaa !8
  %call115 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul111, float 0x4415AF1D80000000) #2
  %mul116 = fmul float %24, %call115
  %arrayidx119 = getelementptr inbounds float, float* %c, i64 %add113
  store float %mul116, float* %arrayidx119, align 4, !tbaa !8
  %25 = load float, float* %arrayidx81, align 4, !tbaa !8
  %26 = load float, float* %arrayidx8, align 4, !tbaa !8
  %mul126 = fmul float %25, %26
  %add128 = add i64 %call, 40
  %arrayidx129 = getelementptr inbounds float, float* %d, i64 %add128
  %27 = load float, float* %arrayidx129, align 4, !tbaa !8
  %28 = load float, float* %arrayidx36, align 4, !tbaa !8
  %mul133 = fmul float %27, %28
  %div134 = fdiv float 1.000000e+00, %mul133, !fpmath !12
  %mul135 = fmul float %mul126, %div134
  %add137 = add i64 %call, 1040
  %arrayidx138 = getelementptr inbounds float, float* %b, i64 %add137
  %29 = load float, float* %arrayidx138, align 4, !tbaa !8
  %call139 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul135, float 0x4415AF1D80000000) #2
  %mul140 = fmul float %29, %call139
  %arrayidx143 = getelementptr inbounds float, float* %c, i64 %add137
  store float %mul140, float* %arrayidx143, align 4, !tbaa !8
  %30 = load float, float* %arrayidx5, align 4, !tbaa !8
  %add148 = add i64 %call, 160
  %arrayidx149 = getelementptr inbounds float, float* %d, i64 %add148
  %31 = load float, float* %arrayidx149, align 4, !tbaa !8
  %mul150 = fmul float %30, %31
  %mul151 = fmul float %mul3, %mul150
  %add153 = add i64 %call, 168
  %arrayidx154 = getelementptr inbounds float, float* %d, i64 %add153
  %32 = load float, float* %arrayidx154, align 4, !tbaa !8
  %div155 = fdiv float 1.000000e+00, %32, !fpmath !12
  %mul156 = fmul float %mul151, %div155
  %add158 = add i64 %call, 1048
  %arrayidx159 = getelementptr inbounds float, float* %b, i64 %add158
  %33 = load float, float* %arrayidx159, align 4, !tbaa !8
  %call160 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul156, float 0x4415AF1D80000000) #2
  %mul161 = fmul float %33, %call160
  %arrayidx164 = getelementptr inbounds float, float* %c, i64 %add158
  store float %mul161, float* %arrayidx164, align 4, !tbaa !8
  %34 = load float, float* %arrayidx5, align 4, !tbaa !8
  %35 = load float, float* %arrayidx149, align 4, !tbaa !8
  %mul171 = fmul float %34, %35
  %36 = load float, float* %arrayidx33, align 4, !tbaa !8
  %add176 = add i64 %call, 144
  %arrayidx177 = getelementptr inbounds float, float* %d, i64 %add176
  %37 = load float, float* %arrayidx177, align 4, !tbaa !8
  %mul178 = fmul float %36, %37
  %div179 = fdiv float 1.000000e+00, %mul178, !fpmath !12
  %mul180 = fmul float %mul171, %div179
  %add182 = add i64 %call, 1056
  %arrayidx183 = getelementptr inbounds float, float* %b, i64 %add182
  %38 = load float, float* %arrayidx183, align 4, !tbaa !8
  %call184 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul180, float 0x4415AF1D80000000) #2
  %mul185 = fmul float %38, %call184
  %arrayidx188 = getelementptr inbounds float, float* %c, i64 %add182
  store float %mul185, float* %arrayidx188, align 4, !tbaa !8
  %39 = load float, float* %arrayidx5, align 4, !tbaa !8
  %40 = load float, float* %arrayidx149, align 4, !tbaa !8
  %mul195 = fmul float %39, %40
  %41 = load float, float* %arrayidx33, align 4, !tbaa !8
  %add200 = add i64 %call, 152
  %arrayidx201 = getelementptr inbounds float, float* %d, i64 %add200
  %42 = load float, float* %arrayidx201, align 4, !tbaa !8
  %mul202 = fmul float %41, %42
  %div203 = fdiv float 1.000000e+00, %mul202, !fpmath !12
  %mul204 = fmul float %mul195, %div203
  %add206 = add i64 %call, 1064
  %arrayidx207 = getelementptr inbounds float, float* %b, i64 %add206
  %43 = load float, float* %arrayidx207, align 4, !tbaa !8
  %call208 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul204, float 0x4415AF1D80000000) #2
  %mul209 = fmul float %43, %call208
  %arrayidx212 = getelementptr inbounds float, float* %c, i64 %add206
  store float %mul209, float* %arrayidx212, align 4, !tbaa !8
  %44 = load float, float* %arrayidx74, align 4, !tbaa !8
  %45 = load float, float* %arrayidx149, align 4, !tbaa !8
  %mul219 = fmul float %44, %45
  %46 = load float, float* %arrayidx5, align 4, !tbaa !8
  %47 = load float, float* %arrayidx8, align 4, !tbaa !8
  %mul226 = fmul float %46, %47
  %div227 = fdiv float 1.000000e+00, %mul226, !fpmath !12
  %mul228 = fmul float %mul219, %div227
  %add230 = add i64 %call, 1072
  %arrayidx231 = getelementptr inbounds float, float* %b, i64 %add230
  %48 = load float, float* %arrayidx231, align 4, !tbaa !8
  %call232 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul228, float 0x4415AF1D80000000) #2
  %mul233 = fmul float %48, %call232
  %arrayidx236 = getelementptr inbounds float, float* %c, i64 %add230
  store float %mul233, float* %arrayidx236, align 4, !tbaa !8
  %49 = load float, float* %arrayidx74, align 4, !tbaa !8
  %50 = load float, float* %arrayidx149, align 4, !tbaa !8
  %mul243 = fmul float %49, %50
  %51 = load float, float* %arrayidx57, align 4, !tbaa !8
  %52 = load float, float* %arrayidx60, align 4, !tbaa !8
  %mul250 = fmul float %51, %52
  %div251 = fdiv float 1.000000e+00, %mul250, !fpmath !12
  %mul252 = fmul float %mul243, %div251
  %add254 = add i64 %call, 1080
  %arrayidx255 = getelementptr inbounds float, float* %b, i64 %add254
  %53 = load float, float* %arrayidx255, align 4, !tbaa !8
  %call256 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul252, float 0x4415AF1D80000000) #2
  %mul257 = fmul float %53, %call256
  %arrayidx260 = getelementptr inbounds float, float* %c, i64 %add254
  store float %mul257, float* %arrayidx260, align 4, !tbaa !8
  %54 = load float, float* %arrayidx81, align 4, !tbaa !8
  %55 = load float, float* %arrayidx149, align 4, !tbaa !8
  %mul267 = fmul float %54, %55
  %56 = load float, float* %arrayidx129, align 4, !tbaa !8
  %57 = load float, float* %arrayidx177, align 4, !tbaa !8
  %mul274 = fmul float %56, %57
  %div275 = fdiv float 1.000000e+00, %mul274, !fpmath !12
  %mul276 = fmul float %mul267, %div275
  %add278 = add i64 %call, 1088
  %arrayidx279 = getelementptr inbounds float, float* %b, i64 %add278
  %58 = load float, float* %arrayidx279, align 4, !tbaa !8
  %call280 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul276, float 0x4415AF1D80000000) #2
  %mul281 = fmul float %58, %call280
  %arrayidx284 = getelementptr inbounds float, float* %c, i64 %add278
  store float %mul281, float* %arrayidx284, align 4, !tbaa !8
  %add286 = add i64 %call, 24
  %arrayidx287 = getelementptr inbounds float, float* %d, i64 %add286
  %59 = load float, float* %arrayidx287, align 4, !tbaa !8
  %60 = load float, float* %arrayidx149, align 4, !tbaa !8
  %mul291 = fmul float %59, %60
  %add293 = add i64 %call, 48
  %arrayidx294 = getelementptr inbounds float, float* %d, i64 %add293
  %61 = load float, float* %arrayidx294, align 4, !tbaa !8
  %62 = load float, float* %arrayidx177, align 4, !tbaa !8
  %mul298 = fmul float %61, %62
  %div299 = fdiv float 1.000000e+00, %mul298, !fpmath !12
  %mul300 = fmul float %mul291, %div299
  %add302 = add i64 %call, 1096
  %arrayidx303 = getelementptr inbounds float, float* %b, i64 %add302
  %63 = load float, float* %arrayidx303, align 4, !tbaa !8
  %call304 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul300, float 0x4415AF1D80000000) #2
  %mul305 = fmul float %63, %call304
  %arrayidx308 = getelementptr inbounds float, float* %c, i64 %add302
  store float %mul305, float* %arrayidx308, align 4, !tbaa !8
  %64 = load float, float* %arrayidx287, align 4, !tbaa !8
  %65 = load float, float* %arrayidx149, align 4, !tbaa !8
  %mul315 = fmul float %64, %65
  %66 = load float, float* %arrayidx74, align 4, !tbaa !8
  %67 = load float, float* %arrayidx13, align 4, !tbaa !8
  %mul322 = fmul float %66, %67
  %div323 = fdiv float 1.000000e+00, %mul322, !fpmath !12
  %mul324 = fmul float %mul315, %div323
  %add326 = add i64 %call, 1104
  %arrayidx327 = getelementptr inbounds float, float* %b, i64 %add326
  %68 = load float, float* %arrayidx327, align 4, !tbaa !8
  %call328 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul324, float 0x4415AF1D80000000) #2
  %mul329 = fmul float %68, %call328
  %arrayidx332 = getelementptr inbounds float, float* %c, i64 %add326
  store float %mul329, float* %arrayidx332, align 4, !tbaa !8
  %69 = load float, float* %arrayidx287, align 4, !tbaa !8
  %70 = load float, float* %arrayidx149, align 4, !tbaa !8
  %mul339 = fmul float %69, %70
  %add341 = add i64 %call, 120
  %arrayidx342 = getelementptr inbounds float, float* %d, i64 %add341
  %71 = load float, float* %arrayidx342, align 4, !tbaa !8
  %add344 = add i64 %call, 128
  %arrayidx345 = getelementptr inbounds float, float* %d, i64 %add344
  %72 = load float, float* %arrayidx345, align 4, !tbaa !8
  %mul346 = fmul float %71, %72
  %div347 = fdiv float 1.000000e+00, %mul346, !fpmath !12
  %mul348 = fmul float %mul339, %div347
  %add350 = add i64 %call, 1112
  %arrayidx351 = getelementptr inbounds float, float* %b, i64 %add350
  %73 = load float, float* %arrayidx351, align 4, !tbaa !8
  %call352 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul348, float 0x4415AF1D80000000) #2
  %mul353 = fmul float %73, %call352
  %arrayidx356 = getelementptr inbounds float, float* %c, i64 %add350
  store float %mul353, float* %arrayidx356, align 4, !tbaa !8
  %74 = load float, float* %arrayidx294, align 4, !tbaa !8
  %75 = load float, float* %arrayidx149, align 4, !tbaa !8
  %mul363 = fmul float %74, %75
  %76 = load float, float* %arrayidx81, align 4, !tbaa !8
  %77 = load float, float* %arrayidx13, align 4, !tbaa !8
  %mul370 = fmul float %76, %77
  %div371 = fdiv float 1.000000e+00, %mul370, !fpmath !12
  %mul372 = fmul float %mul363, %div371
  %add374 = add i64 %call, 1120
  %arrayidx375 = getelementptr inbounds float, float* %b, i64 %add374
  %78 = load float, float* %arrayidx375, align 4, !tbaa !8
  %call376 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul372, float 0x4415AF1D80000000) #2
  %mul377 = fmul float %78, %call376
  %arrayidx380 = getelementptr inbounds float, float* %c, i64 %add374
  store float %mul377, float* %arrayidx380, align 4, !tbaa !8
  %add382 = add i64 %call, 56
  %arrayidx383 = getelementptr inbounds float, float* %d, i64 %add382
  %79 = load float, float* %arrayidx383, align 4, !tbaa !8
  %80 = load float, float* %arrayidx149, align 4, !tbaa !8
  %mul387 = fmul float %79, %80
  %81 = load float, float* %arrayidx294, align 4, !tbaa !8
  %82 = load float, float* %arrayidx154, align 4, !tbaa !8
  %mul394 = fmul float %81, %82
  %div395 = fdiv float 1.000000e+00, %mul394, !fpmath !12
  %mul396 = fmul float %mul387, %div395
  %add398 = add i64 %call, 1128
  %arrayidx399 = getelementptr inbounds float, float* %b, i64 %add398
  %83 = load float, float* %arrayidx399, align 4, !tbaa !8
  %call400 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul396, float 0x4415AF1D80000000) #2
  %mul401 = fmul float %83, %call400
  %arrayidx404 = getelementptr inbounds float, float* %c, i64 %add398
  store float %mul401, float* %arrayidx404, align 4, !tbaa !8
  %84 = load float, float* %arrayidx342, align 4, !tbaa !8
  %85 = load float, float* %arrayidx149, align 4, !tbaa !8
  %mul411 = fmul float %84, %85
  %86 = load float, float* %arrayidx60, align 4, !tbaa !8
  %87 = load float, float* %arrayidx154, align 4, !tbaa !8
  %mul418 = fmul float %86, %87
  %div419 = fdiv float 1.000000e+00, %mul418, !fpmath !12
  %mul420 = fmul float %mul411, %div419
  %add422 = add i64 %call, 1136
  %arrayidx423 = getelementptr inbounds float, float* %b, i64 %add422
  %88 = load float, float* %arrayidx423, align 4, !tbaa !8
  %call424 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul420, float 0x4415AF1D80000000) #2
  %mul425 = fmul float %88, %call424
  %arrayidx428 = getelementptr inbounds float, float* %c, i64 %add422
  store float %mul425, float* %arrayidx428, align 4, !tbaa !8
  %89 = load float, float* %arrayidx57, align 4, !tbaa !8
  %90 = load float, float* %arrayidx149, align 4, !tbaa !8
  %mul435 = fmul float %89, %90
  %add437 = add i64 %call, 96
  %arrayidx438 = getelementptr inbounds float, float* %d, i64 %add437
  %91 = load float, float* %arrayidx438, align 4, !tbaa !8
  %92 = load float, float* %arrayidx177, align 4, !tbaa !8
  %mul442 = fmul float %91, %92
  %div443 = fdiv float 1.000000e+00, %mul442, !fpmath !12
  %mul444 = fmul float %mul435, %div443
  %add446 = add i64 %call, 1144
  %arrayidx447 = getelementptr inbounds float, float* %b, i64 %add446
  %93 = load float, float* %arrayidx447, align 4, !tbaa !8
  %call448 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul444, float 0x4415AF1D80000000) #2
  %mul449 = fmul float %93, %call448
  %arrayidx452 = getelementptr inbounds float, float* %c, i64 %add446
  store float %mul449, float* %arrayidx452, align 4, !tbaa !8
  %94 = load float, float* %arrayidx57, align 4, !tbaa !8
  %95 = load float, float* %arrayidx149, align 4, !tbaa !8
  %mul459 = fmul float %94, %95
  %mul460 = fmul float %mul3, %mul459
  %add462 = add i64 %call, 232
  %arrayidx463 = getelementptr inbounds float, float* %d, i64 %add462
  %96 = load float, float* %arrayidx463, align 4, !tbaa !8
  %div464 = fdiv float 1.000000e+00, %96, !fpmath !12
  %mul465 = fmul float %mul460, %div464
  %add467 = add i64 %call, 1152
  %arrayidx468 = getelementptr inbounds float, float* %b, i64 %add467
  %97 = load float, float* %arrayidx468, align 4, !tbaa !8
  %call469 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul465, float 0x4415AF1D80000000) #2
  %mul470 = fmul float %97, %call469
  %arrayidx473 = getelementptr inbounds float, float* %c, i64 %add467
  store float %mul470, float* %arrayidx473, align 4, !tbaa !8
  %98 = load float, float* %arrayidx57, align 4, !tbaa !8
  %99 = load float, float* %arrayidx149, align 4, !tbaa !8
  %mul480 = fmul float %98, %99
  %100 = load float, float* %arrayidx5, align 4, !tbaa !8
  %add485 = add i64 %call, 224
  %arrayidx486 = getelementptr inbounds float, float* %d, i64 %add485
  %101 = load float, float* %arrayidx486, align 4, !tbaa !8
  %mul487 = fmul float %100, %101
  %div488 = fdiv float 1.000000e+00, %mul487, !fpmath !12
  %mul489 = fmul float %mul480, %div488
  %add491 = add i64 %call, 1160
  %arrayidx492 = getelementptr inbounds float, float* %b, i64 %add491
  %102 = load float, float* %arrayidx492, align 4, !tbaa !8
  %call493 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul489, float 0x4415AF1D80000000) #2
  %mul494 = fmul float %102, %call493
  %arrayidx497 = getelementptr inbounds float, float* %c, i64 %add491
  store float %mul494, float* %arrayidx497, align 4, !tbaa !8
  %103 = load float, float* %arrayidx13, align 4, !tbaa !8
  %104 = load float, float* %arrayidx57, align 4, !tbaa !8
  %105 = load float, float* %arrayidx60, align 4, !tbaa !8
  %mul507 = fmul float %104, %105
  %mul508 = fmul float %mul3, %mul507
  %div509 = fdiv float 1.000000e+00, %mul508, !fpmath !12
  %mul510 = fmul float %103, %div509
  %add512 = add i64 %call, 1168
  %arrayidx513 = getelementptr inbounds float, float* %b, i64 %add512
  %106 = load float, float* %arrayidx513, align 4, !tbaa !8
  %call514 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul510, float 0x4415AF1D80000000) #2
  %mul515 = fmul float %106, %call514
  %arrayidx518 = getelementptr inbounds float, float* %c, i64 %add512
  store float %mul515, float* %arrayidx518, align 4, !tbaa !8
  %107 = load float, float* %arrayidx5, align 4, !tbaa !8
  %108 = load float, float* %arrayidx13, align 4, !tbaa !8
  %mul525 = fmul float %107, %108
  %mul526 = fmul float %mul3, %mul525
  %add528 = add i64 %call, 216
  %arrayidx529 = getelementptr inbounds float, float* %d, i64 %add528
  %109 = load float, float* %arrayidx529, align 4, !tbaa !8
  %div530 = fdiv float 1.000000e+00, %109, !fpmath !12
  %mul531 = fmul float %mul526, %div530
  %add533 = add i64 %call, 1176
  %arrayidx534 = getelementptr inbounds float, float* %b, i64 %add533
  %110 = load float, float* %arrayidx534, align 4, !tbaa !8
  %call535 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul531, float 0x4415AF1D80000000) #2
  %mul536 = fmul float %110, %call535
  %arrayidx539 = getelementptr inbounds float, float* %c, i64 %add533
  store float %mul536, float* %arrayidx539, align 4, !tbaa !8
  %111 = load float, float* %arrayidx5, align 4, !tbaa !8
  %112 = load float, float* %arrayidx13, align 4, !tbaa !8
  %mul546 = fmul float %111, %112
  %113 = load float, float* %arrayidx57, align 4, !tbaa !8
  %114 = load float, float* %arrayidx342, align 4, !tbaa !8
  %mul553 = fmul float %113, %114
  %div554 = fdiv float 1.000000e+00, %mul553, !fpmath !12
  %mul555 = fmul float %mul546, %div554
  %add557 = add i64 %call, 1184
  %arrayidx558 = getelementptr inbounds float, float* %b, i64 %add557
  %115 = load float, float* %arrayidx558, align 4, !tbaa !8
  %call559 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul555, float 0x4415AF1D80000000) #2
  %mul560 = fmul float %115, %call559
  %arrayidx563 = getelementptr inbounds float, float* %c, i64 %add557
  store float %mul560, float* %arrayidx563, align 4, !tbaa !8
  %116 = load float, float* %arrayidx5, align 4, !tbaa !8
  %117 = load float, float* %arrayidx13, align 4, !tbaa !8
  %mul570 = fmul float %116, %117
  %118 = load float, float* %arrayidx33, align 4, !tbaa !8
  %119 = load float, float* %arrayidx8, align 4, !tbaa !8
  %mul577 = fmul float %118, %119
  %div578 = fdiv float 1.000000e+00, %mul577, !fpmath !12
  %mul579 = fmul float %mul570, %div578
  %add581 = add i64 %call, 1192
  %arrayidx582 = getelementptr inbounds float, float* %b, i64 %add581
  %120 = load float, float* %arrayidx582, align 4, !tbaa !8
  %call583 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul579, float 0x4415AF1D80000000) #2
  %mul584 = fmul float %120, %call583
  %arrayidx587 = getelementptr inbounds float, float* %c, i64 %add581
  store float %mul584, float* %arrayidx587, align 4, !tbaa !8
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
