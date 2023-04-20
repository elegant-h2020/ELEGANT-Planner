; ModuleID = './kernels/kernels/shoc-1.1.5-S3D-qssab_kernel.cl'
source_filename = "./kernels/kernels/shoc-1.1.5-S3D-qssab_kernel.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(float* nocapture readnone %a, float* nocapture readnone %b, float* %c) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #3
  %add = add i64 %call, 696
  %arrayidx = getelementptr inbounds float, float* %c, i64 %add
  %0 = load float, float* %arrayidx, align 4, !tbaa !8
  %add2 = add i64 %call, 776
  %arrayidx3 = getelementptr inbounds float, float* %c, i64 %add2
  %1 = load float, float* %arrayidx3, align 4, !tbaa !8
  %add5 = add i64 %call, 872
  %arrayidx6 = getelementptr inbounds float, float* %c, i64 %add5
  %2 = load float, float* %arrayidx6, align 4, !tbaa !8
  %3 = tail call float @llvm.fmuladd.f32(float %1, float %2, float %0)
  %add14 = add i64 %call, 936
  %arrayidx15 = getelementptr inbounds float, float* %c, i64 %add14
  %4 = load float, float* %arrayidx15, align 4, !tbaa !8
  %neg = fneg float %1
  %5 = tail call float @llvm.fmuladd.f32(float %neg, float %4, float 1.000000e+00)
  %div = fdiv float 1.000000e+00, %5, !fpmath !12
  %mul = fmul float %3, %div
  store float %mul, float* %arrayidx, align 4, !tbaa !8
  %add23 = add i64 %call, 728
  %arrayidx24 = getelementptr inbounds float, float* %c, i64 %add23
  %6 = load float, float* %arrayidx24, align 4, !tbaa !8
  %mul26 = fmul float %6, %div
  store float %mul26, float* %arrayidx24, align 4, !tbaa !8
  %add31 = add i64 %call, 720
  %arrayidx32 = getelementptr inbounds float, float* %c, i64 %add31
  %7 = load float, float* %arrayidx32, align 4, !tbaa !8
  %mul34 = fmul float %div, %7
  store float %mul34, float* %arrayidx32, align 4, !tbaa !8
  %add39 = add i64 %call, 256
  %arrayidx40 = getelementptr inbounds float, float* %c, i64 %add39
  %8 = load float, float* %arrayidx40, align 4, !tbaa !8
  %add42 = add i64 %call, 296
  %arrayidx43 = getelementptr inbounds float, float* %c, i64 %add42
  %9 = load float, float* %arrayidx43, align 4, !tbaa !8
  %add45 = add i64 %call, 432
  %arrayidx46 = getelementptr inbounds float, float* %c, i64 %add45
  %10 = load float, float* %arrayidx46, align 4, !tbaa !8
  %11 = tail call float @llvm.fmuladd.f32(float %9, float %10, float %8)
  %add55 = add i64 %call, 456
  %arrayidx56 = getelementptr inbounds float, float* %c, i64 %add55
  %12 = load float, float* %arrayidx56, align 4, !tbaa !8
  %neg58 = fneg float %9
  %13 = tail call float @llvm.fmuladd.f32(float %neg58, float %12, float 1.000000e+00)
  %div62 = fdiv float 1.000000e+00, %13, !fpmath !12
  %mul63 = fmul float %11, %div62
  store float %mul63, float* %arrayidx40, align 4, !tbaa !8
  %add68 = add i64 %call, 288
  %arrayidx69 = getelementptr inbounds float, float* %c, i64 %add68
  %14 = load float, float* %arrayidx69, align 4, !tbaa !8
  %mul71 = fmul float %14, %div62
  store float %mul71, float* %arrayidx69, align 4, !tbaa !8
  %add76 = add i64 %call, 272
  %arrayidx77 = getelementptr inbounds float, float* %c, i64 %add76
  %15 = load float, float* %arrayidx77, align 4, !tbaa !8
  %mul79 = fmul float %div62, %15
  store float %mul79, float* %arrayidx77, align 4, !tbaa !8
  %add84 = add i64 %call, 264
  %arrayidx85 = getelementptr inbounds float, float* %c, i64 %add84
  %16 = load float, float* %arrayidx85, align 4, !tbaa !8
  %mul87 = fmul float %div62, %16
  store float %mul87, float* %arrayidx85, align 4, !tbaa !8
  %add92 = add i64 %call, 320
  %arrayidx93 = getelementptr inbounds float, float* %c, i64 %add92
  %17 = load float, float* %arrayidx93, align 4, !tbaa !8
  %mul95 = fmul float %div62, %17
  store float %mul95, float* %arrayidx93, align 4, !tbaa !8
  %add100 = add i64 %call, 304
  %arrayidx101 = getelementptr inbounds float, float* %c, i64 %add100
  %18 = load float, float* %arrayidx101, align 4, !tbaa !8
  %mul103 = fmul float %div62, %18
  store float %mul103, float* %arrayidx101, align 4, !tbaa !8
  %add108 = add i64 %call, 344
  %arrayidx109 = getelementptr inbounds float, float* %c, i64 %add108
  %19 = load float, float* %arrayidx109, align 4, !tbaa !8
  %add111 = add i64 %call, 416
  %arrayidx112 = getelementptr inbounds float, float* %c, i64 %add111
  %20 = load float, float* %arrayidx112, align 4, !tbaa !8
  %add114 = add i64 %call, 784
  %arrayidx115 = getelementptr inbounds float, float* %c, i64 %add114
  %21 = load float, float* %arrayidx115, align 4, !tbaa !8
  %22 = tail call float @llvm.fmuladd.f32(float %20, float %21, float %19)
  %add121 = add i64 %call, 400
  %arrayidx122 = getelementptr inbounds float, float* %c, i64 %add121
  %23 = load float, float* %arrayidx122, align 4, !tbaa !8
  %add127 = add i64 %call, 840
  %arrayidx128 = getelementptr inbounds float, float* %c, i64 %add127
  %24 = load float, float* %arrayidx128, align 4, !tbaa !8
  %25 = tail call float @llvm.fmuladd.f32(float %20, float %24, float %23)
  %add137 = add i64 %call, 816
  %arrayidx138 = getelementptr inbounds float, float* %c, i64 %add137
  %26 = load float, float* %arrayidx138, align 4, !tbaa !8
  %neg140 = fneg float %20
  %27 = tail call float @llvm.fmuladd.f32(float %neg140, float %26, float 1.000000e+00)
  %div144 = fdiv float 1.000000e+00, %27, !fpmath !12
  %mul145 = fmul float %22, %div144
  store float %mul145, float* %arrayidx109, align 4, !tbaa !8
  %add150 = add i64 %call, 368
  %arrayidx151 = getelementptr inbounds float, float* %c, i64 %add150
  %28 = load float, float* %arrayidx151, align 4, !tbaa !8
  %mul153 = fmul float %28, %div144
  store float %mul153, float* %arrayidx151, align 4, !tbaa !8
  %mul161 = fmul float %25, %div144
  store float %mul161, float* %arrayidx122, align 4, !tbaa !8
  %add166 = add i64 %call, 360
  %arrayidx167 = getelementptr inbounds float, float* %c, i64 %add166
  %29 = load float, float* %arrayidx167, align 4, !tbaa !8
  %mul169 = fmul float %div144, %29
  store float %mul169, float* %arrayidx167, align 4, !tbaa !8
  %add174 = add i64 %call, 352
  %arrayidx175 = getelementptr inbounds float, float* %c, i64 %add174
  %30 = load float, float* %arrayidx175, align 4, !tbaa !8
  %mul177 = fmul float %div144, %30
  store float %mul177, float* %arrayidx175, align 4, !tbaa !8
  %add182 = add i64 %call, 408
  %arrayidx183 = getelementptr inbounds float, float* %c, i64 %add182
  %31 = load float, float* %arrayidx183, align 4, !tbaa !8
  %mul185 = fmul float %div144, %31
  store float %mul185, float* %arrayidx183, align 4, !tbaa !8
  %add190 = add i64 %call, 608
  %arrayidx191 = getelementptr inbounds float, float* %c, i64 %add190
  %32 = load float, float* %arrayidx191, align 4, !tbaa !8
  %add193 = add i64 %call, 680
  %arrayidx194 = getelementptr inbounds float, float* %c, i64 %add193
  %33 = load float, float* %arrayidx194, align 4, !tbaa !8
  %34 = tail call float @llvm.fmuladd.f32(float %33, float %21, float %32)
  %add203 = add i64 %call, 640
  %arrayidx204 = getelementptr inbounds float, float* %c, i64 %add203
  %35 = load float, float* %arrayidx204, align 4, !tbaa !8
  %36 = tail call float @llvm.fmuladd.f32(float %33, float %26, float %35)
  %neg222 = fneg float %33
  %37 = tail call float @llvm.fmuladd.f32(float %neg222, float %24, float 1.000000e+00)
  %div226 = fdiv float 1.000000e+00, %37, !fpmath !12
  %mul227 = fmul float %34, %div226
  %mul235 = fmul float %div226, %36
  %add240 = add i64 %call, 624
  %arrayidx241 = getelementptr inbounds float, float* %c, i64 %add240
  %38 = load float, float* %arrayidx241, align 4, !tbaa !8
  %mul243 = fmul float %div226, %38
  %add248 = add i64 %call, 616
  %arrayidx249 = getelementptr inbounds float, float* %c, i64 %add248
  %39 = load float, float* %arrayidx249, align 4, !tbaa !8
  %mul251 = fmul float %div226, %39
  %add256 = add i64 %call, 656
  %arrayidx257 = getelementptr inbounds float, float* %c, i64 %add256
  %40 = load float, float* %arrayidx257, align 4, !tbaa !8
  %mul259 = fmul float %div226, %40
  store float %mul259, float* %arrayidx257, align 4, !tbaa !8
  %add270 = add i64 %call, 520
  %arrayidx271 = getelementptr inbounds float, float* %c, i64 %add270
  %41 = load float, float* %arrayidx271, align 4, !tbaa !8
  %42 = tail call float @llvm.fmuladd.f32(float %mul103, float %41, float %mul63)
  %add280 = add i64 %call, 576
  %arrayidx281 = getelementptr inbounds float, float* %c, i64 %add280
  %43 = load float, float* %arrayidx281, align 4, !tbaa !8
  %mul282 = fmul float %mul103, %43
  %add284 = add i64 %call, 312
  %arrayidx285 = getelementptr inbounds float, float* %c, i64 %add284
  %add293 = add i64 %call, 536
  %arrayidx294 = getelementptr inbounds float, float* %c, i64 %add293
  %44 = load float, float* %arrayidx294, align 4, !tbaa !8
  %45 = tail call float @llvm.fmuladd.f32(float %mul103, float %44, float %mul79)
  %add303 = add i64 %call, 544
  %arrayidx304 = getelementptr inbounds float, float* %c, i64 %add303
  %46 = load float, float* %arrayidx304, align 4, !tbaa !8
  %neg306 = fneg float %mul103
  %47 = tail call float @llvm.fmuladd.f32(float %neg306, float %46, float 1.000000e+00)
  %div310 = fdiv float 1.000000e+00, %47, !fpmath !12
  %mul311 = fmul float %42, %div310
  %mul319 = fmul float %mul71, %div310
  %mul327 = fmul float %mul282, %div310
  %mul335 = fmul float %45, %div310
  %mul343 = fmul float %mul87, %div310
  %mul351 = fmul float %mul95, %div310
  store float %mul351, float* %arrayidx93, align 4, !tbaa !8
  %48 = tail call float @llvm.fmuladd.f32(float %mul259, float %41, float %mul227)
  %mul374 = fmul float %mul259, %46
  %add376 = add i64 %call, 632
  %arrayidx377 = getelementptr inbounds float, float* %c, i64 %add376
  %49 = tail call float @llvm.fmuladd.f32(float %mul259, float %44, float %mul243)
  %neg398 = fneg float %mul259
  %50 = tail call float @llvm.fmuladd.f32(float %neg398, float %43, float 1.000000e+00)
  %div402 = fdiv float 1.000000e+00, %50, !fpmath !12
  %mul403 = fmul float %48, %div402
  store float %mul403, float* %arrayidx191, align 4, !tbaa !8
  %mul411 = fmul float %mul235, %div402
  store float %mul411, float* %arrayidx204, align 4, !tbaa !8
  %mul419 = fmul float %div402, %mul374
  store float %mul419, float* %arrayidx377, align 4, !tbaa !8
  %mul427 = fmul float %div402, %49
  store float %mul427, float* %arrayidx241, align 4, !tbaa !8
  %mul435 = fmul float %mul251, %div402
  store float %mul435, float* %arrayidx249, align 4, !tbaa !8
  %add440 = add i64 %call, 168
  %arrayidx441 = getelementptr inbounds float, float* %c, i64 %add440
  %51 = load float, float* %arrayidx441, align 4, !tbaa !8
  %add443 = add i64 %call, 216
  %arrayidx444 = getelementptr inbounds float, float* %c, i64 %add443
  %52 = load float, float* %arrayidx444, align 4, !tbaa !8
  %53 = tail call float @llvm.fmuladd.f32(float %52, float %41, float %51)
  %add453 = add i64 %call, 192
  %arrayidx454 = getelementptr inbounds float, float* %c, i64 %add453
  %54 = load float, float* %arrayidx454, align 4, !tbaa !8
  %55 = tail call float @llvm.fmuladd.f32(float %52, float %46, float %54)
  %add466 = add i64 %call, 224
  %arrayidx467 = getelementptr inbounds float, float* %c, i64 %add466
  %56 = load float, float* %arrayidx467, align 4, !tbaa !8
  %57 = tail call float @llvm.fmuladd.f32(float %52, float %43, float %56)
  %neg485 = fneg float %52
  %58 = tail call float @llvm.fmuladd.f32(float %neg485, float %44, float 1.000000e+00)
  %div489 = fdiv float 1.000000e+00, %58, !fpmath !12
  %mul490 = fmul float %53, %div489
  %add495 = add i64 %call, 200
  %arrayidx496 = getelementptr inbounds float, float* %c, i64 %add495
  %59 = load float, float* %arrayidx496, align 4, !tbaa !8
  %mul498 = fmul float %div489, %59
  %mul506 = fmul float %div489, %55
  %mul514 = fmul float %div489, %57
  %add519 = add i64 %call, 176
  %arrayidx520 = getelementptr inbounds float, float* %c, i64 %add519
  %60 = load float, float* %arrayidx520, align 4, !tbaa !8
  %mul522 = fmul float %div489, %60
  store float %mul522, float* %arrayidx520, align 4, !tbaa !8
  %61 = tail call float @llvm.fmuladd.f32(float %mul185, float %mul, float %mul145)
  %62 = tail call float @llvm.fmuladd.f32(float %mul185, float %mul34, float %mul153)
  %neg559 = fneg float %mul185
  %63 = tail call float @llvm.fmuladd.f32(float %neg559, float %mul26, float 1.000000e+00)
  %div563 = fdiv float 1.000000e+00, %63, !fpmath !12
  %mul564 = fmul float %61, %div563
  %mul572 = fmul float %62, %div563
  %mul580 = fmul float %mul161, %div563
  %mul588 = fmul float %mul169, %div563
  %mul596 = fmul float %mul177, %div563
  store float %mul596, float* %arrayidx175, align 4, !tbaa !8
  %64 = tail call float @llvm.fmuladd.f32(float %mul351, float %mul, float %mul311)
  %65 = tail call float @llvm.fmuladd.f32(float %mul351, float %mul26, float %mul319)
  %neg633 = fneg float %mul351
  %66 = tail call float @llvm.fmuladd.f32(float %neg633, float %mul34, float 1.000000e+00)
  %div637 = fdiv float 1.000000e+00, %66, !fpmath !12
  %mul638 = fmul float %64, %div637
  %mul646 = fmul float %65, %div637
  %mul654 = fmul float %mul327, %div637
  %mul662 = fmul float %mul335, %div637
  %mul670 = fmul float %mul343, %div637
  store float %mul670, float* %arrayidx85, align 4, !tbaa !8
  %add681 = add i64 %call, 80
  %arrayidx682 = getelementptr inbounds float, float* %c, i64 %add681
  %67 = load float, float* %arrayidx682, align 4, !tbaa !8
  %68 = tail call float @llvm.fmuladd.f32(float %mul596, float %67, float %mul564)
  %add694 = add i64 %call, 104
  %arrayidx695 = getelementptr inbounds float, float* %c, i64 %add694
  %69 = load float, float* %arrayidx695, align 4, !tbaa !8
  %70 = tail call float @llvm.fmuladd.f32(float %mul596, float %69, float %mul572)
  %add707 = add i64 %call, 136
  %arrayidx708 = getelementptr inbounds float, float* %c, i64 %add707
  %71 = load float, float* %arrayidx708, align 4, !tbaa !8
  %72 = tail call float @llvm.fmuladd.f32(float %mul596, float %71, float %mul580)
  %add720 = add i64 %call, 96
  %arrayidx721 = getelementptr inbounds float, float* %c, i64 %add720
  %73 = load float, float* %arrayidx721, align 4, !tbaa !8
  %74 = tail call float @llvm.fmuladd.f32(float %mul596, float %73, float %mul588)
  %add730 = add i64 %call, 112
  %arrayidx731 = getelementptr inbounds float, float* %c, i64 %add730
  %75 = load float, float* %arrayidx731, align 4, !tbaa !8
  %neg733 = fneg float %mul596
  %76 = tail call float @llvm.fmuladd.f32(float %neg733, float %75, float 1.000000e+00)
  %div737 = fdiv float 1.000000e+00, %76, !fpmath !12
  %mul738 = fmul float %68, %div737
  %mul746 = fmul float %70, %div737
  %mul754 = fmul float %72, %div737
  %mul762 = fmul float %74, %div737
  store float %mul762, float* %arrayidx167, align 4, !tbaa !8
  %77 = tail call float @llvm.fmuladd.f32(float %mul670, float %67, float %mul638)
  %78 = tail call float @llvm.fmuladd.f32(float %mul670, float %75, float %mul646)
  %79 = tail call float @llvm.fmuladd.f32(float %mul670, float %71, float %mul654)
  %80 = tail call float @llvm.fmuladd.f32(float %mul670, float %73, float %mul662)
  %neg825 = fneg float %mul670
  %81 = tail call float @llvm.fmuladd.f32(float %neg825, float %69, float 1.000000e+00)
  %div829 = fdiv float 1.000000e+00, %81, !fpmath !12
  %mul830 = fmul float %77, %div829
  %mul838 = fmul float %div829, %78
  %mul846 = fmul float %div829, %79
  %mul854 = fmul float %div829, %80
  store float %mul854, float* %arrayidx77, align 4, !tbaa !8
  %82 = tail call float @llvm.fmuladd.f32(float %mul435, float %67, float %mul403)
  %83 = tail call float @llvm.fmuladd.f32(float %mul435, float %75, float %mul411)
  %84 = tail call float @llvm.fmuladd.f32(float %mul435, float %69, float %mul419)
  %85 = tail call float @llvm.fmuladd.f32(float %mul435, float %73, float %mul427)
  %neg917 = fneg float %mul435
  %86 = tail call float @llvm.fmuladd.f32(float %neg917, float %71, float 1.000000e+00)
  %div921 = fdiv float 1.000000e+00, %86, !fpmath !12
  %mul922 = fmul float %82, %div921
  %mul930 = fmul float %div921, %83
  %mul938 = fmul float %84, %div921
  %mul946 = fmul float %div921, %85
  store float %mul946, float* %arrayidx241, align 4, !tbaa !8
  %87 = tail call float @llvm.fmuladd.f32(float %mul522, float %67, float %mul490)
  %88 = tail call float @llvm.fmuladd.f32(float %mul522, float %75, float %mul498)
  %89 = tail call float @llvm.fmuladd.f32(float %mul522, float %69, float %mul506)
  %90 = tail call float @llvm.fmuladd.f32(float %mul522, float %71, float %mul514)
  %neg1009 = fneg float %mul522
  %91 = tail call float @llvm.fmuladd.f32(float %neg1009, float %73, float 1.000000e+00)
  %div1013 = fdiv float 1.000000e+00, %91, !fpmath !12
  %mul1014 = fmul float %87, %div1013
  store float %mul1014, float* %arrayidx441, align 4, !tbaa !8
  %mul1022 = fmul float %div1013, %88
  store float %mul1022, float* %arrayidx496, align 4, !tbaa !8
  %mul1030 = fmul float %89, %div1013
  store float %mul1030, float* %arrayidx454, align 4, !tbaa !8
  %mul1038 = fmul float %90, %div1013
  store float %mul1038, float* %arrayidx467, align 4, !tbaa !8
  %92 = tail call float @llvm.fmuladd.f32(float %mul762, float %mul1014, float %mul738)
  %93 = tail call float @llvm.fmuladd.f32(float %mul762, float %mul1030, float %mul746)
  %94 = tail call float @llvm.fmuladd.f32(float %mul762, float %mul1038, float %mul754)
  %neg1088 = fneg float %mul762
  %95 = tail call float @llvm.fmuladd.f32(float %neg1088, float %mul1022, float 1.000000e+00)
  %div1092 = fdiv float 1.000000e+00, %95, !fpmath !12
  %mul1093 = fmul float %92, %div1092
  %mul1101 = fmul float %93, %div1092
  %mul1109 = fmul float %94, %div1092
  store float %mul1109, float* %arrayidx122, align 4, !tbaa !8
  %96 = tail call float @llvm.fmuladd.f32(float %mul854, float %mul1014, float %mul830)
  %97 = tail call float @llvm.fmuladd.f32(float %mul854, float %mul1022, float %mul838)
  %98 = tail call float @llvm.fmuladd.f32(float %mul854, float %mul1038, float %mul846)
  %neg1159 = fneg float %mul854
  %99 = tail call float @llvm.fmuladd.f32(float %neg1159, float %mul1030, float 1.000000e+00)
  %div1163 = fdiv float 1.000000e+00, %99, !fpmath !12
  %mul1164 = fmul float %96, %div1163
  %mul1172 = fmul float %97, %div1163
  %mul1180 = fmul float %98, %div1163
  store float %mul1180, float* %arrayidx285, align 4, !tbaa !8
  %100 = tail call float @llvm.fmuladd.f32(float %mul946, float %mul1014, float %mul922)
  %101 = tail call float @llvm.fmuladd.f32(float %mul946, float %mul1022, float %mul930)
  %102 = tail call float @llvm.fmuladd.f32(float %mul946, float %mul1030, float %mul938)
  %neg1230 = fneg float %mul946
  %103 = tail call float @llvm.fmuladd.f32(float %neg1230, float %mul1038, float 1.000000e+00)
  %div1234 = fdiv float 1.000000e+00, %103, !fpmath !12
  %mul1235 = fmul float %100, %div1234
  store float %mul1235, float* %arrayidx191, align 4, !tbaa !8
  %mul1243 = fmul float %101, %div1234
  store float %mul1243, float* %arrayidx204, align 4, !tbaa !8
  %mul1251 = fmul float %102, %div1234
  store float %mul1251, float* %arrayidx377, align 4, !tbaa !8
  %104 = tail call float @llvm.fmuladd.f32(float %mul1109, float %mul1235, float %mul1093)
  %105 = tail call float @llvm.fmuladd.f32(float %mul1109, float %mul1251, float %mul1101)
  %neg1288 = fneg float %mul1109
  %106 = tail call float @llvm.fmuladd.f32(float %neg1288, float %mul1243, float 1.000000e+00)
  %div1292 = fdiv float 1.000000e+00, %106, !fpmath !12
  %mul1293 = fmul float %104, %div1292
  %mul1301 = fmul float %105, %div1292
  store float %mul1301, float* %arrayidx151, align 4, !tbaa !8
  %107 = tail call float @llvm.fmuladd.f32(float %mul1180, float %mul1235, float %mul1164)
  %108 = tail call float @llvm.fmuladd.f32(float %mul1180, float %mul1243, float %mul1172)
  %neg1338 = fneg float %mul1180
  %109 = tail call float @llvm.fmuladd.f32(float %neg1338, float %mul1251, float 1.000000e+00)
  %div1342 = fdiv float 1.000000e+00, %109, !fpmath !12
  %mul1343 = fmul float %107, %div1342
  store float %mul1343, float* %arrayidx40, align 4, !tbaa !8
  %mul1351 = fmul float %108, %div1342
  store float %mul1351, float* %arrayidx69, align 4, !tbaa !8
  %110 = tail call float @llvm.fmuladd.f32(float %mul1301, float %mul1343, float %mul1293)
  %neg1375 = fneg float %mul1301
  %111 = tail call float @llvm.fmuladd.f32(float %neg1375, float %mul1351, float 1.000000e+00)
  %div1379 = fdiv float 1.000000e+00, %111, !fpmath !12
  %mul1380 = fmul float %110, %div1379
  store float %mul1380, float* %arrayidx109, align 4, !tbaa !8
  ret void
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_global_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone speculatable willreturn
declare float @llvm.fmuladd.f32(float, float, float) #2

attributes #0 = { convergent nofree norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "uniform-work-group-size"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { convergent nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { convergent nounwind readnone }

!llvm.module.flags = !{!0, !1}
!opencl.ocl.version = !{!2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 2, i32 0}
!3 = !{!"clang version 12.0.0"}
!4 = !{i32 1, i32 1, i32 1}
!5 = !{!"none", !"none", !"none"}
!6 = !{!"float*", !"float*", !"float*"}
!7 = !{!"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = !{float 2.500000e+00}
