; ModuleID = './kernels/kernels/amd-app-sdk-3.0-ScanLargeArrays-prefixSum.cl'
source_filename = "./kernels/kernels/amd-app-sdk-3.0-ScanLargeArrays-prefixSum.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent norecurse nounwind uwtable
define dso_local spir_kernel void @A(float* nocapture %a, float* nocapture readonly %b, float* nocapture %c, i32 %d) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_local_id@@$$J0YAKI@Z"(i32 0) #3
  %conv = trunc i64 %call to i32
  %call1 = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #3
  %conv2 = trunc i64 %call1 to i32
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
  %cmp119 = icmp ugt i32 %d, 1
  br i1 %cmp119, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  %arrayidx16 = getelementptr inbounds float, float* %c, i64 1
  %7 = load float, float* %arrayidx16, align 4, !tbaa !8
  %add17 = fadd float %6, %7
  br label %for.body

for.cond.cleanup:                                 ; preds = %if.end, %entry
  %cmp47 = icmp eq i32 %conv, 0
  br i1 %cmp47, label %if.then49, label %if.else

for.body:                                         ; preds = %for.body.preheader, %if.end
  %j.0122 = phi i32 [ %mul46, %if.end ], [ 1, %for.body.preheader ]
  %i.0121 = phi float [ %i.1, %if.end ], [ %add17, %for.body.preheader ]
  %h.0120 = phi float [ %h.1, %if.end ], [ %6, %for.body.preheader ]
  %cmp20.not = icmp slt i32 %mul5, %j.0122
  br i1 %cmp20.not, label %if.end, label %if.then

if.then:                                          ; preds = %for.body
  %sub = sub nsw i32 %mul5, %j.0122
  %idxprom23 = sext i32 %sub to i64
  %arrayidx24 = getelementptr inbounds float, float* %c, i64 %idxprom23
  %8 = load float, float* %arrayidx24, align 4, !tbaa !8
  %9 = load float, float* %arrayidx7, align 4, !tbaa !8
  %add28 = fadd float %8, %9
  %sub31 = sub nsw i32 %add12, %j.0122
  %idxprom32 = sext i32 %sub31 to i64
  %arrayidx33 = getelementptr inbounds float, float* %c, i64 %idxprom32
  %10 = load float, float* %arrayidx33, align 4, !tbaa !8
  %11 = load float, float* %arrayidx14, align 4, !tbaa !8
  %add38 = fadd float %10, %11
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  %h.1 = phi float [ %add28, %if.then ], [ %h.0120, %for.body ]
  %i.1 = phi float [ %add38, %if.then ], [ %i.0121, %for.body ]
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 1) #4
  store float %h.1, float* %arrayidx7, align 4, !tbaa !8
  store float %i.1, float* %arrayidx14, align 4, !tbaa !8
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 1) #4
  %mul46 = shl nsw i32 %j.0122, 1
  %cmp = icmp ult i32 %mul46, %d
  br i1 %cmp, label %for.body, label %for.cond.cleanup

if.then49:                                        ; preds = %for.cond.cleanup
  %arrayidx52 = getelementptr inbounds float, float* %a, i64 %idxprom
  store float 0.000000e+00, float* %arrayidx52, align 4, !tbaa !8
  br label %if.end74

if.else:                                          ; preds = %for.cond.cleanup
  %sub61 = add nsw i32 %mul5, -1
  %idxprom62 = sext i32 %sub61 to i64
  %arrayidx63 = getelementptr inbounds float, float* %c, i64 %idxprom62
  %12 = bitcast float* %arrayidx63 to i32*
  %13 = load i32, i32* %12, align 4, !tbaa !8
  %arrayidx66 = getelementptr inbounds float, float* %a, i64 %idxprom
  %14 = bitcast float* %arrayidx66 to i32*
  store i32 %13, i32* %14, align 4, !tbaa !8
  br label %if.end74

if.end74:                                         ; preds = %if.else, %if.then49
  %15 = load i32, i32* %2, align 4, !tbaa !8
  %arrayidx73 = getelementptr inbounds float, float* %a, i64 %idxprom9
  %16 = bitcast float* %arrayidx73 to i32*
  store i32 %15, i32* %16, align 4, !tbaa !8
  ret void
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_local_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

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
!4 = !{i32 1, i32 1, i32 3, i32 0}
!5 = !{!"none", !"none", !"none", !"none"}
!6 = !{!"float*", !"float*", !"float*", !"uint"}
!7 = !{!"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
