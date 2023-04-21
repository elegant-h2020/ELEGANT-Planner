; ModuleID = './kernels/kernels/parboil-0.2-bfs-BFS_kernel.cl'
source_filename = "./kernels/kernels/parboil-0.2-bfs-BFS_kernel.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent norecurse nounwind uwtable
define dso_local spir_kernel void @A(i32* nocapture readonly %a, i32* nocapture %b, <2 x float>* nocapture readonly %c, <2 x float>* nocapture readonly %d, i32* %e, i32* %f, i32* %g, i32 %h, i32 %i, i32 %j, i32* %k, i32* nocapture %l, i32* nocapture %m) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !7 !kernel_arg_type_qual !8 {
entry:
  %call = tail call i64 @"?get_local_id@@$$J0YAKI@Z"(i32 0) #3
  %cmp = icmp eq i64 %call, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 0, i32* %k, align 4, !tbaa !9
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 1) #4
  %call1 = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #3
  %conv = trunc i64 %call1 to i32
  %cmp2 = icmp slt i32 %conv, %h
  br i1 %cmp2, label %if.then4, label %if.end43

if.then4:                                         ; preds = %if.end
  %sext101 = shl i64 %call1, 32
  %idxprom = ashr exact i64 %sext101, 32
  %arrayidx = getelementptr inbounds i32, i32* %a, i64 %idxprom
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !9
  %idxprom5 = sext i32 %0 to i64
  %arrayidx6 = getelementptr inbounds i32, i32* %e, i64 %idxprom5
  store i32 16677221, i32* %arrayidx6, align 4, !tbaa !9
  %arrayidx8 = getelementptr inbounds i32, i32* %f, i64 %idxprom5
  %1 = load i32, i32* %arrayidx8, align 4, !tbaa !9
  %arrayidx10 = getelementptr inbounds <2 x float>, <2 x float>* %c, i64 %idxprom5
  %2 = load <2 x float>, <2 x float>* %arrayidx10, align 8, !tbaa !13
  %3 = extractelement <2 x float> %2, i64 0
  %conv11 = fptosi float %3 to i32
  %conv12106 = sitofp i32 %conv11 to float
  %shift = shufflevector <2 x float> %2, <2 x float> undef, <2 x i32> <i32 1, i32 undef>
  %4 = fadd <2 x float> %shift, %2
  %add = extractelement <2 x float> %4, i64 0
  %cmp13107 = fcmp ogt float %add, %conv12106
  br i1 %cmp13107, label %for.body.preheader, label %if.end43

for.body.preheader:                               ; preds = %if.then4
  %5 = sext i32 %conv11 to i64
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %if.end42
  %indvars.iv = phi i64 [ %5, %for.body.preheader ], [ %indvars.iv.next, %if.end42 ]
  %arrayidx16 = getelementptr inbounds <2 x float>, <2 x float>* %d, i64 %indvars.iv
  %6 = load <2 x float>, <2 x float>* %arrayidx16, align 8, !tbaa !13
  %7 = extractelement <2 x float> %6, i64 0
  %conv17 = fptosi float %7 to i32
  %8 = extractelement <2 x float> %6, i64 1
  %conv18 = fptosi float %8 to i32
  %add19 = add nsw i32 %1, %conv18
  %idxprom20 = sext i32 %conv17 to i64
  %arrayidx21 = getelementptr inbounds i32, i32* %f, i64 %idxprom20
  %call22 = tail call i32 @"?atom_min@@$$J0YAHPEAU?$_ASCLglobal@$$CCH@__clang@@H@Z"(i32* %arrayidx21, i32 %add19) #4
  %cmp23 = icmp sgt i32 %call22, %add19
  br i1 %cmp23, label %if.then25, label %if.end42

if.then25:                                        ; preds = %for.body
  %arrayidx27 = getelementptr inbounds i32, i32* %e, i64 %idxprom20
  %9 = load i32, i32* %arrayidx27, align 4, !tbaa !9
  %cmp28 = icmp sgt i32 %9, 16677216
  br i1 %cmp28, label %if.then30, label %if.end42

if.then30:                                        ; preds = %if.then25
  %call33 = tail call i32 @"?atom_xchg@@$$J0YAHPEAU?$_ASCLglobal@$$CCH@__clang@@H@Z"(i32* nonnull %arrayidx27, i32 %i) #4
  %cmp34.not = icmp eq i32 %call33, %i
  br i1 %cmp34.not, label %if.end42, label %if.then36

if.then36:                                        ; preds = %if.then30
  %call37 = tail call i32 @"?atom_add@@$$J0YAHPEAU?$_ASCLlocal@$$CCH@__clang@@H@Z"(i32* %k, i32 1) #4
  %idxprom38 = sext i32 %call37 to i64
  %arrayidx39 = getelementptr inbounds i32, i32* %l, i64 %idxprom38
  store i32 %conv17, i32* %arrayidx39, align 4, !tbaa !9
  br label %if.end42

if.end42:                                         ; preds = %if.then30, %if.then36, %if.then25, %for.body
  %indvars.iv.next = add i64 %indvars.iv, 1
  %10 = trunc i64 %indvars.iv.next to i32
  %conv12 = sitofp i32 %10 to float
  %cmp13 = fcmp ogt float %add, %conv12
  br i1 %cmp13, label %for.body, label %if.end43

if.end43:                                         ; preds = %if.end42, %if.then4, %if.end
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 1) #4
  br i1 %cmp, label %if.then47, label %if.end49

if.then47:                                        ; preds = %if.end43
  %11 = load i32, i32* %k, align 4, !tbaa !9
  %call48 = tail call i32 @"?atom_add@@$$J0YAHPEAU?$_ASCLglobal@$$CCH@__clang@@H@Z"(i32* %g, i32 %11) #4
  store i32 %call48, i32* %m, align 4, !tbaa !9
  br label %if.end49

if.end49:                                         ; preds = %if.then47, %if.end43
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 1) #4
  %z.0102 = trunc i64 %call to i32
  %12 = load i32, i32* %k, align 4, !tbaa !9
  %cmp52103 = icmp sgt i32 %12, %z.0102
  br i1 %cmp52103, label %while.body.lr.ph, label %while.end

while.body.lr.ph:                                 ; preds = %if.end49
  %call59 = tail call i64 @"?get_local_size@@$$J0YAKI@Z"(i32 0) #3
  br label %while.body

while.body:                                       ; preds = %while.body.lr.ph, %while.body
  %z.0105 = phi i32 [ %z.0102, %while.body.lr.ph ], [ %z.0, %while.body ]
  %z.0.in104 = phi i64 [ %call, %while.body.lr.ph ], [ %add61, %while.body ]
  %sext = shl i64 %z.0.in104, 32
  %idxprom54 = ashr exact i64 %sext, 32
  %arrayidx55 = getelementptr inbounds i32, i32* %l, i64 %idxprom54
  %13 = load i32, i32* %arrayidx55, align 4, !tbaa !9
  %14 = load i32, i32* %m, align 4, !tbaa !9
  %add56 = add nsw i32 %14, %z.0105
  %idxprom57 = sext i32 %add56 to i64
  %arrayidx58 = getelementptr inbounds i32, i32* %b, i64 %idxprom57
  store i32 %13, i32* %arrayidx58, align 4, !tbaa !9
  %add61 = add i64 %call59, %idxprom54
  %z.0 = trunc i64 %add61 to i32
  %15 = load i32, i32* %k, align 4, !tbaa !9
  %cmp52 = icmp sgt i32 %15, %z.0
  br i1 %cmp52, label %while.body, label %while.end

while.end:                                        ; preds = %while.body, %if.end49
  ret void
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_local_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local void @"?barrier@@$$J0YAXI@Z"(i32) local_unnamed_addr #2

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_global_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: convergent
declare dso_local i32 @"?atom_min@@$$J0YAHPEAU?$_ASCLglobal@$$CCH@__clang@@H@Z"(i32*, i32) local_unnamed_addr #2

; Function Attrs: convergent
declare dso_local i32 @"?atom_xchg@@$$J0YAHPEAU?$_ASCLglobal@$$CCH@__clang@@H@Z"(i32*, i32) local_unnamed_addr #2

; Function Attrs: convergent
declare dso_local i32 @"?atom_add@@$$J0YAHPEAU?$_ASCLlocal@$$CCH@__clang@@H@Z"(i32*, i32) local_unnamed_addr #2

; Function Attrs: convergent
declare dso_local i32 @"?atom_add@@$$J0YAHPEAU?$_ASCLglobal@$$CCH@__clang@@H@Z"(i32*, i32) local_unnamed_addr #2

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_local_size@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

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
!4 = !{i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 0, i32 0, i32 0, i32 3, i32 3, i32 3}
!5 = !{!"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none", !"none"}
!6 = !{!"int*", !"int*", !"float2*", !"float2*", !"int*", !"int*", !"int*", !"int", !"int", !"int", !"int*", !"int*", !"int*"}
!7 = !{!"int*", !"int*", !"float __attribute__((ext_vector_type(2)))*", !"float __attribute__((ext_vector_type(2)))*", !"int*", !"int*", !"int*", !"int", !"int", !"int", !"int*", !"int*", !"int*"}
!8 = !{!"", !"", !"", !"", !"", !"", !"", !"", !"", !"", !"", !"", !""}
!9 = !{!10, !10, i64 0}
!10 = !{!"int", !11, i64 0}
!11 = !{!"omnipotent char", !12, i64 0}
!12 = !{!"Simple C/C++ TBAA"}
!13 = !{!11, !11, i64 0}
