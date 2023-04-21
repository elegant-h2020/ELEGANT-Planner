; ModuleID = './kernels/kernels/nvidia-4.2-DotProduct-DotProduct.cl'
source_filename = "./kernels/kernels/nvidia-4.2-DotProduct-DotProduct.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(float* nocapture readonly %a, float* nocapture readonly %b, float* nocapture %c, i32 %d) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #3
  %conv = trunc i64 %call to i32
  %cmp.not = icmp slt i32 %conv, %d
  br i1 %cmp.not, label %if.end, label %cleanup

if.end:                                           ; preds = %entry
  %shl = shl i32 %conv, 2
  %idxprom = sext i32 %shl to i64
  %arrayidx = getelementptr inbounds float, float* %a, i64 %idxprom
  %0 = load float, float* %arrayidx, align 4, !tbaa !8
  %arrayidx3 = getelementptr inbounds float, float* %b, i64 %idxprom
  %1 = load float, float* %arrayidx3, align 4, !tbaa !8
  %add = or i32 %shl, 1
  %idxprom4 = sext i32 %add to i64
  %arrayidx5 = getelementptr inbounds float, float* %a, i64 %idxprom4
  %2 = load float, float* %arrayidx5, align 4, !tbaa !8
  %arrayidx8 = getelementptr inbounds float, float* %b, i64 %idxprom4
  %3 = load float, float* %arrayidx8, align 4, !tbaa !8
  %mul9 = fmul float %2, %3
  %4 = tail call float @llvm.fmuladd.f32(float %0, float %1, float %mul9)
  %add10 = or i32 %shl, 2
  %idxprom11 = sext i32 %add10 to i64
  %arrayidx12 = getelementptr inbounds float, float* %a, i64 %idxprom11
  %5 = load float, float* %arrayidx12, align 4, !tbaa !8
  %arrayidx15 = getelementptr inbounds float, float* %b, i64 %idxprom11
  %6 = load float, float* %arrayidx15, align 4, !tbaa !8
  %7 = tail call float @llvm.fmuladd.f32(float %5, float %6, float %4)
  %add16 = or i32 %shl, 3
  %idxprom17 = sext i32 %add16 to i64
  %arrayidx18 = getelementptr inbounds float, float* %a, i64 %idxprom17
  %8 = load float, float* %arrayidx18, align 4, !tbaa !8
  %arrayidx21 = getelementptr inbounds float, float* %b, i64 %idxprom17
  %9 = load float, float* %arrayidx21, align 4, !tbaa !8
  %10 = tail call float @llvm.fmuladd.f32(float %8, float %9, float %7)
  %sext = shl i64 %call, 32
  %idxprom22 = ashr exact i64 %sext, 32
  %arrayidx23 = getelementptr inbounds float, float* %c, i64 %idxprom22
  store float %10, float* %arrayidx23, align 4, !tbaa !8
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
!4 = !{i32 1, i32 1, i32 1, i32 0}
!5 = !{!"none", !"none", !"none", !"none"}
!6 = !{!"float*", !"float*", !"float*", !"int"}
!7 = !{!"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
