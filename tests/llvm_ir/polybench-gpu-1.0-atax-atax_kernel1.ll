; ModuleID = './kernels/kernels/polybench-gpu-1.0-atax-atax_kernel1.cl'
source_filename = "./kernels/kernels/polybench-gpu-1.0-atax-atax_kernel1.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(float* nocapture readonly %a, float* nocapture readonly %b, float* nocapture %c, i32 %d, i32 %e) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #3
  %conv = trunc i64 %call to i32
  %cmp = icmp slt i32 %conv, %d
  %cmp217 = icmp sgt i32 %e, 0
  %or.cond = and i1 %cmp, %cmp217
  br i1 %or.cond, label %for.body.lr.ph, label %if.end

for.body.lr.ph:                                   ; preds = %entry
  %mul = mul nsw i32 %conv, %e
  %sext = shl i64 %call, 32
  %idxprom7 = ashr exact i64 %sext, 32
  %arrayidx8 = getelementptr inbounds float, float* %c, i64 %idxprom7
  %0 = sext i32 %mul to i64
  %wide.trip.count = zext i32 %e to i64
  %.pre = load float, float* %arrayidx8, align 4, !tbaa !8
  %xtraiter = and i64 %wide.trip.count, 1
  %1 = icmp eq i32 %e, 1
  br i1 %1, label %if.end.loopexit.unr-lcssa, label %for.body.lr.ph.new

for.body.lr.ph.new:                               ; preds = %for.body.lr.ph
  %unroll_iter = and i64 %wide.trip.count, 4294967294
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.lr.ph.new
  %2 = phi float [ %.pre, %for.body.lr.ph.new ], [ %10, %for.body ]
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph.new ], [ %indvars.iv.next.1, %for.body ]
  %niter = phi i64 [ %unroll_iter, %for.body.lr.ph.new ], [ %niter.nsub.1, %for.body ]
  %3 = add nsw i64 %indvars.iv, %0
  %arrayidx = getelementptr inbounds float, float* %a, i64 %3
  %4 = load float, float* %arrayidx, align 4, !tbaa !8
  %arrayidx5 = getelementptr inbounds float, float* %b, i64 %indvars.iv
  %5 = load float, float* %arrayidx5, align 4, !tbaa !8
  %6 = tail call float @llvm.fmuladd.f32(float %4, float %5, float %2)
  store float %6, float* %arrayidx8, align 4, !tbaa !8
  %indvars.iv.next = or i64 %indvars.iv, 1
  %7 = add nsw i64 %indvars.iv.next, %0
  %arrayidx.1 = getelementptr inbounds float, float* %a, i64 %7
  %8 = load float, float* %arrayidx.1, align 4, !tbaa !8
  %arrayidx5.1 = getelementptr inbounds float, float* %b, i64 %indvars.iv.next
  %9 = load float, float* %arrayidx5.1, align 4, !tbaa !8
  %10 = tail call float @llvm.fmuladd.f32(float %8, float %9, float %6)
  store float %10, float* %arrayidx8, align 4, !tbaa !8
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2
  %niter.nsub.1 = add i64 %niter, -2
  %niter.ncmp.1 = icmp eq i64 %niter.nsub.1, 0
  br i1 %niter.ncmp.1, label %if.end.loopexit.unr-lcssa, label %for.body

if.end.loopexit.unr-lcssa:                        ; preds = %for.body, %for.body.lr.ph
  %.unr = phi float [ %.pre, %for.body.lr.ph ], [ %10, %for.body ]
  %indvars.iv.unr = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next.1, %for.body ]
  %lcmp.mod.not = icmp eq i64 %xtraiter, 0
  br i1 %lcmp.mod.not, label %if.end, label %for.body.epil

for.body.epil:                                    ; preds = %if.end.loopexit.unr-lcssa
  %11 = add nsw i64 %indvars.iv.unr, %0
  %arrayidx.epil = getelementptr inbounds float, float* %a, i64 %11
  %12 = load float, float* %arrayidx.epil, align 4, !tbaa !8
  %arrayidx5.epil = getelementptr inbounds float, float* %b, i64 %indvars.iv.unr
  %13 = load float, float* %arrayidx5.epil, align 4, !tbaa !8
  %14 = tail call float @llvm.fmuladd.f32(float %12, float %13, float %.unr)
  store float %14, float* %arrayidx8, align 4, !tbaa !8
  br label %if.end

if.end:                                           ; preds = %for.body.epil, %if.end.loopexit.unr-lcssa, %entry
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
!4 = !{i32 1, i32 1, i32 1, i32 0, i32 0}
!5 = !{!"none", !"none", !"none", !"none", !"none"}
!6 = !{!"float*", !"float*", !"float*", !"int", !"int"}
!7 = !{!"", !"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
