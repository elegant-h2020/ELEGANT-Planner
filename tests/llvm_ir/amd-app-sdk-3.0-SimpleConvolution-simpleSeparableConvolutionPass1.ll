; ModuleID = './kernels/kernels/amd-app-sdk-3.0-SimpleConvolution-simpleSeparableConvolutionPass1.cl'
source_filename = "./kernels/kernels/amd-app-sdk-3.0-SimpleConvolution-simpleSeparableConvolutionPass1.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(i32* nocapture readonly %a, float* nocapture readonly %b, float* nocapture %c, <2 x i32> %d, i32 %e, <2 x i32> %f) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !7 !kernel_arg_type_qual !8 {
entry:
  %0 = extractelement <2 x i32> %d, i64 0
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #2
  %conv = trunc i64 %call to i32
  %rem = urem i32 %conv, %0
  %div = udiv i32 %conv, %0
  %1 = extractelement <2 x i32> %d, i64 1
  %add = add i32 %e, -1
  %sub = add i32 %add, %1
  %cmp2.not = icmp ult i32 %div, %sub
  br i1 %cmp2.not, label %for.cond.preheader, label %cleanup

for.cond.preheader:                               ; preds = %entry
  %add5 = add i32 %rem, %e
  %cmp647 = icmp ult i32 %rem, %add5
  br i1 %cmp647, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %for.cond.preheader
  %2 = extractelement <2 x i32> %f, i64 0
  %mul = mul i32 %div, %2
  %3 = zext i32 %rem to i64
  %wide.trip.count = zext i32 %e to i64
  br label %for.body

for.cond.cleanup:                                 ; preds = %for.body, %for.cond.preheader
  %n.0.lcssa = phi float [ 0.000000e+00, %for.cond.preheader ], [ %call12, %for.body ]
  %4 = extractelement <2 x i32> %f, i64 1
  %mul14 = mul i32 %rem, %4
  %add15 = add i32 %mul14, %div
  %idxprom16 = zext i32 %add15 to i64
  %arrayidx17 = getelementptr inbounds float, float* %c, i64 %idxprom16
  store float %n.0.lcssa, float* %arrayidx17, align 4, !tbaa !9
  br label %cleanup

for.body:                                         ; preds = %for.body.lr.ph, %for.body
  %indvars.iv51 = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next52, %for.body ]
  %indvars.iv = phi i64 [ %3, %for.body.lr.ph ], [ %indvars.iv.next, %for.body ]
  %n.049 = phi float [ 0.000000e+00, %for.body.lr.ph ], [ %call12, %for.body ]
  %indvars.iv.next52 = add nuw nsw i64 %indvars.iv51, 1
  %arrayidx = getelementptr inbounds float, float* %b, i64 %indvars.iv51
  %5 = load float, float* %arrayidx, align 4, !tbaa !9
  %6 = trunc i64 %indvars.iv to i32
  %add8 = add i32 %mul, %6
  %idxprom9 = zext i32 %add8 to i64
  %arrayidx10 = getelementptr inbounds i32, i32* %a, i64 %idxprom9
  %7 = load i32, i32* %arrayidx10, align 4, !tbaa !13
  %conv11 = uitofp i32 %7 to float
  %call12 = tail call float @"?mad@@$$J0YAMMMM@Z"(float %conv11, float %5, float %n.049) #2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next52, %wide.trip.count
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body

cleanup:                                          ; preds = %entry, %for.cond.cleanup
  ret void
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_global_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: convergent nounwind readnone
declare dso_local float @"?mad@@$$J0YAMMMM@Z"(float, float, float) local_unnamed_addr #1

attributes #0 = { convergent nofree norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="64" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "uniform-work-group-size"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { convergent nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { convergent nounwind readnone }

!llvm.module.flags = !{!0, !1}
!opencl.ocl.version = !{!2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 2, i32 0}
!3 = !{!"clang version 12.0.0"}
!4 = !{i32 1, i32 1, i32 1, i32 0, i32 0, i32 0}
!5 = !{!"none", !"none", !"none", !"none", !"none", !"none"}
!6 = !{!"uint*", !"float*", !"float*", !"uint2", !"uint", !"uint2"}
!7 = !{!"uint*", !"float*", !"float*", !"uint __attribute__((ext_vector_type(2)))", !"uint", !"uint __attribute__((ext_vector_type(2)))"}
!8 = !{!"", !"", !"", !"", !"", !""}
!9 = !{!10, !10, i64 0}
!10 = !{!"float", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = !{!14, !14, i64 0}
!14 = !{!"int", !11, i64 0}
