; ModuleID = './kernels/kernels/shoc-1.1.5-S3D-ratt10_kernel.cl'
source_filename = "./kernels/kernels/shoc-1.1.5-S3D-ratt10_kernel.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(float* nocapture readonly %a, float* %b, float %c) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #3
  %arrayidx = getelementptr inbounds float, float* %a, i64 %call
  %0 = load float, float* %arrayidx, align 4, !tbaa !8
  %mul = fmul float %0, %c
  %call1 = tail call float @"?log@@$$J0YAMM@Z"(float %mul) #3
  %1 = tail call float @llvm.fmuladd.f32(float %call1, float 0xBFECCCCCC0000000, float 0x404523C4C0000000)
  %div = fdiv float 1.000000e+00, %mul, !fpmath !12
  %2 = tail call float @llvm.fmuladd.f32(float %div, float 0x408ABBBF20000000, float %1)
  %call4 = tail call float @"?exp@@$$J0YAMM@Z"(float %2) #3
  %arrayidx6 = getelementptr inbounds float, float* %b, i64 %call
  store float %call4, float* %arrayidx6, align 4, !tbaa !8
  %3 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC00B5C2900000000, float 0x404FE58580000000)
  %4 = tail call float @llvm.fmuladd.f32(float %div, float 0xC0E4B9CA60000000, float %3)
  %call10 = tail call float @"?exp@@$$J0YAMM@Z"(float %4) #3
  %add12 = add i64 %call, 8
  %arrayidx13 = getelementptr inbounds float, float* %b, i64 %add12
  store float %call10, float* %arrayidx13, align 4, !tbaa !8
  %5 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC00DEB8520000000, float 0x40505D9020000000)
  %6 = tail call float @llvm.fmuladd.f32(float %div, float 0xC08E71D1E0000000, float %5)
  %call17 = tail call float @"?exp@@$$J0YAMM@Z"(float %6) #3
  %add19 = add i64 %call, 16
  %arrayidx20 = getelementptr inbounds float, float* %b, i64 %add19
  store float %call17, float* %arrayidx20, align 4, !tbaa !8
  %7 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC0048F5C20000000, float 0x404BC7F460000000)
  %8 = tail call float @llvm.fmuladd.f32(float %div, float 0xC08668AB80000000, float %7)
  %call24 = tail call float @"?exp@@$$J0YAMM@Z"(float %8) #3
  %add26 = add i64 %call, 24
  %arrayidx27 = getelementptr inbounds float, float* %b, i64 %add26
  store float %call24, float* %arrayidx27, align 4, !tbaa !8
  %9 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC0091EB860000000, float 0x404FAA9E00000000)
  %10 = tail call float @llvm.fmuladd.f32(float %div, float 0xC08357A6E0000000, float %9)
  %call31 = tail call float @"?exp@@$$J0YAMM@Z"(float %10) #3
  %add33 = add i64 %call, 32
  %arrayidx34 = getelementptr inbounds float, float* %b, i64 %add33
  store float %call31, float* %arrayidx34, align 4, !tbaa !8
  %11 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC01470A3E0000000, float 0x40533E63E0000000)
  %12 = tail call float @llvm.fmuladd.f32(float %div, float 0xC0ABE4A500000000, float %11)
  %call38 = tail call float @"?exp@@$$J0YAMM@Z"(float %12) #3
  %add40 = add i64 %call, 40
  %arrayidx41 = getelementptr inbounds float, float* %b, i64 %add40
  store float %call38, float* %arrayidx41, align 4, !tbaa !8
  %13 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC013333340000000, float 0x4051776CC0000000)
  %14 = tail call float @llvm.fmuladd.f32(float %div, float 0xC0A5DBC500000000, float %13)
  %call45 = tail call float @"?exp@@$$J0YAMM@Z"(float %14) #3
  %add47 = add i64 %call, 48
  %arrayidx48 = getelementptr inbounds float, float* %b, i64 %add47
  store float %call45, float* %arrayidx48, align 4, !tbaa !8
  %15 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC0130A3D80000000, float 0x4053391C60000000)
  %16 = tail call float @llvm.fmuladd.f32(float %div, float 0xC0932F6500000000, float %15)
  %call52 = tail call float @"?exp@@$$J0YAMM@Z"(float %16) #3
  %add54 = add i64 %call, 56
  %arrayidx55 = getelementptr inbounds float, float* %b, i64 %add54
  store float %call52, float* %arrayidx55, align 4, !tbaa !8
  %17 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC0232D0E60000000, float 0x405BD400C0000000)
  %18 = tail call float @llvm.fmuladd.f32(float %div, float 0xC0A40CCF60000000, float %17)
  %call59 = tail call float @"?exp@@$$J0YAMM@Z"(float %18) #3
  %add61 = add i64 %call, 64
  %arrayidx62 = getelementptr inbounds float, float* %b, i64 %add61
  store float %call59, float* %arrayidx62, align 4, !tbaa !8
  %19 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC023570A40000000, float 0x405CECD0A0000000)
  %20 = tail call float @llvm.fmuladd.f32(float %div, float 0xC0A87403E0000000, float %19)
  %call66 = tail call float @"?exp@@$$J0YAMM@Z"(float %20) #3
  %add68 = add i64 %call, 72
  %arrayidx69 = getelementptr inbounds float, float* %b, i64 %add68
  store float %call66, float* %arrayidx69, align 4, !tbaa !8
  %21 = tail call float @llvm.fmuladd.f32(float %call1, float 0xBFE47AE140000000, float 0x4041B7A9A0000000)
  %22 = tail call float @llvm.fmuladd.f32(float %div, float 0xC0D86C77A0000000, float %21)
  %call73 = tail call float @"?exp@@$$J0YAMM@Z"(float %22) #3
  %add75 = add i64 %call, 80
  %arrayidx76 = getelementptr inbounds float, float* %b, i64 %add75
  store float %call73, float* %arrayidx76, align 4, !tbaa !8
  %23 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC00B333340000000, float 0x404F8E4E00000000)
  %24 = tail call float @llvm.fmuladd.f32(float %div, float 0xC0D197A0C0000000, float %23)
  %call80 = tail call float @"?exp@@$$J0YAMM@Z"(float %24) #3
  %add82 = add i64 %call, 88
  %arrayidx83 = getelementptr inbounds float, float* %b, i64 %add82
  store float %call80, float* %arrayidx83, align 4, !tbaa !8
  %25 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC01E8F5C20000000, float 0x4057EF6C60000000)
  %26 = tail call float @llvm.fmuladd.f32(float %div, float 0xC0B7644740000000, float %25)
  %call87 = tail call float @"?exp@@$$J0YAMM@Z"(float %26) #3
  %add89 = add i64 %call, 96
  %arrayidx90 = getelementptr inbounds float, float* %b, i64 %add89
  store float %call87, float* %arrayidx90, align 4, !tbaa !8
  %27 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC00EE147A0000000, float 0x40515A7F60000000)
  %28 = tail call float @llvm.fmuladd.f32(float %div, float 0xC09A1AB7A0000000, float %27)
  %call94 = tail call float @"?exp@@$$J0YAMM@Z"(float %28) #3
  %add96 = add i64 %call, 104
  %arrayidx97 = getelementptr inbounds float, float* %b, i64 %add96
  store float %call94, float* %arrayidx97, align 4, !tbaa !8
  %29 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC027E147A0000000, float 0x4060E00CC0000000)
  %30 = tail call float @llvm.fmuladd.f32(float %div, float 0xC0B3345380000000, float %29)
  %call101 = tail call float @"?exp@@$$J0YAMM@Z"(float %30) #3
  %add103 = add i64 %call, 112
  %arrayidx104 = getelementptr inbounds float, float* %b, i64 %add103
  store float %call101, float* %arrayidx104, align 4, !tbaa !8
  %31 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC01D3020C0000000, float 0x4056DCC440000000)
  %32 = tail call float @llvm.fmuladd.f32(float %div, float 0xC0A27A3CA0000000, float %31)
  %call108 = tail call float @"?exp@@$$J0YAMM@Z"(float %32) #3
  %add110 = add i64 %call, 120
  %arrayidx111 = getelementptr inbounds float, float* %b, i64 %add110
  store float %call108, float* %arrayidx111, align 4, !tbaa !8
  %33 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC0229EB860000000, float 0x405D44CF80000000)
  %34 = tail call float @llvm.fmuladd.f32(float %div, float 0xC0E88966E0000000, float %33)
  %call115 = tail call float @"?exp@@$$J0YAMM@Z"(float %34) #3
  %add117 = add i64 %call, 128
  %arrayidx118 = getelementptr inbounds float, float* %b, i64 %add117
  store float %call115, float* %arrayidx118, align 4, !tbaa !8
  %35 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC01E7AE140000000, float 0x4058390460000000)
  %36 = tail call float @llvm.fmuladd.f32(float %div, float 0xC0AB66D720000000, float %35)
  %call122 = tail call float @"?exp@@$$J0YAMM@Z"(float %36) #3
  %add124 = add i64 %call, 136
  %arrayidx125 = getelementptr inbounds float, float* %b, i64 %add124
  store float %call122, float* %arrayidx125, align 4, !tbaa !8
  %37 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC01C51EB80000000, float 0x4057C60620000000)
  %38 = tail call float @llvm.fmuladd.f32(float %div, float 0xC0AA4801C0000000, float %37)
  %call129 = tail call float @"?exp@@$$J0YAMM@Z"(float %38) #3
  %add131 = add i64 %call, 144
  %arrayidx132 = getelementptr inbounds float, float* %b, i64 %add131
  store float %call129, float* %arrayidx132, align 4, !tbaa !8
  %39 = tail call float @llvm.fmuladd.f32(float %call1, float -1.200000e+01, float 0x40614E16E0000000)
  %40 = tail call float @llvm.fmuladd.f32(float %div, float 0xC0A7763160000000, float %39)
  %call136 = tail call float @"?exp@@$$J0YAMM@Z"(float %40) #3
  %add138 = add i64 %call, 152
  %arrayidx139 = getelementptr inbounds float, float* %b, i64 %add138
  store float %call136, float* %arrayidx139, align 4, !tbaa !8
  %41 = tail call float @llvm.fmuladd.f32(float %call1, float 0xC01AA3D700000000, float 0x4056554640000000)
  %42 = tail call float @llvm.fmuladd.f32(float %div, float 0xC0AB850880000000, float %41)
  %call143 = tail call float @"?exp@@$$J0YAMM@Z"(float %42) #3
  %add145 = add i64 %call, 160
  %arrayidx146 = getelementptr inbounds float, float* %b, i64 %add145
  store float %call143, float* %arrayidx146, align 4, !tbaa !8
  ret void
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_global_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: convergent nounwind readnone
declare dso_local float @"?log@@$$J0YAMM@Z"(float) local_unnamed_addr #1

; Function Attrs: convergent nounwind readnone
declare dso_local float @"?exp@@$$J0YAMM@Z"(float) local_unnamed_addr #1

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
!4 = !{i32 1, i32 1, i32 0}
!5 = !{!"none", !"none", !"none"}
!6 = !{!"float*", !"float*", !"float"}
!7 = !{!"const", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = !{float 2.500000e+00}
