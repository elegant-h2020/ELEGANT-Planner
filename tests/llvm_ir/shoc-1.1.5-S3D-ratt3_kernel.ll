; ModuleID = './kernels/kernels/shoc-1.1.5-S3D-ratt3_kernel.cl'
source_filename = "./kernels/kernels/shoc-1.1.5-S3D-ratt3_kernel.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(float* nocapture readonly %a, float* readonly %b, float* %c, float* nocapture readonly %d, float %e) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #2
  %arrayidx = getelementptr inbounds float, float* %a, i64 %call
  %0 = load float, float* %arrayidx, align 4, !tbaa !8
  %mul = fmul float %0, %e
  %mul2 = fmul float %mul, 0x4193D2C640000000
  %div = fdiv float 1.000000e+00, %mul2, !fpmath !12
  %mul3 = fmul float %div, 1.013250e+06
  %add = add i64 %call, 16
  %arrayidx5 = getelementptr inbounds float, float* %d, i64 %add
  %1 = load float, float* %arrayidx5, align 4, !tbaa !8
  %add7 = add i64 %call, 56
  %arrayidx8 = getelementptr inbounds float, float* %d, i64 %add7
  %2 = load float, float* %arrayidx8, align 4, !tbaa !8
  %mul9 = fmul float %1, %2
  %add11 = add i64 %call, 32
  %arrayidx12 = getelementptr inbounds float, float* %d, i64 %add11
  %3 = load float, float* %arrayidx12, align 4, !tbaa !8
  %add14 = add i64 %call, 48
  %arrayidx15 = getelementptr inbounds float, float* %d, i64 %add14
  %4 = load float, float* %arrayidx15, align 4, !tbaa !8
  %mul16 = fmul float %3, %4
  %div17 = fdiv float 1.000000e+00, %mul16, !fpmath !12
  %mul18 = fmul float %mul9, %div17
  %add20 = add i64 %call, 200
  %arrayidx21 = getelementptr inbounds float, float* %b, i64 %add20
  %5 = load float, float* %arrayidx21, align 4, !tbaa !8
  %call22 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul18, float 0x4415AF1D80000000) #2
  %mul23 = fmul float %5, %call22
  %arrayidx26 = getelementptr inbounds float, float* %c, i64 %add20
  store float %mul23, float* %arrayidx26, align 4, !tbaa !8
  %6 = load float, float* %arrayidx12, align 4, !tbaa !8
  %7 = load float, float* %arrayidx8, align 4, !tbaa !8
  %mul33 = fmul float %6, %7
  %add35 = add i64 %call, 40
  %arrayidx36 = getelementptr inbounds float, float* %d, i64 %add35
  %8 = load float, float* %arrayidx36, align 4, !tbaa !8
  %9 = load float, float* %arrayidx15, align 4, !tbaa !8
  %mul40 = fmul float %8, %9
  %div41 = fdiv float 1.000000e+00, %mul40, !fpmath !12
  %mul42 = fmul float %mul33, %div41
  %add44 = add i64 %call, 208
  %arrayidx45 = getelementptr inbounds float, float* %b, i64 %add44
  %10 = load float, float* %arrayidx45, align 4, !tbaa !8
  %call46 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul42, float 0x4415AF1D80000000) #2
  %mul47 = fmul float %10, %call46
  %arrayidx50 = getelementptr inbounds float, float* %c, i64 %add44
  store float %mul47, float* %arrayidx50, align 4, !tbaa !8
  %11 = load float, float* %arrayidx12, align 4, !tbaa !8
  %12 = load float, float* %arrayidx8, align 4, !tbaa !8
  %mul57 = fmul float %11, %12
  %13 = load float, float* %arrayidx36, align 4, !tbaa !8
  %14 = load float, float* %arrayidx15, align 4, !tbaa !8
  %mul64 = fmul float %13, %14
  %div65 = fdiv float 1.000000e+00, %mul64, !fpmath !12
  %mul66 = fmul float %mul57, %div65
  %add68 = add i64 %call, 216
  %arrayidx69 = getelementptr inbounds float, float* %b, i64 %add68
  %15 = load float, float* %arrayidx69, align 4, !tbaa !8
  %call70 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul66, float 0x4415AF1D80000000) #2
  %mul71 = fmul float %15, %call70
  %arrayidx74 = getelementptr inbounds float, float* %c, i64 %add68
  store float %mul71, float* %arrayidx74, align 4, !tbaa !8
  %16 = load float, float* %arrayidx5, align 4, !tbaa !8
  %add79 = add i64 %call, 104
  %arrayidx80 = getelementptr inbounds float, float* %d, i64 %add79
  %17 = load float, float* %arrayidx80, align 4, !tbaa !8
  %mul81 = fmul float %16, %17
  %mul82 = fmul float %mul3, %mul81
  %add84 = add i64 %call, 112
  %arrayidx85 = getelementptr inbounds float, float* %d, i64 %add84
  %18 = load float, float* %arrayidx85, align 4, !tbaa !8
  %div86 = fdiv float 1.000000e+00, %18, !fpmath !12
  %mul87 = fmul float %mul82, %div86
  %add89 = add i64 %call, 224
  %arrayidx90 = getelementptr inbounds float, float* %b, i64 %add89
  %19 = load float, float* %arrayidx90, align 4, !tbaa !8
  %call91 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul87, float 0x4415AF1D80000000) #2
  %mul92 = fmul float %19, %call91
  %arrayidx95 = getelementptr inbounds float, float* %c, i64 %add89
  store float %mul92, float* %arrayidx95, align 4, !tbaa !8
  %20 = load float, float* %arrayidx12, align 4, !tbaa !8
  %21 = load float, float* %arrayidx80, align 4, !tbaa !8
  %mul102 = fmul float %20, %21
  %add104 = add i64 %call, 8
  %arrayidx105 = getelementptr inbounds float, float* %d, i64 %add104
  %22 = load float, float* %arrayidx105, align 4, !tbaa !8
  %23 = load float, float* %arrayidx85, align 4, !tbaa !8
  %mul109 = fmul float %22, %23
  %div110 = fdiv float 1.000000e+00, %mul109, !fpmath !12
  %mul111 = fmul float %mul102, %div110
  %add113 = add i64 %call, 232
  %arrayidx114 = getelementptr inbounds float, float* %b, i64 %add113
  %24 = load float, float* %arrayidx114, align 4, !tbaa !8
  %call115 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul111, float 0x4415AF1D80000000) #2
  %mul116 = fmul float %24, %call115
  %arrayidx119 = getelementptr inbounds float, float* %c, i64 %add113
  store float %mul116, float* %arrayidx119, align 4, !tbaa !8
  %arrayidx122 = getelementptr inbounds float, float* %d, i64 %call
  %25 = load float, float* %arrayidx122, align 4, !tbaa !8
  %26 = load float, float* %arrayidx80, align 4, !tbaa !8
  %mul126 = fmul float %25, %26
  %mul127 = fmul float %mul3, %mul126
  %add129 = add i64 %call, 128
  %arrayidx130 = getelementptr inbounds float, float* %d, i64 %add129
  %27 = load float, float* %arrayidx130, align 4, !tbaa !8
  %div131 = fdiv float 1.000000e+00, %27, !fpmath !12
  %mul132 = fmul float %mul127, %div131
  %add134 = add i64 %call, 240
  %arrayidx135 = getelementptr inbounds float, float* %b, i64 %add134
  %28 = load float, float* %arrayidx135, align 4, !tbaa !8
  %call136 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul132, float 0x4415AF1D80000000) #2
  %mul137 = fmul float %28, %call136
  %arrayidx140 = getelementptr inbounds float, float* %c, i64 %add134
  store float %mul137, float* %arrayidx140, align 4, !tbaa !8
  %add142 = add i64 %call, 24
  %arrayidx143 = getelementptr inbounds float, float* %d, i64 %add142
  %29 = load float, float* %arrayidx143, align 4, !tbaa !8
  %30 = load float, float* %arrayidx80, align 4, !tbaa !8
  %mul147 = fmul float %29, %30
  %31 = load float, float* %arrayidx5, align 4, !tbaa !8
  %32 = load float, float* %arrayidx85, align 4, !tbaa !8
  %mul154 = fmul float %31, %32
  %div155 = fdiv float 1.000000e+00, %mul154, !fpmath !12
  %mul156 = fmul float %mul147, %div155
  %add158 = add i64 %call, 248
  %arrayidx159 = getelementptr inbounds float, float* %b, i64 %add158
  %33 = load float, float* %arrayidx159, align 4, !tbaa !8
  %call160 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul156, float 0x4415AF1D80000000) #2
  %mul161 = fmul float %33, %call160
  %arrayidx164 = getelementptr inbounds float, float* %c, i64 %add158
  store float %mul161, float* %arrayidx164, align 4, !tbaa !8
  %34 = load float, float* %arrayidx15, align 4, !tbaa !8
  %35 = load float, float* %arrayidx80, align 4, !tbaa !8
  %mul171 = fmul float %34, %35
  %36 = load float, float* %arrayidx12, align 4, !tbaa !8
  %37 = load float, float* %arrayidx85, align 4, !tbaa !8
  %mul178 = fmul float %36, %37
  %div179 = fdiv float 1.000000e+00, %mul178, !fpmath !12
  %mul180 = fmul float %mul171, %div179
  %add182 = add i64 %call, 256
  %arrayidx183 = getelementptr inbounds float, float* %b, i64 %add182
  %38 = load float, float* %arrayidx183, align 4, !tbaa !8
  %call184 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul180, float 0x4415AF1D80000000) #2
  %mul185 = fmul float %38, %call184
  %arrayidx188 = getelementptr inbounds float, float* %c, i64 %add182
  store float %mul185, float* %arrayidx188, align 4, !tbaa !8
  %39 = load float, float* %arrayidx5, align 4, !tbaa !8
  %add193 = add i64 %call, 64
  %arrayidx194 = getelementptr inbounds float, float* %d, i64 %add193
  %40 = load float, float* %arrayidx194, align 4, !tbaa !8
  %mul195 = fmul float %39, %40
  %41 = load float, float* %arrayidx105, align 4, !tbaa !8
  %42 = load float, float* %arrayidx80, align 4, !tbaa !8
  %mul202 = fmul float %41, %42
  %div203 = fdiv float 1.000000e+00, %mul202, !fpmath !12
  %mul204 = fmul float %mul195, %div203
  %add206 = add i64 %call, 264
  %arrayidx207 = getelementptr inbounds float, float* %b, i64 %add206
  %43 = load float, float* %arrayidx207, align 4, !tbaa !8
  %call208 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul204, float 0x4415AF1D80000000) #2
  %mul209 = fmul float %43, %call208
  %arrayidx212 = getelementptr inbounds float, float* %c, i64 %add206
  store float %mul209, float* %arrayidx212, align 4, !tbaa !8
  %44 = load float, float* %arrayidx12, align 4, !tbaa !8
  %45 = load float, float* %arrayidx194, align 4, !tbaa !8
  %mul219 = fmul float %44, %45
  %46 = load float, float* %arrayidx105, align 4, !tbaa !8
  %add224 = add i64 %call, 120
  %arrayidx225 = getelementptr inbounds float, float* %d, i64 %add224
  %47 = load float, float* %arrayidx225, align 4, !tbaa !8
  %mul226 = fmul float %46, %47
  %div227 = fdiv float 1.000000e+00, %mul226, !fpmath !12
  %mul228 = fmul float %mul219, %div227
  %add230 = add i64 %call, 272
  %arrayidx231 = getelementptr inbounds float, float* %b, i64 %add230
  %48 = load float, float* %arrayidx231, align 4, !tbaa !8
  %call232 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul228, float 0x4415AF1D80000000) #2
  %mul233 = fmul float %48, %call232
  %arrayidx236 = getelementptr inbounds float, float* %c, i64 %add230
  store float %mul233, float* %arrayidx236, align 4, !tbaa !8
  %49 = load float, float* %arrayidx122, align 4, !tbaa !8
  %50 = load float, float* %arrayidx194, align 4, !tbaa !8
  %mul243 = fmul float %49, %50
  %51 = load float, float* %arrayidx105, align 4, !tbaa !8
  %add248 = add i64 %call, 72
  %arrayidx249 = getelementptr inbounds float, float* %d, i64 %add248
  %52 = load float, float* %arrayidx249, align 4, !tbaa !8
  %mul250 = fmul float %51, %52
  %div251 = fdiv float 1.000000e+00, %mul250, !fpmath !12
  %mul252 = fmul float %mul243, %div251
  %add254 = add i64 %call, 280
  %arrayidx255 = getelementptr inbounds float, float* %b, i64 %add254
  %53 = load float, float* %arrayidx255, align 4, !tbaa !8
  %call256 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul252, float 0x4415AF1D80000000) #2
  %mul257 = fmul float %53, %call256
  %arrayidx260 = getelementptr inbounds float, float* %c, i64 %add254
  store float %mul257, float* %arrayidx260, align 4, !tbaa !8
  %54 = load float, float* %arrayidx36, align 4, !tbaa !8
  %55 = load float, float* %arrayidx194, align 4, !tbaa !8
  %mul267 = fmul float %54, %55
  %56 = load float, float* %arrayidx105, align 4, !tbaa !8
  %57 = load float, float* %arrayidx130, align 4, !tbaa !8
  %mul274 = fmul float %56, %57
  %div275 = fdiv float 1.000000e+00, %mul274, !fpmath !12
  %mul276 = fmul float %mul267, %div275
  %add278 = add i64 %call, 288
  %arrayidx279 = getelementptr inbounds float, float* %b, i64 %add278
  %58 = load float, float* %arrayidx279, align 4, !tbaa !8
  %call280 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul276, float 0x4415AF1D80000000) #2
  %mul281 = fmul float %58, %call280
  %arrayidx284 = getelementptr inbounds float, float* %c, i64 %add278
  store float %mul281, float* %arrayidx284, align 4, !tbaa !8
  %59 = load float, float* %arrayidx143, align 4, !tbaa !8
  %60 = load float, float* %arrayidx194, align 4, !tbaa !8
  %mul291 = fmul float %59, %60
  %61 = load float, float* %arrayidx5, align 4, !tbaa !8
  %62 = load float, float* %arrayidx225, align 4, !tbaa !8
  %mul298 = fmul float %61, %62
  %div299 = fdiv float 1.000000e+00, %mul298, !fpmath !12
  %mul300 = fmul float %mul291, %div299
  %add302 = add i64 %call, 296
  %arrayidx303 = getelementptr inbounds float, float* %b, i64 %add302
  %63 = load float, float* %arrayidx303, align 4, !tbaa !8
  %call304 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul300, float 0x4415AF1D80000000) #2
  %mul305 = fmul float %63, %call304
  %arrayidx308 = getelementptr inbounds float, float* %c, i64 %add302
  store float %mul305, float* %arrayidx308, align 4, !tbaa !8
  %64 = load float, float* %arrayidx194, align 4, !tbaa !8
  %65 = load float, float* %arrayidx80, align 4, !tbaa !8
  %mul315 = fmul float %64, %65
  %mul316 = fmul float %mul3, %mul315
  %add318 = add i64 %call, 192
  %arrayidx319 = getelementptr inbounds float, float* %d, i64 %add318
  %66 = load float, float* %arrayidx319, align 4, !tbaa !8
  %div320 = fdiv float 1.000000e+00, %66, !fpmath !12
  %mul321 = fmul float %mul316, %div320
  %add323 = add i64 %call, 304
  %arrayidx324 = getelementptr inbounds float, float* %b, i64 %add323
  %67 = load float, float* %arrayidx324, align 4, !tbaa !8
  %call325 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul321, float 0x4415AF1D80000000) #2
  %mul326 = fmul float %67, %call325
  %arrayidx329 = getelementptr inbounds float, float* %c, i64 %add323
  store float %mul326, float* %arrayidx329, align 4, !tbaa !8
  %68 = load float, float* %arrayidx194, align 4, !tbaa !8
  %69 = load float, float* %arrayidx85, align 4, !tbaa !8
  %mul336 = fmul float %68, %69
  %70 = load float, float* %arrayidx80, align 4, !tbaa !8
  %71 = load float, float* %arrayidx225, align 4, !tbaa !8
  %mul343 = fmul float %70, %71
  %div344 = fdiv float 1.000000e+00, %mul343, !fpmath !12
  %mul345 = fmul float %mul336, %div344
  %add347 = add i64 %call, 312
  %arrayidx348 = getelementptr inbounds float, float* %b, i64 %add347
  %72 = load float, float* %arrayidx348, align 4, !tbaa !8
  %call349 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul345, float 0x4415AF1D80000000) #2
  %mul350 = fmul float %72, %call349
  %arrayidx353 = getelementptr inbounds float, float* %c, i64 %add347
  store float %mul350, float* %arrayidx353, align 4, !tbaa !8
  %73 = load float, float* %arrayidx105, align 4, !tbaa !8
  %74 = load float, float* %arrayidx225, align 4, !tbaa !8
  %mul360 = fmul float %73, %74
  %mul361 = fmul float %mul3, %mul360
  %75 = load float, float* %arrayidx130, align 4, !tbaa !8
  %div365 = fdiv float 1.000000e+00, %75, !fpmath !12
  %mul366 = fmul float %mul361, %div365
  %add368 = add i64 %call, 320
  %arrayidx369 = getelementptr inbounds float, float* %b, i64 %add368
  %76 = load float, float* %arrayidx369, align 4, !tbaa !8
  %call370 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul366, float 0x4415AF1D80000000) #2
  %mul371 = fmul float %76, %call370
  %arrayidx374 = getelementptr inbounds float, float* %c, i64 %add368
  store float %mul371, float* %arrayidx374, align 4, !tbaa !8
  %77 = load float, float* %arrayidx105, align 4, !tbaa !8
  %78 = load float, float* %arrayidx225, align 4, !tbaa !8
  %mul381 = fmul float %77, %78
  %79 = load float, float* %arrayidx122, align 4, !tbaa !8
  %80 = load float, float* %arrayidx80, align 4, !tbaa !8
  %mul388 = fmul float %79, %80
  %div389 = fdiv float 1.000000e+00, %mul388, !fpmath !12
  %mul390 = fmul float %mul381, %div389
  %add392 = add i64 %call, 328
  %arrayidx393 = getelementptr inbounds float, float* %b, i64 %add392
  %81 = load float, float* %arrayidx393, align 4, !tbaa !8
  %call394 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul390, float 0x4415AF1D80000000) #2
  %mul395 = fmul float %81, %call394
  %arrayidx398 = getelementptr inbounds float, float* %c, i64 %add392
  store float %mul395, float* %arrayidx398, align 4, !tbaa !8
  %82 = load float, float* %arrayidx5, align 4, !tbaa !8
  %83 = load float, float* %arrayidx225, align 4, !tbaa !8
  %mul405 = fmul float %82, %83
  %84 = load float, float* %arrayidx12, align 4, !tbaa !8
  %85 = load float, float* %arrayidx80, align 4, !tbaa !8
  %mul412 = fmul float %84, %85
  %div413 = fdiv float 1.000000e+00, %mul412, !fpmath !12
  %mul414 = fmul float %mul405, %div413
  %add416 = add i64 %call, 336
  %arrayidx417 = getelementptr inbounds float, float* %b, i64 %add416
  %86 = load float, float* %arrayidx417, align 4, !tbaa !8
  %call418 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul414, float 0x4415AF1D80000000) #2
  %mul419 = fmul float %86, %call418
  %arrayidx422 = getelementptr inbounds float, float* %c, i64 %add416
  store float %mul419, float* %arrayidx422, align 4, !tbaa !8
  %87 = load float, float* %arrayidx5, align 4, !tbaa !8
  %88 = load float, float* %arrayidx225, align 4, !tbaa !8
  %mul429 = fmul float %87, %88
  %89 = load float, float* %arrayidx105, align 4, !tbaa !8
  %90 = load float, float* %arrayidx85, align 4, !tbaa !8
  %mul436 = fmul float %89, %90
  %div437 = fdiv float 1.000000e+00, %mul436, !fpmath !12
  %mul438 = fmul float %mul429, %div437
  %add440 = add i64 %call, 344
  %arrayidx441 = getelementptr inbounds float, float* %b, i64 %add440
  %91 = load float, float* %arrayidx441, align 4, !tbaa !8
  %call442 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul438, float 0x4415AF1D80000000) #2
  %mul443 = fmul float %91, %call442
  %arrayidx446 = getelementptr inbounds float, float* %c, i64 %add440
  store float %mul443, float* %arrayidx446, align 4, !tbaa !8
  %92 = load float, float* %arrayidx12, align 4, !tbaa !8
  %93 = load float, float* %arrayidx225, align 4, !tbaa !8
  %mul453 = fmul float %92, %93
  %94 = load float, float* %arrayidx36, align 4, !tbaa !8
  %95 = load float, float* %arrayidx80, align 4, !tbaa !8
  %mul460 = fmul float %94, %95
  %div461 = fdiv float 1.000000e+00, %mul460, !fpmath !12
  %mul462 = fmul float %mul453, %div461
  %add464 = add i64 %call, 352
  %arrayidx465 = getelementptr inbounds float, float* %b, i64 %add464
  %96 = load float, float* %arrayidx465, align 4, !tbaa !8
  %call466 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul462, float 0x4415AF1D80000000) #2
  %mul467 = fmul float %96, %call466
  %arrayidx470 = getelementptr inbounds float, float* %c, i64 %add464
  store float %mul467, float* %arrayidx470, align 4, !tbaa !8
  %97 = load float, float* %arrayidx225, align 4, !tbaa !8
  %mul474 = fmul float %mul3, %97
  %98 = load float, float* %arrayidx105, align 4, !tbaa !8
  %99 = load float, float* %arrayidx80, align 4, !tbaa !8
  %mul481 = fmul float %98, %99
  %div482 = fdiv float 1.000000e+00, %mul481, !fpmath !12
  %mul483 = fmul float %mul474, %div482
  %add485 = add i64 %call, 360
  %arrayidx486 = getelementptr inbounds float, float* %b, i64 %add485
  %100 = load float, float* %arrayidx486, align 4, !tbaa !8
  %call487 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul483, float 0x4415AF1D80000000) #2
  %mul488 = fmul float %100, %call487
  %arrayidx491 = getelementptr inbounds float, float* %c, i64 %add485
  store float %mul488, float* %arrayidx491, align 4, !tbaa !8
  %101 = load float, float* %arrayidx143, align 4, !tbaa !8
  %102 = load float, float* %arrayidx225, align 4, !tbaa !8
  %mul498 = fmul float %101, %102
  %103 = load float, float* %arrayidx15, align 4, !tbaa !8
  %104 = load float, float* %arrayidx80, align 4, !tbaa !8
  %mul505 = fmul float %103, %104
  %div506 = fdiv float 1.000000e+00, %mul505, !fpmath !12
  %mul507 = fmul float %mul498, %div506
  %add509 = add i64 %call, 368
  %arrayidx510 = getelementptr inbounds float, float* %b, i64 %add509
  %105 = load float, float* %arrayidx510, align 4, !tbaa !8
  %call511 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul507, float 0x4415AF1D80000000) #2
  %mul512 = fmul float %105, %call511
  %arrayidx515 = getelementptr inbounds float, float* %c, i64 %add509
  store float %mul512, float* %arrayidx515, align 4, !tbaa !8
  %106 = load float, float* %arrayidx105, align 4, !tbaa !8
  %107 = load float, float* %arrayidx249, align 4, !tbaa !8
  %mul522 = fmul float %106, %107
  %mul523 = fmul float %mul3, %mul522
  %add525 = add i64 %call, 88
  %arrayidx526 = getelementptr inbounds float, float* %d, i64 %add525
  %108 = load float, float* %arrayidx526, align 4, !tbaa !8
  %div527 = fdiv float 1.000000e+00, %108, !fpmath !12
  %mul528 = fmul float %mul523, %div527
  %add530 = add i64 %call, 376
  %arrayidx531 = getelementptr inbounds float, float* %b, i64 %add530
  %109 = load float, float* %arrayidx531, align 4, !tbaa !8
  %call532 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul528, float 0x4415AF1D80000000) #2
  %mul533 = fmul float %109, %call532
  %arrayidx536 = getelementptr inbounds float, float* %c, i64 %add530
  store float %mul533, float* %arrayidx536, align 4, !tbaa !8
  %110 = load float, float* %arrayidx122, align 4, !tbaa !8
  %111 = load float, float* %arrayidx249, align 4, !tbaa !8
  %mul543 = fmul float %110, %111
  %112 = load float, float* %arrayidx105, align 4, !tbaa !8
  %113 = load float, float* %arrayidx526, align 4, !tbaa !8
  %mul550 = fmul float %112, %113
  %div551 = fdiv float 1.000000e+00, %mul550, !fpmath !12
  %mul552 = fmul float %mul543, %div551
  %add554 = add i64 %call, 384
  %arrayidx555 = getelementptr inbounds float, float* %b, i64 %add554
  %114 = load float, float* %arrayidx555, align 4, !tbaa !8
  %call556 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul552, float 0x4415AF1D80000000) #2
  %mul557 = fmul float %114, %call556
  %arrayidx560 = getelementptr inbounds float, float* %c, i64 %add554
  store float %mul557, float* %arrayidx560, align 4, !tbaa !8
  %115 = load float, float* %arrayidx5, align 4, !tbaa !8
  %116 = load float, float* %arrayidx249, align 4, !tbaa !8
  %mul567 = fmul float %115, %116
  %117 = load float, float* %arrayidx105, align 4, !tbaa !8
  %118 = load float, float* %arrayidx225, align 4, !tbaa !8
  %mul574 = fmul float %117, %118
  %div575 = fdiv float 1.000000e+00, %mul574, !fpmath !12
  %mul576 = fmul float %mul567, %div575
  %add578 = add i64 %call, 392
  %arrayidx579 = getelementptr inbounds float, float* %b, i64 %add578
  %119 = load float, float* %arrayidx579, align 4, !tbaa !8
  %call580 = tail call float @"?fmin@@$$J0YAMMM@Z"(float %mul576, float 0x4415AF1D80000000) #2
  %mul581 = fmul float %119, %call580
  %arrayidx584 = getelementptr inbounds float, float* %c, i64 %add578
  store float %mul581, float* %arrayidx584, align 4, !tbaa !8
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
