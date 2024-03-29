; ModuleID = './kernels/kernels/rodinia-3.1-particlefilter-find_index_kernel.cl'
source_filename = "./kernels/kernels/rodinia-3.1-particlefilter-find_index_kernel.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent norecurse nounwind uwtable
define dso_local spir_kernel void @A(double* nocapture readonly %a, double* nocapture readonly %b, double* nocapture readonly %c, double* nocapture readonly %d, double* nocapture %e, double* nocapture %f, double* nocapture readnone %g, i32 %h) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #3
  %conv = trunc i64 %call to i32
  %cmp = icmp slt i32 %conv, %h
  br i1 %cmp, label %for.cond.preheader, label %if.end21

for.cond.preheader:                               ; preds = %entry
  %cmp240 = icmp sgt i32 %h, 0
  %sext34 = shl i64 %call, 32
  %idxprom4 = ashr exact i64 %sext34, 32
  br i1 %cmp240, label %for.body.lr.ph, label %for.cond._crit_edge

for.body.lr.ph:                                   ; preds = %for.cond.preheader
  %arrayidx5 = getelementptr inbounds double, double* %d, i64 %idxprom4
  %0 = load double, double* %arrayidx5, align 8, !tbaa !8
  %wide.trip.count = zext i32 %h to i64
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.inc
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %for.inc ]
  %arrayidx = getelementptr inbounds double, double* %c, i64 %indvars.iv
  %1 = load double, double* %arrayidx, align 8, !tbaa !8
  %cmp6 = fcmp ult double %1, %0
  br i1 %cmp6, label %for.inc, label %for.end.loopexit

for.inc:                                          ; preds = %for.body
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %for.cond._crit_edge, label %for.body

for.cond._crit_edge:                              ; preds = %for.inc, %for.cond.preheader
  %sub37 = add nsw i32 %h, -1
  br label %for.end

for.end.loopexit:                                 ; preds = %for.body
  %2 = trunc i64 %indvars.iv to i32
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %for.cond._crit_edge
  %3 = phi i32 [ %2, %for.end.loopexit ], [ %sub37, %for.cond._crit_edge ]
  %idxprom13 = sext i32 %3 to i64
  %arrayidx14 = getelementptr inbounds double, double* %a, i64 %idxprom13
  %4 = bitcast double* %arrayidx14 to i64*
  %5 = load i64, i64* %4, align 8, !tbaa !8
  %arrayidx16 = getelementptr inbounds double, double* %e, i64 %idxprom4
  %6 = bitcast double* %arrayidx16 to i64*
  store i64 %5, i64* %6, align 8, !tbaa !8
  %arrayidx18 = getelementptr inbounds double, double* %b, i64 %idxprom13
  %7 = bitcast double* %arrayidx18 to i64*
  %8 = load i64, i64* %7, align 8, !tbaa !8
  %arrayidx20 = getelementptr inbounds double, double* %f, i64 %idxprom4
  %9 = bitcast double* %arrayidx20 to i64*
  store i64 %8, i64* %9, align 8, !tbaa !8
  br label %if.end21

if.end21:                                         ; preds = %for.end, %entry
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 2) #4
  ret void
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_global_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local void @"?barrier@@$$J0YAXI@Z"(i32) local_unnamed_addr #2

attributes #0 = { convergent norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "uniform-work-group-size"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { convergent nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { convergent "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { convergent nounwind readnone }
attributes #4 = { convergent nounwind }

!llvm.module.flags = !{!0, !1}
!opencl.ocl.version = !{!2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 2, i32 0}
!3 = !{!"clang version 12.0.0"}
!4 = !{i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0}
!5 = !{!"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!6 = !{!"double*", !"double*", !"double*", !"double*", !"double*", !"double*", !"double*", !"int"}
!7 = !{!"", !"", !"", !"", !"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"double", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
