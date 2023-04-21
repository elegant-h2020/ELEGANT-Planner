; ModuleID = './kernels/kernels/polybench-gpu-1.0-gramschmidt-gramschmidt_kernel1.cl'
source_filename = "./kernels/kernels/polybench-gpu-1.0-gramschmidt-gramschmidt_kernel1.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(float* nocapture readonly %a, float* nocapture %b, float* nocapture readnone %c, i32 %d, i32 %e, i32 %f) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #3
  %conv = trunc i64 %call to i32
  %cmp = icmp eq i32 %conv, 0
  br i1 %cmp, label %for.cond.preheader, label %if.end

for.cond.preheader:                               ; preds = %entry
  %cmp227 = icmp sgt i32 %e, 0
  br i1 %cmp227, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %for.cond.preheader
  %0 = sext i32 %f to i64
  %1 = sext i32 %d to i64
  %wide.trip.count = zext i32 %e to i64
  %2 = add nsw i64 %wide.trip.count, -1
  %xtraiter = and i64 %wide.trip.count, 3
  %3 = icmp ult i64 %2, 3
  br i1 %3, label %for.end.loopexit.unr-lcssa, label %for.body.preheader.new

for.body.preheader.new:                           ; preds = %for.body.preheader
  %unroll_iter = and i64 %wide.trip.count, 4294967292
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader.new
  %indvars.iv = phi i64 [ 0, %for.body.preheader.new ], [ %indvars.iv.next.3, %for.body ]
  %h.028 = phi float [ 0.000000e+00, %for.body.preheader.new ], [ %19, %for.body ]
  %niter = phi i64 [ %unroll_iter, %for.body.preheader.new ], [ %niter.nsub.3, %for.body ]
  %4 = mul nsw i64 %indvars.iv, %0
  %5 = add nsw i64 %4, %1
  %arrayidx = getelementptr inbounds float, float* %a, i64 %5
  %6 = load float, float* %arrayidx, align 4, !tbaa !8
  %7 = tail call float @llvm.fmuladd.f32(float %6, float %6, float %h.028)
  %indvars.iv.next = or i64 %indvars.iv, 1
  %8 = mul nsw i64 %indvars.iv.next, %0
  %9 = add nsw i64 %8, %1
  %arrayidx.1 = getelementptr inbounds float, float* %a, i64 %9
  %10 = load float, float* %arrayidx.1, align 4, !tbaa !8
  %11 = tail call float @llvm.fmuladd.f32(float %10, float %10, float %7)
  %indvars.iv.next.1 = or i64 %indvars.iv, 2
  %12 = mul nsw i64 %indvars.iv.next.1, %0
  %13 = add nsw i64 %12, %1
  %arrayidx.2 = getelementptr inbounds float, float* %a, i64 %13
  %14 = load float, float* %arrayidx.2, align 4, !tbaa !8
  %15 = tail call float @llvm.fmuladd.f32(float %14, float %14, float %11)
  %indvars.iv.next.2 = or i64 %indvars.iv, 3
  %16 = mul nsw i64 %indvars.iv.next.2, %0
  %17 = add nsw i64 %16, %1
  %arrayidx.3 = getelementptr inbounds float, float* %a, i64 %17
  %18 = load float, float* %arrayidx.3, align 4, !tbaa !8
  %19 = tail call float @llvm.fmuladd.f32(float %18, float %18, float %15)
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv, 4
  %niter.nsub.3 = add i64 %niter, -4
  %niter.ncmp.3 = icmp eq i64 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %for.end.loopexit.unr-lcssa, label %for.body

for.end.loopexit.unr-lcssa:                       ; preds = %for.body, %for.body.preheader
  %.lcssa.ph = phi float [ undef, %for.body.preheader ], [ %19, %for.body ]
  %indvars.iv.unr = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next.3, %for.body ]
  %h.028.unr = phi float [ 0.000000e+00, %for.body.preheader ], [ %19, %for.body ]
  %lcmp.mod.not = icmp eq i64 %xtraiter, 0
  br i1 %lcmp.mod.not, label %for.end, label %for.body.epil

for.body.epil:                                    ; preds = %for.end.loopexit.unr-lcssa, %for.body.epil
  %indvars.iv.epil = phi i64 [ %indvars.iv.next.epil, %for.body.epil ], [ %indvars.iv.unr, %for.end.loopexit.unr-lcssa ]
  %h.028.epil = phi float [ %23, %for.body.epil ], [ %h.028.unr, %for.end.loopexit.unr-lcssa ]
  %epil.iter = phi i64 [ %epil.iter.sub, %for.body.epil ], [ %xtraiter, %for.end.loopexit.unr-lcssa ]
  %20 = mul nsw i64 %indvars.iv.epil, %0
  %21 = add nsw i64 %20, %1
  %arrayidx.epil = getelementptr inbounds float, float* %a, i64 %21
  %22 = load float, float* %arrayidx.epil, align 4, !tbaa !8
  %23 = tail call float @llvm.fmuladd.f32(float %22, float %22, float %h.028.epil)
  %indvars.iv.next.epil = add nuw nsw i64 %indvars.iv.epil, 1
  %epil.iter.sub = add i64 %epil.iter, -1
  %epil.iter.cmp.not = icmp eq i64 %epil.iter.sub, 0
  br i1 %epil.iter.cmp.not, label %for.end, label %for.body.epil, !llvm.loop !12

for.end:                                          ; preds = %for.end.loopexit.unr-lcssa, %for.body.epil, %for.cond.preheader
  %h.0.lcssa = phi float [ 0.000000e+00, %for.cond.preheader ], [ %.lcssa.ph, %for.end.loopexit.unr-lcssa ], [ %23, %for.body.epil ]
  %call9 = tail call float @"?sqrt@@$$J0YAMM@Z"(float %h.0.lcssa) #3
  %mul10 = mul nsw i32 %f, %d
  %add11 = add nsw i32 %mul10, %d
  %idxprom12 = sext i32 %add11 to i64
  %arrayidx13 = getelementptr inbounds float, float* %b, i64 %idxprom12
  store float %call9, float* %arrayidx13, align 4, !tbaa !8
  br label %if.end

if.end:                                           ; preds = %for.end, %entry
  ret void
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_global_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone speculatable willreturn
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: convergent nounwind readnone
declare dso_local float @"?sqrt@@$$J0YAMM@Z"(float) local_unnamed_addr #1

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
!4 = !{i32 1, i32 1, i32 1, i32 0, i32 0, i32 0}
!5 = !{!"none", !"none", !"none", !"none", !"none", !"none"}
!6 = !{!"float*", !"float*", !"float*", !"int", !"int", !"int"}
!7 = !{!"", !"", !"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = distinct !{!12, !13}
!13 = !{!"llvm.loop.unroll.disable"}
