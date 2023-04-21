; ModuleID = './kernels/kernels/polybench-gpu-1.0-covariance-covar_kernel.cl'
source_filename = "./kernels/kernels/polybench-gpu-1.0-covariance-covar_kernel.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(float* nocapture %a, float* nocapture readonly %b, i32 %c, i32 %d) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #3
  %0 = trunc i64 %call to i32
  %conv = add i32 %0, 1
  %cmp = icmp sgt i32 %conv, 0
  br i1 %cmp, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %entry
  %add2 = add i32 %c, 1
  %cmp3.not = icmp sgt i32 %conv, %c
  br i1 %cmp3.not, label %if.end, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %land.lhs.true
  %mul = mul nsw i32 %conv, %add2
  %cmp12.not74 = icmp slt i32 %d, 1
  %1 = sext i32 %add2 to i64
  %2 = zext i32 %conv to i64
  %3 = add i32 %d, 1
  %4 = sext i32 %mul to i64
  %wide.trip.count = zext i32 %3 to i64
  %5 = add nsw i64 %wide.trip.count, -1
  %xtraiter = and i64 %5, 1
  %6 = icmp eq i32 %3, 2
  %unroll_iter = and i64 %5, -2
  %lcmp.mod.not = icmp eq i64 %xtraiter, 0
  br label %for.body

for.body:                                         ; preds = %for.body.lr.ph, %for.end
  %indvars.iv82 = phi i64 [ %2, %for.body.lr.ph ], [ %indvars.iv.next83, %for.end ]
  %7 = add nsw i64 %indvars.iv82, %4
  %arrayidx = getelementptr inbounds float, float* %a, i64 %7
  store float 0.000000e+00, float* %arrayidx, align 4, !tbaa !8
  br i1 %cmp12.not74, label %for.end, label %for.body14.preheader

for.body14.preheader:                             ; preds = %for.body
  br i1 %6, label %for.end.loopexit.unr-lcssa, label %for.body14

for.body14:                                       ; preds = %for.body14.preheader, %for.body14
  %8 = phi float [ %20, %for.body14 ], [ 0.000000e+00, %for.body14.preheader ]
  %indvars.iv = phi i64 [ %indvars.iv.next.1, %for.body14 ], [ 1, %for.body14.preheader ]
  %niter = phi i64 [ %niter.nsub.1, %for.body14 ], [ %unroll_iter, %for.body14.preheader ]
  %9 = mul nsw i64 %indvars.iv, %1
  %10 = add nsw i64 %9, %2
  %arrayidx19 = getelementptr inbounds float, float* %b, i64 %10
  %11 = load float, float* %arrayidx19, align 4, !tbaa !8
  %12 = add nsw i64 %9, %indvars.iv82
  %arrayidx24 = getelementptr inbounds float, float* %b, i64 %12
  %13 = load float, float* %arrayidx24, align 4, !tbaa !8
  %14 = tail call float @llvm.fmuladd.f32(float %11, float %13, float %8)
  store float %14, float* %arrayidx, align 4, !tbaa !8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %15 = mul nsw i64 %indvars.iv.next, %1
  %16 = add nsw i64 %15, %2
  %arrayidx19.1 = getelementptr inbounds float, float* %b, i64 %16
  %17 = load float, float* %arrayidx19.1, align 4, !tbaa !8
  %18 = add nsw i64 %15, %indvars.iv82
  %arrayidx24.1 = getelementptr inbounds float, float* %b, i64 %18
  %19 = load float, float* %arrayidx24.1, align 4, !tbaa !8
  %20 = tail call float @llvm.fmuladd.f32(float %17, float %19, float %14)
  store float %20, float* %arrayidx, align 4, !tbaa !8
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2
  %niter.nsub.1 = add i64 %niter, -2
  %niter.ncmp.1 = icmp eq i64 %niter.nsub.1, 0
  br i1 %niter.ncmp.1, label %for.end.loopexit.unr-lcssa, label %for.body14

for.end.loopexit.unr-lcssa:                       ; preds = %for.body14, %for.body14.preheader
  %.lcssa.ph = phi float [ undef, %for.body14.preheader ], [ %20, %for.body14 ]
  %.unr = phi float [ 0.000000e+00, %for.body14.preheader ], [ %20, %for.body14 ]
  %indvars.iv.unr = phi i64 [ 1, %for.body14.preheader ], [ %indvars.iv.next.1, %for.body14 ]
  br i1 %lcmp.mod.not, label %for.end.loopexit, label %for.body14.epil

for.body14.epil:                                  ; preds = %for.end.loopexit.unr-lcssa
  %21 = mul nsw i64 %indvars.iv.unr, %1
  %22 = add nsw i64 %21, %2
  %arrayidx19.epil = getelementptr inbounds float, float* %b, i64 %22
  %23 = load float, float* %arrayidx19.epil, align 4, !tbaa !8
  %24 = add nsw i64 %21, %indvars.iv82
  %arrayidx24.epil = getelementptr inbounds float, float* %b, i64 %24
  %25 = load float, float* %arrayidx24.epil, align 4, !tbaa !8
  %26 = tail call float @llvm.fmuladd.f32(float %23, float %25, float %.unr)
  store float %26, float* %arrayidx, align 4, !tbaa !8
  br label %for.end.loopexit

for.end.loopexit:                                 ; preds = %for.end.loopexit.unr-lcssa, %for.body14.epil
  %.lcssa = phi float [ %.lcssa.ph, %for.end.loopexit.unr-lcssa ], [ %26, %for.body14.epil ]
  %27 = bitcast float %.lcssa to i32
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %for.body
  %28 = phi i32 [ %27, %for.end.loopexit ], [ 0, %for.body ]
  %29 = mul nsw i64 %indvars.iv82, %1
  %30 = add nsw i64 %29, %2
  %arrayidx40 = getelementptr inbounds float, float* %a, i64 %30
  %31 = bitcast float* %arrayidx40 to i32*
  store i32 %28, i32* %31, align 4, !tbaa !8
  %indvars.iv.next83 = add nuw nsw i64 %indvars.iv82, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next83 to i32
  %exitcond87.not = icmp eq i32 %add2, %lftr.wideiv
  br i1 %exitcond87.not, label %if.end, label %for.body

if.end:                                           ; preds = %for.end, %land.lhs.true, %entry
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
!4 = !{i32 1, i32 1, i32 0, i32 0}
!5 = !{!"none", !"none", !"none", !"none"}
!6 = !{!"float*", !"float*", !"int", !"int"}
!7 = !{!"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
