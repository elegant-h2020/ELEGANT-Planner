; ModuleID = './kernels/kernels/rodinia-3.1-leukocyte-dilate_kernel.cl'
source_filename = "./kernels/kernels/rodinia-3.1-leukocyte-dilate_kernel.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(i32 %a, i32 %b, i32 %c, i32 %d, float* nocapture readonly %e, float* nocapture readonly %f, float* nocapture %g) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %div.neg = sdiv i32 %c, -2
  %div1.neg = sdiv i32 %d, -2
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #2
  %conv = trunc i64 %call to i32
  %rem = srem i32 %conv, %a
  %div2 = sdiv i32 %conv, %a
  %cmp4 = icmp slt i32 %div2, %b
  br i1 %cmp4, label %for.cond.preheader, label %cleanup

for.cond.preheader:                               ; preds = %entry
  %cmp796 = icmp sgt i32 %c, 0
  br i1 %cmp796, label %for.body.lr.ph, label %for.end42

for.body.lr.ph:                                   ; preds = %for.cond.preheader
  %sub = add i32 %rem, %div.neg
  %cmp1592 = icmp slt i32 %d, 1
  %sub18 = add i32 %div2, %div1.neg
  %0 = sext i32 %sub18 to i64
  %1 = sext i32 %a to i64
  %2 = sext i32 %b to i64
  %3 = sext i32 %sub to i64
  %4 = sext i32 %d to i64
  %wide.trip.count110 = zext i32 %c to i64
  %wide.trip.count = zext i32 %d to i64
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.inc40
  %indvars.iv106 = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next107, %for.inc40 ]
  %m.0100 = phi float [ 0.000000e+00, %for.body.lr.ph ], [ %m.4, %for.inc40 ]
  %5 = add nsw i64 %indvars.iv106, %3
  %cmp9 = icmp slt i64 %5, 0
  %cmp11 = icmp sge i64 %5, %1
  %or.cond.not = or i1 %cmp9, %cmp11
  %brmerge = or i1 %or.cond.not, %cmp1592
  br i1 %brmerge, label %for.inc40, label %for.body17.lr.ph

for.body17.lr.ph:                                 ; preds = %for.body
  %6 = mul nsw i64 %indvars.iv106, %4
  br label %for.body17

for.body17:                                       ; preds = %for.body17.lr.ph, %for.inc
  %indvars.iv = phi i64 [ 0, %for.body17.lr.ph ], [ %indvars.iv.next, %for.inc ]
  %m.195 = phi float [ %m.0100, %for.body17.lr.ph ], [ %m.3, %for.inc ]
  %7 = add nsw i64 %indvars.iv, %0
  %cmp20 = icmp sgt i64 %7, -1
  %cmp23 = icmp slt i64 %7, %2
  %or.cond90 = and i1 %cmp20, %cmp23
  br i1 %or.cond90, label %land.lhs.true25, label %for.inc

land.lhs.true25:                                  ; preds = %for.body17
  %8 = add nsw i64 %indvars.iv, %6
  %arrayidx = getelementptr inbounds float, float* %e, i64 %8
  %9 = load float, float* %arrayidx, align 4, !tbaa !8
  %cmp27 = fcmp une float %9, 0.000000e+00
  br i1 %cmp27, label %if.then29, label %for.inc

if.then29:                                        ; preds = %land.lhs.true25
  %10 = mul nsw i64 %7, %1
  %11 = add nsw i64 %10, %5
  %arrayidx33 = getelementptr inbounds float, float* %f, i64 %11
  %12 = load float, float* %arrayidx33, align 4, !tbaa !8
  %cmp34 = fcmp ogt float %12, %m.195
  %m.2 = select i1 %cmp34, float %12, float %m.195
  br label %for.inc

for.inc:                                          ; preds = %if.then29, %for.body17, %land.lhs.true25
  %m.3 = phi float [ %m.195, %land.lhs.true25 ], [ %m.195, %for.body17 ], [ %m.2, %if.then29 ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %for.inc40, label %for.body17

for.inc40:                                        ; preds = %for.inc, %for.body
  %m.4 = phi float [ %m.0100, %for.body ], [ %m.3, %for.inc ]
  %indvars.iv.next107 = add nuw nsw i64 %indvars.iv106, 1
  %exitcond111.not = icmp eq i64 %indvars.iv.next107, %wide.trip.count110
  br i1 %exitcond111.not, label %for.end42, label %for.body

for.end42:                                        ; preds = %for.inc40, %for.cond.preheader
  %m.0.lcssa = phi float [ 0.000000e+00, %for.cond.preheader ], [ %m.4, %for.inc40 ]
  %mul43 = mul nsw i32 %rem, %b
  %add44 = add nsw i32 %mul43, %div2
  %idxprom45 = sext i32 %add44 to i64
  %arrayidx46 = getelementptr inbounds float, float* %g, i64 %idxprom45
  store float %m.0.lcssa, float* %arrayidx46, align 4, !tbaa !8
  br label %cleanup

cleanup:                                          ; preds = %for.end42, %entry
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
!4 = !{i32 0, i32 0, i32 0, i32 0, i32 2, i32 1, i32 1}
!5 = !{!"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!6 = !{!"int", !"int", !"int", !"int", !"float*", !"float*", !"float*"}
!7 = !{!"", !"", !"", !"", !"const", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
