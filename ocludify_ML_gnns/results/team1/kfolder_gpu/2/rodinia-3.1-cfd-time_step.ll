; ModuleID = './kernels/kernels/rodinia-3.1-cfd-time_step.cl'
source_filename = "./kernels/kernels/rodinia-3.1-cfd-time_step.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(i32 %a, i32 %b, float* nocapture readonly %c, float* nocapture %d, float* nocapture readonly %e, float* nocapture readonly %f) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #3
  %conv = trunc i64 %call to i32
  %cmp.not = icmp slt i32 %conv, %b
  br i1 %cmp.not, label %if.end, label %cleanup

if.end:                                           ; preds = %entry
  %sext = shl i64 %call, 32
  %idxprom = ashr exact i64 %sext, 32
  %arrayidx = getelementptr inbounds float, float* %e, i64 %idxprom
  %0 = load float, float* %arrayidx, align 4, !tbaa !8
  %sub = sub nsw i32 4, %a
  %conv2 = sitofp i32 %sub to float
  %div = fdiv float %0, %conv2, !fpmath !12
  %arrayidx4 = getelementptr inbounds float, float* %c, i64 %idxprom
  %1 = load float, float* %arrayidx4, align 4, !tbaa !8
  %arrayidx8 = getelementptr inbounds float, float* %f, i64 %idxprom
  %2 = load float, float* %arrayidx8, align 4, !tbaa !8
  %3 = tail call float @llvm.fmuladd.f32(float %div, float %2, float %1)
  %arrayidx13 = getelementptr inbounds float, float* %d, i64 %idxprom
  store float %3, float* %arrayidx13, align 4, !tbaa !8
  %mul14 = shl nsw i32 %b, 2
  %add15 = add nsw i32 %mul14, %conv
  %idxprom16 = sext i32 %add15 to i64
  %arrayidx17 = getelementptr inbounds float, float* %c, i64 %idxprom16
  %4 = load float, float* %arrayidx17, align 4, !tbaa !8
  %arrayidx21 = getelementptr inbounds float, float* %f, i64 %idxprom16
  %5 = load float, float* %arrayidx21, align 4, !tbaa !8
  %6 = tail call float @llvm.fmuladd.f32(float %div, float %5, float %4)
  %arrayidx26 = getelementptr inbounds float, float* %d, i64 %idxprom16
  store float %6, float* %arrayidx26, align 4, !tbaa !8
  %add28 = add nsw i32 %conv, %b
  %idxprom29 = sext i32 %add28 to i64
  %arrayidx30 = getelementptr inbounds float, float* %c, i64 %idxprom29
  %7 = load float, float* %arrayidx30, align 4, !tbaa !8
  %arrayidx34 = getelementptr inbounds float, float* %f, i64 %idxprom29
  %8 = load float, float* %arrayidx34, align 4, !tbaa !8
  %9 = tail call float @llvm.fmuladd.f32(float %div, float %8, float %7)
  %arrayidx39 = getelementptr inbounds float, float* %d, i64 %idxprom29
  store float %9, float* %arrayidx39, align 4, !tbaa !8
  %mul40 = shl nsw i32 %b, 1
  %add41 = add nsw i32 %mul40, %conv
  %idxprom42 = sext i32 %add41 to i64
  %arrayidx43 = getelementptr inbounds float, float* %c, i64 %idxprom42
  %10 = load float, float* %arrayidx43, align 4, !tbaa !8
  %arrayidx47 = getelementptr inbounds float, float* %f, i64 %idxprom42
  %11 = load float, float* %arrayidx47, align 4, !tbaa !8
  %12 = tail call float @llvm.fmuladd.f32(float %div, float %11, float %10)
  %arrayidx52 = getelementptr inbounds float, float* %d, i64 %idxprom42
  store float %12, float* %arrayidx52, align 4, !tbaa !8
  %mul53 = mul nsw i32 %b, 3
  %add54 = add nsw i32 %mul53, %conv
  %idxprom55 = sext i32 %add54 to i64
  %arrayidx56 = getelementptr inbounds float, float* %c, i64 %idxprom55
  %13 = load float, float* %arrayidx56, align 4, !tbaa !8
  %arrayidx60 = getelementptr inbounds float, float* %f, i64 %idxprom55
  %14 = load float, float* %arrayidx60, align 4, !tbaa !8
  %15 = tail call float @llvm.fmuladd.f32(float %div, float %14, float %13)
  %arrayidx65 = getelementptr inbounds float, float* %d, i64 %idxprom55
  store float %15, float* %arrayidx65, align 4, !tbaa !8
  br label %cleanup

cleanup:                                          ; preds = %entry, %if.end
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
!4 = !{i32 0, i32 0, i32 1, i32 1, i32 1, i32 1}
!5 = !{!"none", !"none", !"none", !"none", !"none", !"none"}
!6 = !{!"int", !"int", !"float*", !"float*", !"float*", !"float*"}
!7 = !{!"", !"", !"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = !{float 2.500000e+00}
