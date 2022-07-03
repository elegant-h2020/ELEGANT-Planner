; ModuleID = './kernels/kernels/rodinia-3.1-pathfinder-dynproc_kernel.cl'
source_filename = "./kernels/kernels/rodinia-3.1-pathfinder-dynproc_kernel.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent norecurse nounwind uwtable
define dso_local spir_kernel void @A(i32 %a, i32* nocapture readonly %b, i32* nocapture readonly %c, i32* nocapture %d, i32 %e, i32 %f, i32 %g, i32 %h, i32 %i, i32* nocapture %j, i32* nocapture %k, i32* nocapture %l) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_local_size@@$$J0YAKI@Z"(i32 0) #3
  %conv = trunc i64 %call to i32
  %call1 = tail call i64 @"?get_group_id@@$$J0YAKI@Z"(i32 0) #3
  %conv2 = trunc i64 %call1 to i32
  %call3 = tail call i64 @"?get_local_id@@$$J0YAKI@Z"(i32 0) #3
  %conv4 = trunc i64 %call3 to i32
  %mul = mul i32 %a, -2
  %mul5.neg = mul i32 %mul, %i
  %sub = add i32 %mul5.neg, %conv
  %mul6 = mul nsw i32 %sub, %conv2
  %sub7 = sub nsw i32 %mul6, %h
  %add = add nsw i32 %sub7, %conv
  %add9 = add nsw i32 %sub7, %conv4
  %cmp = icmp slt i32 %sub7, 0
  %sub11 = sub nsw i32 0, %sub7
  %cond = select i1 %cmp, i32 %sub11, i32 0
  %cmp13 = icmp sgt i32 %add, %e
  %sub16 = add nsw i32 %conv, -1
  %add18.neg = sub i32 %e, %add
  %sub19 = select i1 %cmp13, i32 %add18.neg, i32 0
  %cond23 = add i32 %sub16, %sub19
  %sub24 = add nsw i32 %conv4, -1
  %add25 = add nsw i32 %conv4, 1
  %cmp26.not = icmp slt i32 %cond, %conv4
  %cond31 = select i1 %cmp26.not, i32 %sub24, i32 %cond
  %cmp32.not = icmp sgt i32 %cond23, %conv4
  %cond37 = select i1 %cmp32.not, i32 %add25, i32 %cond23
  %cmp38.not = icmp sgt i32 %cond, %conv4
  %cmp40 = icmp slt i32 %cond23, %conv4
  %cmp42 = icmp sgt i32 %add9, -1
  %cmp45.not.not = icmp slt i32 %add9, %e
  %or.cond197 = and i1 %cmp42, %cmp45.not.not
  br i1 %or.cond197, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %idxprom198 = zext i32 %add9 to i64
  %arrayidx = getelementptr inbounds i32, i32* %c, i64 %idxprom198
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !8
  %sext196 = shl i64 %call3, 32
  %idxprom47 = ashr exact i64 %sext196, 32
  %arrayidx48 = getelementptr inbounds i32, i32* %j, i64 %idxprom47
  store i32 %0, i32* %arrayidx48, align 4, !tbaa !8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 1) #4
  %cmp49199 = icmp sgt i32 %a, 0
  br i1 %cmp49199, label %for.body.lr.ph, label %if.end118

for.body.lr.ph:                                   ; preds = %if.end
  %sub55 = add i32 %conv, -2
  %.not = or i1 %cmp38.not, %cmp40
  %idxprom62 = sext i32 %cond31 to i64
  %arrayidx63 = getelementptr inbounds i32, i32* %j, i64 %idxprom62
  %sext195 = shl i64 %call3, 32
  %idxprom64 = ashr exact i64 %sext195, 32
  %arrayidx65 = getelementptr inbounds i32, i32* %j, i64 %idxprom64
  %idxprom66 = sext i32 %cond37 to i64
  %arrayidx67 = getelementptr inbounds i32, i32* %j, i64 %idxprom66
  %arrayidx87 = getelementptr inbounds i32, i32* %k, i64 %idxprom64
  %cmp88 = icmp eq i32 %conv4, 11
  %idxprom94 = sext i32 %add9 to i64
  %arrayidx95 = getelementptr inbounds i32, i32* %c, i64 %idxprom94
  %sub100 = add nsw i32 %a, -1
  %sext206 = shl i64 %call3, 32
  %1 = ashr exact i64 %sext206, 32
  %2 = sext i32 %g to i64
  %3 = sext i32 %e to i64
  %4 = zext i32 %sub100 to i64
  br label %for.body

for.body:                                         ; preds = %if.end111, %for.body.lr.ph
  %indvars.iv = phi i64 [ 0, %for.body.lr.ph ], [ %indvars.iv.next, %if.end111 ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %cmp52.not.not = icmp slt i64 %indvars.iv, %1
  br i1 %cmp52.not.not, label %land.lhs.true54, label %if.end99

land.lhs.true54:                                  ; preds = %for.body
  %5 = trunc i64 %indvars.iv to i32
  %sub56 = sub i32 %sub55, %5
  %cmp57.not = icmp slt i32 %sub56, %conv4
  %brmerge = or i1 %.not, %cmp57.not
  br i1 %brmerge, label %if.end99, label %if.then61

if.then61:                                        ; preds = %land.lhs.true54
  %6 = load i32, i32* %arrayidx63, align 4, !tbaa !8
  %7 = load i32, i32* %arrayidx65, align 4, !tbaa !8
  %8 = load i32, i32* %arrayidx67, align 4, !tbaa !8
  %cmp68.not = icmp sgt i32 %6, %7
  %cond73 = select i1 %cmp68.not, i32 %7, i32 %6
  %cmp74.not = icmp sgt i32 %cond73, %8
  %cond79 = select i1 %cmp74.not, i32 %8, i32 %cond73
  %9 = add nsw i64 %indvars.iv, %2
  %10 = mul nsw i64 %9, %3
  %11 = add nsw i64 %10, %idxprom94
  %arrayidx84 = getelementptr inbounds i32, i32* %b, i64 %11
  %12 = load i32, i32* %arrayidx84, align 4, !tbaa !8
  %add85 = add nsw i32 %cond79, %12
  store i32 %add85, i32* %arrayidx87, align 4, !tbaa !8
  %cmp91 = icmp eq i64 %indvars.iv, 0
  %or.cond = and i1 %cmp88, %cmp91
  br i1 %or.cond, label %if.then93, label %if.end99

if.then93:                                        ; preds = %if.then61
  %13 = load i32, i32* %arrayidx95, align 4, !tbaa !8
  %idxprom96 = sext i32 %13 to i64
  %arrayidx97 = getelementptr inbounds i32, i32* %l, i64 %idxprom96
  store i32 1, i32* %arrayidx97, align 4, !tbaa !8
  br label %if.end99

if.end99:                                         ; preds = %if.then61, %if.then93, %land.lhs.true54, %for.body
  %tobool105.not = phi i1 [ true, %land.lhs.true54 ], [ true, %for.body ], [ false, %if.then93 ], [ false, %if.then61 ]
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 1) #4
  %cmp101 = icmp eq i64 %indvars.iv, %4
  br i1 %cmp101, label %cleanup, label %if.end104

if.end104:                                        ; preds = %if.end99
  br i1 %tobool105.not, label %if.end111, label %if.then106

if.then106:                                       ; preds = %if.end104
  %14 = load i32, i32* %arrayidx87, align 4, !tbaa !8
  store i32 %14, i32* %arrayidx65, align 4, !tbaa !8
  br label %if.end111

if.end111:                                        ; preds = %if.then106, %if.end104
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 1) #4
  br label %for.body

cleanup:                                          ; preds = %if.end99
  br i1 %tobool105.not, label %if.end118, label %if.then113

if.then113:                                       ; preds = %cleanup
  %sext = shl i64 %call3, 32
  %idxprom114 = ashr exact i64 %sext, 32
  %arrayidx115 = getelementptr inbounds i32, i32* %k, i64 %idxprom114
  %15 = load i32, i32* %arrayidx115, align 4, !tbaa !8
  %idxprom116 = sext i32 %add9 to i64
  %arrayidx117 = getelementptr inbounds i32, i32* %d, i64 %idxprom116
  store i32 %15, i32* %arrayidx117, align 4, !tbaa !8
  br label %if.end118

if.end118:                                        ; preds = %if.end, %if.then113, %cleanup
  ret void
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_local_size@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_group_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_local_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

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
!4 = !{i32 0, i32 1, i32 1, i32 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 3, i32 3, i32 1}
!5 = !{!"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!6 = !{!"int", !"int*", !"int*", !"int*", !"int", !"int", !"int", !"int", !"int", !"int*", !"int*", !"int*"}
!7 = !{!"", !"", !"", !"", !"", !"", !"", !"", !"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"int", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
