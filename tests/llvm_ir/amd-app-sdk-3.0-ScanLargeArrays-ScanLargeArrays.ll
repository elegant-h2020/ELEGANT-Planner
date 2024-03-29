; ModuleID = './kernels/kernels/amd-app-sdk-3.0-ScanLargeArrays-ScanLargeArrays.cl'
source_filename = "./kernels/kernels/amd-app-sdk-3.0-ScanLargeArrays-ScanLargeArrays.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent norecurse nounwind uwtable
define dso_local spir_kernel void @A(float* nocapture %a, float* nocapture readonly %b, float* nocapture %c, i32 %d, float* nocapture %e) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_local_id@@$$J0YAKI@Z"(i32 0) #3
  %conv = trunc i64 %call to i32
  %call1 = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #3
  %conv2 = trunc i64 %call1 to i32
  %call3 = tail call i64 @"?get_group_id@@$$J0YAKI@Z"(i32 0) #3
  %mul = shl nsw i32 %conv2, 1
  %idxprom = sext i32 %mul to i64
  %arrayidx = getelementptr inbounds float, float* %b, i64 %idxprom
  %0 = bitcast float* %arrayidx to i32*
  %1 = load i32, i32* %0, align 4, !tbaa !8
  %mul5 = shl nsw i32 %conv, 1
  %idxprom6 = sext i32 %mul5 to i64
  %arrayidx7 = getelementptr inbounds float, float* %c, i64 %idxprom6
  %2 = bitcast float* %arrayidx7 to i32*
  store i32 %1, i32* %2, align 4, !tbaa !8
  %add = or i32 %mul, 1
  %idxprom9 = sext i32 %add to i64
  %arrayidx10 = getelementptr inbounds float, float* %b, i64 %idxprom9
  %3 = bitcast float* %arrayidx10 to i32*
  %4 = load i32, i32* %3, align 4, !tbaa !8
  %add12 = or i32 %mul5, 1
  %idxprom13 = sext i32 %add12 to i64
  %arrayidx14 = getelementptr inbounds float, float* %c, i64 %idxprom13
  %5 = bitcast float* %arrayidx14 to i32*
  store i32 %4, i32* %5, align 4, !tbaa !8
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 1) #4
  %6 = load float, float* %c, align 4, !tbaa !8
  %cmp126 = icmp ugt i32 %d, 1
  br i1 %cmp126, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %arrayidx16 = getelementptr inbounds float, float* %c, i64 1
  %7 = load float, float* %arrayidx16, align 4, !tbaa !8
  %add17 = fadd float %6, %7
  br label %for.body

for.cond.cleanup:                                 ; preds = %if.end, %entry
  %sub47 = add i32 %d, -1
  %idxprom48 = zext i32 %sub47 to i64
  %arrayidx49 = getelementptr inbounds float, float* %c, i64 %idxprom48
  %8 = bitcast float* %arrayidx49 to i32*
  %9 = load i32, i32* %8, align 4, !tbaa !8
  %sext = shl i64 %call3, 32
  %idxprom50 = ashr exact i64 %sext, 32
  %arrayidx51 = getelementptr inbounds float, float* %e, i64 %idxprom50
  %10 = bitcast float* %arrayidx51 to i32*
  store i32 %9, i32* %10, align 4, !tbaa !8
  %cmp52 = icmp eq i32 %conv, 0
  br i1 %cmp52, label %if.then54, label %if.else

for.body:                                         ; preds = %for.body.preheader, %if.end
  %k.0129 = phi i32 [ %mul46, %if.end ], [ 1, %for.body.preheader ]
  %j.0128 = phi float [ %j.1, %if.end ], [ %add17, %for.body.preheader ]
  %i.0127 = phi float [ %i.1, %if.end ], [ %6, %for.body.preheader ]
  %cmp20.not = icmp slt i32 %mul5, %k.0129
  br i1 %cmp20.not, label %if.end, label %if.then

if.then:                                          ; preds = %for.body
  %sub = sub nsw i32 %mul5, %k.0129
  %idxprom23 = sext i32 %sub to i64
  %arrayidx24 = getelementptr inbounds float, float* %c, i64 %idxprom23
  %11 = load float, float* %arrayidx24, align 4, !tbaa !8
  %12 = load float, float* %arrayidx7, align 4, !tbaa !8
  %add28 = fadd float %11, %12
  %sub31 = sub nsw i32 %add12, %k.0129
  %idxprom32 = sext i32 %sub31 to i64
  %arrayidx33 = getelementptr inbounds float, float* %c, i64 %idxprom32
  %13 = load float, float* %arrayidx33, align 4, !tbaa !8
  %14 = load float, float* %arrayidx14, align 4, !tbaa !8
  %add38 = fadd float %13, %14
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %i.1 = phi float [ %add28, %if.then ], [ %i.0127, %for.body ]
  %j.1 = phi float [ %add38, %if.then ], [ %j.0128, %for.body ]
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 1) #4
  store float %i.1, float* %arrayidx7, align 4, !tbaa !8
  store float %j.1, float* %arrayidx14, align 4, !tbaa !8
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 1) #4
  %mul46 = shl nsw i32 %k.0129, 1
  %cmp = icmp ult i32 %mul46, %d
  br i1 %cmp, label %for.body, label %for.cond.cleanup

if.then54:                                        ; preds = %for.cond.cleanup
  %arrayidx57 = getelementptr inbounds float, float* %a, i64 %idxprom
  store float 0.000000e+00, float* %arrayidx57, align 4, !tbaa !8
  br label %if.end79

if.else:                                          ; preds = %for.cond.cleanup
  %sub66 = add nsw i32 %mul5, -1
  %idxprom67 = sext i32 %sub66 to i64
  %arrayidx68 = getelementptr inbounds float, float* %c, i64 %idxprom67
  %15 = bitcast float* %arrayidx68 to i32*
  %16 = load i32, i32* %15, align 4, !tbaa !8
  %arrayidx71 = getelementptr inbounds float, float* %a, i64 %idxprom
  %17 = bitcast float* %arrayidx71 to i32*
  store i32 %16, i32* %17, align 4, !tbaa !8
  br label %if.end79

if.end79:                                         ; preds = %if.else, %if.then54
  %18 = load i32, i32* %2, align 4, !tbaa !8
  %arrayidx78 = getelementptr inbounds float, float* %a, i64 %idxprom9
  %19 = bitcast float* %arrayidx78 to i32*
  store i32 %18, i32* %19, align 4, !tbaa !8
  ret void
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_local_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_global_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_group_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

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
!4 = !{i32 1, i32 1, i32 3, i32 0, i32 1}
!5 = !{!"none", !"none", !"none", !"none", !"none"}
!6 = !{!"float*", !"float*", !"float*", !"uint", !"float*"}
!7 = !{!"", !"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
