; ModuleID = './kernels/kernels/npb-3.3-CG-makea_6.cl'
source_filename = "./kernels/kernels/npb-3.3-CG-makea_6.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(double* nocapture %a, double* nocapture readonly %b, i32* nocapture readonly %c, i32* nocapture %d, i32* nocapture readonly %e, i32 %f, i32 %g) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #2
  %conv = trunc i64 %call to i32
  %cmp.not = icmp slt i32 %conv, %g
  br i1 %cmp.not, label %if.end, label %cleanup

if.end:                                           ; preds = %entry
  %idxprom = sext i32 %f to i64
  %arrayidx = getelementptr inbounds i32, i32* %e, i64 %idxprom
  %cmp2 = icmp sgt i32 %conv, 0
  %sext54 = shl i64 %call, 32
  %idxprom5 = ashr exact i64 %sext54, 32
  br i1 %cmp2, label %if.then4, label %if.end10

if.then4:                                         ; preds = %if.end
  %arrayidx6 = getelementptr inbounds i32, i32* %c, i64 %idxprom5
  %0 = load i32, i32* %arrayidx6, align 4, !tbaa !8
  %sub = add i64 %call, 4294967295
  %1 = and i64 %sub, 4294967295
  %arrayidx8 = getelementptr inbounds i32, i32* %arrayidx, i64 %1
  %2 = load i32, i32* %arrayidx8, align 4, !tbaa !8
  %sub9 = sub nsw i32 %0, %2
  br label %if.end10

if.end10:                                         ; preds = %if.end, %if.then4
  %h.0 = phi i32 [ %sub9, %if.then4 ], [ 0, %if.end ]
  %sext = add i64 %sext54, 4294967296
  %idxprom11 = ashr exact i64 %sext, 32
  %arrayidx12 = getelementptr inbounds i32, i32* %c, i64 %idxprom11
  %3 = load i32, i32* %arrayidx12, align 4, !tbaa !8
  %arrayidx14 = getelementptr inbounds i32, i32* %arrayidx, i64 %idxprom5
  %4 = load i32, i32* %arrayidx14, align 4, !tbaa !8
  %sub15 = sub nsw i32 %3, %4
  %cmp1855 = icmp slt i32 %h.0, %sub15
  br i1 %cmp1855, label %for.body.preheader, label %cleanup

for.body.preheader:                               ; preds = %if.end10
  %arrayidx17 = getelementptr inbounds i32, i32* %c, i64 %idxprom5
  %5 = load i32, i32* %arrayidx17, align 4, !tbaa !8
  %6 = sext i32 %h.0 to i64
  %7 = sext i32 %sub15 to i64
  %8 = sext i32 %5 to i64
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv58 = phi i64 [ %8, %for.body.preheader ], [ %indvars.iv.next59, %for.body ]
  %indvars.iv = phi i64 [ %6, %for.body.preheader ], [ %indvars.iv.next, %for.body ]
  %arrayidx21 = getelementptr inbounds double, double* %b, i64 %indvars.iv58
  %9 = bitcast double* %arrayidx21 to i64*
  %10 = load i64, i64* %9, align 8, !tbaa !12
  %arrayidx23 = getelementptr inbounds double, double* %a, i64 %indvars.iv
  %11 = bitcast double* %arrayidx23 to i64*
  store i64 %10, i64* %11, align 8, !tbaa !12
  %arrayidx25 = getelementptr inbounds i32, i32* %e, i64 %indvars.iv58
  %12 = load i32, i32* %arrayidx25, align 4, !tbaa !8
  %arrayidx27 = getelementptr inbounds i32, i32* %d, i64 %indvars.iv
  store i32 %12, i32* %arrayidx27, align 4, !tbaa !8
  %indvars.iv.next59 = add nsw i64 %indvars.iv58, 1
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %cmp18 = icmp slt i64 %indvars.iv.next, %7
  br i1 %cmp18, label %for.body, label %cleanup

cleanup:                                          ; preds = %for.body, %if.end10, %entry
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
!4 = !{i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 0}
!5 = !{!"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!6 = !{!"double*", !"double*", !"int*", !"int*", !"int*", !"int", !"int"}
!7 = !{!"", !"", !"", !"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"int", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = !{!13, !13, i64 0}
!13 = !{!"double", !10, i64 0}
