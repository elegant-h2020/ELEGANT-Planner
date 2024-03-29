; ModuleID = './kernels/kernels/shoc-1.1.5-Sort-reduce.cl'
source_filename = "./kernels/kernels/shoc-1.1.5-Sort-reduce.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent norecurse nounwind uwtable
define dso_local spir_kernel void @A(i32* nocapture readonly %a, i32* nocapture %b, i32 %c, i32* nocapture %d, i32 %e) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %k = alloca [16 x i32], align 16
  %div = sdiv i32 %c, 4
  %conv = sext i32 %div to i64
  %call = tail call i64 @"?get_num_groups@@$$J0YAKI@Z"(i32 0) #5
  %div1 = udiv i64 %conv, %call
  %div1.tr = trunc i64 %div1 to i32
  %conv2 = shl i32 %div1.tr, 2
  %call3 = tail call i64 @"?get_group_id@@$$J0YAKI@Z"(i32 0) #5
  %0 = trunc i64 %call3 to i32
  %conv6 = mul i32 %conv2, %0
  %sub = add i64 %call, -1
  %cmp = icmp eq i64 %call3, %sub
  %add = add nsw i32 %conv6, %conv2
  %cond = select i1 %cmp, i32 %c, i32 %add
  %call10 = tail call i64 @"?get_local_id@@$$J0YAKI@Z"(i32 0) #5
  %conv11 = trunc i64 %call10 to i32
  %add12 = add nsw i32 %conv6, %conv11
  %1 = bitcast [16 x i32]* %k to i8*
  call void @llvm.lifetime.start.p0i8(i64 64, i8* nonnull %1) #6
  call void @llvm.memset.p0i8.i64(i8* nonnull align 16 dereferenceable(64) %1, i8 0, i64 64, i1 false)
  %cmp1388 = icmp slt i32 %add12, %cond
  br i1 %cmp1388, label %while.body.lr.ph, label %for.cond.preheader

while.body.lr.ph:                                 ; preds = %entry
  %shr.mask = and i32 %e, 31
  %call17 = tail call i64 @"?get_local_size@@$$J0YAKI@Z"(i32 0) #5
  %2 = trunc i64 %call17 to i32
  br label %while.body

for.cond.preheader:                               ; preds = %while.body, %entry
  %sext = shl i64 %call10, 32
  %idxprom25 = ashr exact i64 %sext, 32
  %arrayidx26 = getelementptr inbounds i32, i32* %d, i64 %idxprom25
  %cmp44 = icmp eq i32 %conv11, 0
  br label %for.body

while.body:                                       ; preds = %while.body.lr.ph, %while.body
  %j.089 = phi i32 [ %add12, %while.body.lr.ph ], [ %conv20, %while.body ]
  %idxprom = sext i32 %j.089 to i64
  %arrayidx = getelementptr inbounds i32, i32* %a, i64 %idxprom
  %3 = load i32, i32* %arrayidx, align 4, !tbaa !8
  %shr = lshr i32 %3, %shr.mask
  %and = and i32 %shr, 15
  %idxprom15 = zext i32 %and to i64
  %arrayidx16 = getelementptr inbounds [16 x i32], [16 x i32]* %k, i64 0, i64 %idxprom15
  %4 = load i32, i32* %arrayidx16, align 4, !tbaa !8
  %inc = add nsw i32 %4, 1
  store i32 %inc, i32* %arrayidx16, align 4, !tbaa !8
  %conv20 = add i32 %j.089, %2
  %cmp13 = icmp slt i32 %conv20, %cond
  br i1 %cmp13, label %while.body, label %for.cond.preheader

for.cond.cleanup:                                 ; preds = %for.inc55
  call void @llvm.lifetime.end.p0i8(i64 64, i8* nonnull %1) #6
  ret void

for.body:                                         ; preds = %for.cond.preheader, %for.inc55
  %indvars.iv = phi i64 [ 0, %for.cond.preheader ], [ %indvars.iv.next, %for.inc55 ]
  %arrayidx24 = getelementptr inbounds [16 x i32], [16 x i32]* %k, i64 0, i64 %indvars.iv
  %5 = load i32, i32* %arrayidx24, align 4, !tbaa !8
  store i32 %5, i32* %arrayidx26, align 4, !tbaa !8
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 1) #7
  %call27 = tail call i64 @"?get_local_size@@$$J0YAKI@Z"(i32 0) #5
  %div28 = lshr i64 %call27, 1
  %conv29 = trunc i64 %div28 to i32
  %cmp31.not84 = icmp eq i32 %conv29, 0
  br i1 %cmp31.not84, label %for.cond.cleanup33, label %for.body34

for.cond.cleanup33:                               ; preds = %if.end, %for.body
  br i1 %cmp44, label %if.then46, label %for.inc55

for.body34:                                       ; preds = %for.body, %if.end
  %m.085 = phi i32 [ %shr43, %if.end ], [ %conv29, %for.body ]
  %cmp35 = icmp ugt i32 %m.085, %conv11
  br i1 %cmp35, label %if.then, label %if.end

if.then:                                          ; preds = %for.body34
  %add37 = add i32 %m.085, %conv11
  %idxprom38 = zext i32 %add37 to i64
  %arrayidx39 = getelementptr inbounds i32, i32* %d, i64 %idxprom38
  %6 = load i32, i32* %arrayidx39, align 4, !tbaa !8
  %7 = load i32, i32* %arrayidx26, align 4, !tbaa !8
  %add42 = add i32 %7, %6
  store i32 %add42, i32* %arrayidx26, align 4, !tbaa !8
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body34
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 1) #7
  %shr43 = lshr i32 %m.085, 1
  %cmp31.not = icmp eq i32 %shr43, 0
  br i1 %cmp31.not, label %for.cond.cleanup33, label %for.body34

if.then46:                                        ; preds = %for.cond.cleanup33
  %8 = load i32, i32* %d, align 4, !tbaa !8
  %mul50 = mul i64 %call, %indvars.iv
  %add52 = add i64 %mul50, %call3
  %arrayidx53 = getelementptr inbounds i32, i32* %b, i64 %add52
  store i32 %8, i32* %arrayidx53, align 4, !tbaa !8
  br label %for.inc55

for.inc55:                                        ; preds = %for.cond.cleanup33, %if.then46
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 16
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_num_groups@@$$J0YAKI@Z"(i32) local_unnamed_addr #2

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_group_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #2

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_local_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_local_size@@$$J0YAKI@Z"(i32) local_unnamed_addr #2

; Function Attrs: convergent
declare dso_local void @"?barrier@@$$J0YAXI@Z"(i32) local_unnamed_addr #4

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

attributes #0 = { convergent norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "uniform-work-group-size"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { convergent nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind willreturn writeonly }
attributes #4 = { convergent "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { convergent nounwind readnone }
attributes #6 = { nounwind }
attributes #7 = { convergent nounwind }

!llvm.module.flags = !{!0, !1}
!opencl.ocl.version = !{!2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 2, i32 0}
!3 = !{!"clang version 12.0.0"}
!4 = !{i32 1, i32 1, i32 0, i32 3, i32 0}
!5 = !{!"none", !"none", !"none", !"none", !"none"}
!6 = !{!"uint*", !"uint*", !"int", !"uint*", !"int"}
!7 = !{!"const", !"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"int", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
