; ModuleID = './kernels/kernels/nvidia-4.2-MatVecMul-MatVecMulUncoalesced1.cl'
source_filename = "./kernels/kernels/nvidia-4.2-MatVecMul-MatVecMulUncoalesced1.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(float* nocapture readonly %a, float* nocapture readonly %b, i32 %c, i32 %d, float* nocapture %e) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #3
  %f.032 = trunc i64 %call to i32
  %cmp33 = icmp ult i32 %f.032, %d
  br i1 %cmp33, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %cmp329.not = icmp eq i32 %c, 0
  %call13 = tail call i64 @"?get_global_size@@$$J0YAKI@Z"(i32 0) #3
  %wide.trip.count = zext i32 %c to i64
  %0 = add nsw i64 %wide.trip.count, -1
  %xtraiter = and i64 %wide.trip.count, 3
  %1 = icmp ult i64 %0, 3
  %unroll_iter = and i64 %wide.trip.count, 4294967292
  %lcmp.mod.not = icmp eq i64 %xtraiter, 0
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.cond.cleanup5, %entry
  ret void

for.body:                                         ; preds = %for.body.lr.ph, %for.cond.cleanup5
  %f.035 = phi i32 [ %f.032, %for.body.lr.ph ], [ %f.0, %for.cond.cleanup5 ]
  %f.0.in34 = phi i64 [ %call, %for.body.lr.ph ], [ %add, %for.cond.cleanup5 ]
  %mul = mul i32 %f.035, %c
  %idx.ext = zext i32 %mul to i64
  %add.ptr = getelementptr inbounds float, float* %a, i64 %idx.ext
  br i1 %cmp329.not, label %for.cond.cleanup5, label %for.body6.preheader

for.body6.preheader:                              ; preds = %for.body
  br i1 %1, label %for.cond.cleanup5.loopexit.unr-lcssa, label %for.body6

for.cond.cleanup5.loopexit.unr-lcssa:             ; preds = %for.body6, %for.body6.preheader
  %.lcssa.ph = phi float [ undef, %for.body6.preheader ], [ %16, %for.body6 ]
  %indvars.iv.unr = phi i64 [ 0, %for.body6.preheader ], [ %indvars.iv.next.3, %for.body6 ]
  %h.030.unr = phi float [ 0.000000e+00, %for.body6.preheader ], [ %16, %for.body6 ]
  br i1 %lcmp.mod.not, label %for.cond.cleanup5, label %for.body6.epil

for.body6.epil:                                   ; preds = %for.cond.cleanup5.loopexit.unr-lcssa, %for.body6.epil
  %indvars.iv.epil = phi i64 [ %indvars.iv.next.epil, %for.body6.epil ], [ %indvars.iv.unr, %for.cond.cleanup5.loopexit.unr-lcssa ]
  %h.030.epil = phi float [ %4, %for.body6.epil ], [ %h.030.unr, %for.cond.cleanup5.loopexit.unr-lcssa ]
  %epil.iter = phi i64 [ %epil.iter.sub, %for.body6.epil ], [ %xtraiter, %for.cond.cleanup5.loopexit.unr-lcssa ]
  %arrayidx.epil = getelementptr inbounds float, float* %add.ptr, i64 %indvars.iv.epil
  %2 = load float, float* %arrayidx.epil, align 4, !tbaa !8
  %arrayidx8.epil = getelementptr inbounds float, float* %b, i64 %indvars.iv.epil
  %3 = load float, float* %arrayidx8.epil, align 4, !tbaa !8
  %4 = tail call float @llvm.fmuladd.f32(float %2, float %3, float %h.030.epil)
  %indvars.iv.next.epil = add nuw nsw i64 %indvars.iv.epil, 1
  %epil.iter.sub = add i64 %epil.iter, -1
  %epil.iter.cmp.not = icmp eq i64 %epil.iter.sub, 0
  br i1 %epil.iter.cmp.not, label %for.cond.cleanup5, label %for.body6.epil, !llvm.loop !12

for.cond.cleanup5:                                ; preds = %for.cond.cleanup5.loopexit.unr-lcssa, %for.body6.epil, %for.body
  %h.0.lcssa = phi float [ 0.000000e+00, %for.body ], [ %.lcssa.ph, %for.cond.cleanup5.loopexit.unr-lcssa ], [ %4, %for.body6.epil ]
  %idxprom10 = and i64 %f.0.in34, 4294967295
  %arrayidx11 = getelementptr inbounds float, float* %e, i64 %idxprom10
  store float %h.0.lcssa, float* %arrayidx11, align 4, !tbaa !8
  %add = add i64 %call13, %idxprom10
  %f.0 = trunc i64 %add to i32
  %cmp = icmp ult i32 %f.0, %d
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.body6:                                        ; preds = %for.body6.preheader, %for.body6
  %indvars.iv = phi i64 [ %indvars.iv.next.3, %for.body6 ], [ 0, %for.body6.preheader ]
  %h.030 = phi float [ %16, %for.body6 ], [ 0.000000e+00, %for.body6.preheader ]
  %niter = phi i64 [ %niter.nsub.3, %for.body6 ], [ %unroll_iter, %for.body6.preheader ]
  %arrayidx = getelementptr inbounds float, float* %add.ptr, i64 %indvars.iv
  %5 = load float, float* %arrayidx, align 4, !tbaa !8
  %arrayidx8 = getelementptr inbounds float, float* %b, i64 %indvars.iv
  %6 = load float, float* %arrayidx8, align 4, !tbaa !8
  %7 = tail call float @llvm.fmuladd.f32(float %5, float %6, float %h.030)
  %indvars.iv.next = or i64 %indvars.iv, 1
  %arrayidx.1 = getelementptr inbounds float, float* %add.ptr, i64 %indvars.iv.next
  %8 = load float, float* %arrayidx.1, align 4, !tbaa !8
  %arrayidx8.1 = getelementptr inbounds float, float* %b, i64 %indvars.iv.next
  %9 = load float, float* %arrayidx8.1, align 4, !tbaa !8
  %10 = tail call float @llvm.fmuladd.f32(float %8, float %9, float %7)
  %indvars.iv.next.1 = or i64 %indvars.iv, 2
  %arrayidx.2 = getelementptr inbounds float, float* %add.ptr, i64 %indvars.iv.next.1
  %11 = load float, float* %arrayidx.2, align 4, !tbaa !8
  %arrayidx8.2 = getelementptr inbounds float, float* %b, i64 %indvars.iv.next.1
  %12 = load float, float* %arrayidx8.2, align 4, !tbaa !8
  %13 = tail call float @llvm.fmuladd.f32(float %11, float %12, float %10)
  %indvars.iv.next.2 = or i64 %indvars.iv, 3
  %arrayidx.3 = getelementptr inbounds float, float* %add.ptr, i64 %indvars.iv.next.2
  %14 = load float, float* %arrayidx.3, align 4, !tbaa !8
  %arrayidx8.3 = getelementptr inbounds float, float* %b, i64 %indvars.iv.next.2
  %15 = load float, float* %arrayidx8.3, align 4, !tbaa !8
  %16 = tail call float @llvm.fmuladd.f32(float %14, float %15, float %13)
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv, 4
  %niter.nsub.3 = add i64 %niter, -4
  %niter.ncmp.3 = icmp eq i64 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %for.cond.cleanup5.loopexit.unr-lcssa, label %for.body6
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_global_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone speculatable willreturn
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_global_size@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

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
!4 = !{i32 1, i32 1, i32 0, i32 0, i32 1}
!5 = !{!"none", !"none", !"none", !"none", !"none"}
!6 = !{!"float*", !"float*", !"uint", !"uint", !"float*"}
!7 = !{!"const", !"const", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = distinct !{!12, !13}
!13 = !{!"llvm.loop.unroll.disable"}
