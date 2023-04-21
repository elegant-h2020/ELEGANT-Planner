; ModuleID = './kernels/kernels/npb-3.3-CG-main_0.cl'
source_filename = "./kernels/kernels/npb-3.3-CG-main_0.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(i32* nocapture %a, i32* nocapture readonly %b, i32 %c, i32 %d) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #2
  %div = lshr i64 %call, 6
  %call1 = tail call i64 @"?get_local_id@@$$J0YAKI@Z"(i32 0) #2
  %conv2 = trunc i64 %call1 to i32
  %sext = shl i64 %div, 32
  %idxprom = ashr exact i64 %sext, 32
  %arrayidx = getelementptr inbounds i32, i32* %b, i64 %idxprom
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !8
  %sext23 = add i64 %sext, 4294967296
  %idxprom3 = ashr exact i64 %sext23, 32
  %arrayidx4 = getelementptr inbounds i32, i32* %b, i64 %idxprom3
  %1 = load i32, i32* %arrayidx4, align 4, !tbaa !8
  %add5 = add i32 %0, %conv2
  %cmp24 = icmp slt i32 %add5, %1
  br i1 %cmp24, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %2 = sext i32 %add5 to i64
  %3 = sext i32 %1 to i64
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv = phi i64 [ %2, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
  %arrayidx8 = getelementptr inbounds i32, i32* %a, i64 %indvars.iv
  %4 = load i32, i32* %arrayidx8, align 4, !tbaa !8
  %sub = sub nsw i32 %4, %c
  store i32 %sub, i32* %arrayidx8, align 4, !tbaa !8
  %indvars.iv.next = add nsw i64 %indvars.iv, 64
  %cmp = icmp slt i64 %indvars.iv.next, %3
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_global_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_local_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

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
!4 = !{i32 1, i32 1, i32 0, i32 0}
!5 = !{!"none", !"none", !"none", !"none"}
!6 = !{!"int*", !"int*", !"int", !"int"}
!7 = !{!"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"int", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
