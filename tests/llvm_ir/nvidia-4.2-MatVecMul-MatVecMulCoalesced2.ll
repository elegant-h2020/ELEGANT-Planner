; ModuleID = './kernels/kernels/nvidia-4.2-MatVecMul-MatVecMulCoalesced2.cl'
source_filename = "./kernels/kernels/nvidia-4.2-MatVecMul-MatVecMulCoalesced2.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent norecurse nounwind uwtable
define dso_local spir_kernel void @A(float* nocapture readonly %a, float* nocapture readonly %b, i32 %c, i32 %d, float* nocapture %e, float* nocapture %f) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_group_id@@$$J0YAKI@Z"(i32 0) #4
  %g.077 = trunc i64 %call to i32
  %cmp78 = icmp ult i32 %g.077, %d
  br i1 %cmp78, label %for.body.lr.ph, label %for.cond.cleanup

for.body.lr.ph:                                   ; preds = %entry
  %call2 = tail call i64 @"?get_local_id@@$$J0YAKI@Z"(i32 0) #4
  %j.071 = trunc i64 %call2 to i32
  %cmp572 = icmp ult i32 %j.071, %c
  %arrayidx16 = getelementptr inbounds float, float* %f, i64 %call2
  %call17 = tail call i64 @"?get_local_size@@$$J0YAKI@Z"(i32 0) #4
  %div = lshr i64 %call17, 1
  %conv18 = trunc i64 %div to i32
  %cmp20.not75 = icmp eq i32 %conv18, 0
  %cmp39 = icmp eq i64 %call2, 0
  %0 = bitcast float* %f to i32*
  br label %for.body

for.cond.cleanup:                                 ; preds = %if.end45, %entry
  ret void

for.body:                                         ; preds = %for.body.lr.ph, %if.end45
  %g.081 = phi i32 [ %g.077, %for.body.lr.ph ], [ %g.0, %if.end45 ]
  %g.0.in79 = phi i64 [ %call, %for.body.lr.ph ], [ %add49, %if.end45 ]
  %mul = mul i32 %g.081, %c
  %idx.ext = zext i32 %mul to i64
  %add.ptr = getelementptr inbounds float, float* %a, i64 %idx.ext
  br i1 %cmp572, label %for.body8, label %for.cond.cleanup7

for.cond.cleanup7:                                ; preds = %for.body8, %for.body
  %i.0.lcssa = phi float [ 0.000000e+00, %for.body ], [ %3, %for.body8 ]
  store float %i.0.lcssa, float* %arrayidx16, align 4, !tbaa !8
  br i1 %cmp20.not75, label %for.cond.cleanup22, label %for.body23

for.body8:                                        ; preds = %for.body, %for.body8
  %j.0.in74 = phi i64 [ %add, %for.body8 ], [ %call2, %for.body ]
  %i.073 = phi float [ %3, %for.body8 ], [ 0.000000e+00, %for.body ]
  %idxprom = and i64 %j.0.in74, 4294967295
  %arrayidx = getelementptr inbounds float, float* %add.ptr, i64 %idxprom
  %1 = load float, float* %arrayidx, align 4, !tbaa !8
  %arrayidx10 = getelementptr inbounds float, float* %b, i64 %idxprom
  %2 = load float, float* %arrayidx10, align 4, !tbaa !8
  %3 = tail call float @llvm.fmuladd.f32(float %1, float %2, float %i.073)
  %add = add i64 %call17, %idxprom
  %j.0 = trunc i64 %add to i32
  %cmp5 = icmp ult i32 %j.0, %c
  br i1 %cmp5, label %for.body8, label %for.cond.cleanup7

for.cond.cleanup22:                               ; preds = %for.inc35, %for.cond.cleanup7
  br i1 %cmp39, label %if.then41, label %for.cond.cleanup22.if.end45_crit_edge

for.cond.cleanup22.if.end45_crit_edge:            ; preds = %for.cond.cleanup22
  %.pre = and i64 %g.0.in79, 4294967295
  br label %if.end45

for.body23:                                       ; preds = %for.cond.cleanup7, %for.inc35
  %k.076 = phi i32 [ %div36, %for.inc35 ], [ %conv18, %for.cond.cleanup7 ]
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 1) #5
  %conv25 = zext i32 %k.076 to i64
  %cmp26 = icmp ult i64 %call2, %conv25
  br i1 %cmp26, label %if.then, label %for.inc35

if.then:                                          ; preds = %for.body23
  %add30 = add i64 %call2, %conv25
  %arrayidx31 = getelementptr inbounds float, float* %f, i64 %add30
  %4 = load float, float* %arrayidx31, align 4, !tbaa !8
  %5 = load float, float* %arrayidx16, align 4, !tbaa !8
  %add34 = fadd float %4, %5
  store float %add34, float* %arrayidx16, align 4, !tbaa !8
  br label %for.inc35

for.inc35:                                        ; preds = %for.body23, %if.then
  %div36 = lshr i32 %k.076, 1
  %cmp20.not = icmp eq i32 %div36, 0
  br i1 %cmp20.not, label %for.cond.cleanup22, label %for.body23

if.then41:                                        ; preds = %for.cond.cleanup22
  %6 = load i32, i32* %0, align 4, !tbaa !8
  %idxprom43 = and i64 %g.0.in79, 4294967295
  %arrayidx44 = getelementptr inbounds float, float* %e, i64 %idxprom43
  %7 = bitcast float* %arrayidx44 to i32*
  store i32 %6, i32* %7, align 4, !tbaa !8
  br label %if.end45

if.end45:                                         ; preds = %for.cond.cleanup22.if.end45_crit_edge, %if.then41
  %conv48.pre-phi = phi i64 [ %.pre, %for.cond.cleanup22.if.end45_crit_edge ], [ %idxprom43, %if.then41 ]
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 1) #5
  %call47 = tail call i64 @"?get_num_groups@@$$J0YAKI@Z"(i32 0) #4
  %add49 = add i64 %call47, %conv48.pre-phi
  %g.0 = trunc i64 %add49 to i32
  %cmp = icmp ult i32 %g.0, %d
  br i1 %cmp, label %for.body, label %for.cond.cleanup
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_group_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_local_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone speculatable willreturn
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_local_size@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local void @"?barrier@@$$J0YAXI@Z"(i32) local_unnamed_addr #3

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_num_groups@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

attributes #0 = { convergent norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "uniform-work-group-size"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { convergent nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable willreturn }
attributes #3 = { convergent "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { convergent nounwind readnone }
attributes #5 = { convergent nounwind }

!llvm.module.flags = !{!0, !1}
!opencl.ocl.version = !{!2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 2, i32 0}
!3 = !{!"clang version 12.0.0"}
!4 = !{i32 1, i32 1, i32 0, i32 0, i32 1, i32 3}
!5 = !{!"none", !"none", !"none", !"none", !"none", !"none"}
!6 = !{!"float*", !"float*", !"uint", !"uint", !"float*", !"float*"}
!7 = !{!"const", !"const", !"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
