; ModuleID = './kernels/kernels/npb-3.3-CG-conj_grad_0.cl'
source_filename = "./kernels/kernels/npb-3.3-CG-conj_grad_0.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(double* nocapture %a, double* nocapture %b, double* nocapture %c, double* nocapture readonly %d, double* nocapture %e) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #2
  %conv = trunc i64 %call to i32
  %cmp = icmp sgt i32 %conv, 128
  br i1 %cmp, label %cleanup, label %if.end

if.end:                                           ; preds = %entry
  %sext = shl i64 %call, 32
  %idxprom = ashr exact i64 %sext, 32
  %arrayidx = getelementptr inbounds double, double* %a, i64 %idxprom
  store double 0.000000e+00, double* %arrayidx, align 8, !tbaa !8
  %arrayidx3 = getelementptr inbounds double, double* %b, i64 %idxprom
  store double 0.000000e+00, double* %arrayidx3, align 8, !tbaa !8
  %arrayidx5 = getelementptr inbounds double, double* %d, i64 %idxprom
  %0 = bitcast double* %arrayidx5 to i64*
  %1 = load i64, i64* %0, align 8, !tbaa !8
  %arrayidx7 = getelementptr inbounds double, double* %c, i64 %idxprom
  %2 = bitcast double* %arrayidx7 to i64*
  store i64 %1, i64* %2, align 8, !tbaa !8
  %arrayidx9 = getelementptr inbounds double, double* %e, i64 %idxprom
  %3 = bitcast double* %arrayidx9 to i64*
  store i64 %1, i64* %3, align 8, !tbaa !8
  br label %cleanup

cleanup:                                          ; preds = %entry, %if.end
  ret void
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_global_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

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
!4 = !{i32 1, i32 1, i32 1, i32 1, i32 1}
!5 = !{!"none", !"none", !"none", !"none", !"none"}
!6 = !{!"double*", !"double*", !"double*", !"double*", !"double*"}
!7 = !{!"", !"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"double", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
