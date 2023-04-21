; ModuleID = './kernels/kernels/polybench-gpu-1.0-correlation-mean_kernel.cl'
source_filename = "./kernels/kernels/polybench-gpu-1.0-correlation-mean_kernel.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(float* nocapture %a, float* nocapture readonly %b, float %c, i32 %d, i32 %e) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #2
  %0 = trunc i64 %call to i32
  %conv = add i32 %0, 1
  %cmp = icmp sgt i32 %conv, 0
  br i1 %cmp, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %entry
  %add2 = add nsw i32 %d, 1
  %cmp3.not = icmp sgt i32 %conv, %d
  br i1 %cmp3.not, label %if.end, label %if.then

if.then:                                          ; preds = %land.lhs.true
  %idxprom29 = zext i32 %conv to i64
  %arrayidx = getelementptr inbounds float, float* %a, i64 %idxprom29
  store float 0.000000e+00, float* %arrayidx, align 4, !tbaa !8
  %cmp6.not30 = icmp slt i32 %e, 1
  br i1 %cmp6.not30, label %for.end, label %for.body.preheader

for.body.preheader:                               ; preds = %if.then
  %1 = sext i32 %add2 to i64
  %2 = zext i32 %conv to i64
  %3 = zext i32 %e to i64
  %xtraiter = and i64 %3, 1
  %4 = icmp eq i32 %e, 1
  br i1 %4, label %for.end.loopexit.unr-lcssa, label %for.body.preheader.new

for.body.preheader.new:                           ; preds = %for.body.preheader
  %unroll_iter = and i64 %3, 4294967294
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader.new
  %5 = phi float [ 0.000000e+00, %for.body.preheader.new ], [ %add14.1, %for.body ]
  %indvars.iv = phi i64 [ 1, %for.body.preheader.new ], [ %indvars.iv.next.1, %for.body ]
  %niter = phi i64 [ %unroll_iter, %for.body.preheader.new ], [ %niter.nsub.1, %for.body ]
  %6 = mul nsw i64 %indvars.iv, %1
  %7 = add nsw i64 %6, %2
  %arrayidx11 = getelementptr inbounds float, float* %b, i64 %7
  %8 = load float, float* %arrayidx11, align 4, !tbaa !8
  %add14 = fadd float %8, %5
  store float %add14, float* %arrayidx, align 4, !tbaa !8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %9 = mul nsw i64 %indvars.iv.next, %1
  %10 = add nsw i64 %9, %2
  %arrayidx11.1 = getelementptr inbounds float, float* %b, i64 %10
  %11 = load float, float* %arrayidx11.1, align 4, !tbaa !8
  %add14.1 = fadd float %11, %add14
  store float %add14.1, float* %arrayidx, align 4, !tbaa !8
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv, 2
  %niter.nsub.1 = add i64 %niter, -2
  %niter.ncmp.1 = icmp eq i64 %niter.nsub.1, 0
  br i1 %niter.ncmp.1, label %for.end.loopexit.unr-lcssa, label %for.body

for.end.loopexit.unr-lcssa:                       ; preds = %for.body, %for.body.preheader
  %add14.lcssa.ph = phi float [ undef, %for.body.preheader ], [ %add14.1, %for.body ]
  %.unr = phi float [ 0.000000e+00, %for.body.preheader ], [ %add14.1, %for.body ]
  %indvars.iv.unr = phi i64 [ 1, %for.body.preheader ], [ %indvars.iv.next.1, %for.body ]
  %lcmp.mod.not = icmp eq i64 %xtraiter, 0
  br i1 %lcmp.mod.not, label %for.end, label %for.body.epil

for.body.epil:                                    ; preds = %for.end.loopexit.unr-lcssa
  %12 = mul nsw i64 %indvars.iv.unr, %1
  %13 = add nsw i64 %12, %2
  %arrayidx11.epil = getelementptr inbounds float, float* %b, i64 %13
  %14 = load float, float* %arrayidx11.epil, align 4, !tbaa !8
  %add14.epil = fadd float %14, %.unr
  store float %add14.epil, float* %arrayidx, align 4, !tbaa !8
  br label %for.end

for.end:                                          ; preds = %for.body.epil, %for.end.loopexit.unr-lcssa, %if.then
  %15 = phi float [ 0.000000e+00, %if.then ], [ %add14.lcssa.ph, %for.end.loopexit.unr-lcssa ], [ %add14.epil, %for.body.epil ]
  %div = fdiv float %15, %c, !fpmath !12
  store float %div, float* %arrayidx, align 4, !tbaa !8
  br label %if.end

if.end:                                           ; preds = %for.end, %land.lhs.true, %entry
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
!4 = !{i32 1, i32 1, i32 0, i32 0, i32 0}
!5 = !{!"none", !"none", !"none", !"none", !"none"}
!6 = !{!"float*", !"float*", !"float", !"int", !"int"}
!7 = !{!"", !"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = !{float 2.500000e+00}
