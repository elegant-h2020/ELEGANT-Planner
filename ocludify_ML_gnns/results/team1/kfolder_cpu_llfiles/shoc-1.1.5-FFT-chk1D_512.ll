; ModuleID = './kernels/kernels/shoc-1.1.5-FFT-chk1D_512.cl'
source_filename = "./kernels/kernels/shoc-1.1.5-FFT-chk1D_512.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent norecurse nounwind uwtable
define dso_local spir_kernel void @A(<2 x float>* nocapture readonly %a, i32 %b, i32* nocapture %c) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !7 !kernel_arg_type_qual !8 {
entry:
  %call = tail call i64 @"?get_local_id@@$$J0YAKI@Z"(i32 0) #2
  %call1 = tail call i64 @"?get_group_id@@$$J0YAKI@Z"(i32 0) #2
  %mul = shl i64 %call1, 9
  %add = add i64 %mul, %call
  %sext = shl i64 %add, 32
  %idx.ext = ashr exact i64 %sext, 32
  %add.ptr = getelementptr inbounds <2 x float>, <2 x float>* %a, i64 %idx.ext
  %0 = load <2 x float>, <2 x float>* %add.ptr, align 8, !tbaa !9
  %arrayidx.1 = getelementptr inbounds <2 x float>, <2 x float>* %add.ptr, i64 64
  %1 = load <2 x float>, <2 x float>* %arrayidx.1, align 8, !tbaa !9
  %arrayidx.2 = getelementptr inbounds <2 x float>, <2 x float>* %add.ptr, i64 128
  %2 = load <2 x float>, <2 x float>* %arrayidx.2, align 8, !tbaa !9
  %arrayidx.3 = getelementptr inbounds <2 x float>, <2 x float>* %add.ptr, i64 192
  %3 = load <2 x float>, <2 x float>* %arrayidx.3, align 8, !tbaa !9
  %arrayidx.4 = getelementptr inbounds <2 x float>, <2 x float>* %add.ptr, i64 256
  %4 = load <2 x float>, <2 x float>* %arrayidx.4, align 8, !tbaa !9
  %arrayidx.5 = getelementptr inbounds <2 x float>, <2 x float>* %add.ptr, i64 320
  %5 = load <2 x float>, <2 x float>* %arrayidx.5, align 8, !tbaa !9
  %arrayidx.6 = getelementptr inbounds <2 x float>, <2 x float>* %add.ptr, i64 384
  %6 = load <2 x float>, <2 x float>* %arrayidx.6, align 8, !tbaa !9
  %arrayidx.7 = getelementptr inbounds <2 x float>, <2 x float>* %add.ptr, i64 448
  %7 = load <2 x float>, <2 x float>* %arrayidx.7, align 8, !tbaa !9
  %8 = sext i32 %b to i64
  %arrayidx15 = getelementptr inbounds <2 x float>, <2 x float>* %add.ptr, i64 %8
  %9 = load <2 x float>, <2 x float>* %arrayidx15, align 8, !tbaa !9
  %10 = add nsw i64 %8, 64
  %arrayidx15.1 = getelementptr inbounds <2 x float>, <2 x float>* %add.ptr, i64 %10
  %11 = load <2 x float>, <2 x float>* %arrayidx15.1, align 8, !tbaa !9
  %12 = add nsw i64 %8, 128
  %arrayidx15.2 = getelementptr inbounds <2 x float>, <2 x float>* %add.ptr, i64 %12
  %13 = load <2 x float>, <2 x float>* %arrayidx15.2, align 8, !tbaa !9
  %14 = add nsw i64 %8, 192
  %arrayidx15.3 = getelementptr inbounds <2 x float>, <2 x float>* %add.ptr, i64 %14
  %15 = load <2 x float>, <2 x float>* %arrayidx15.3, align 8, !tbaa !9
  %16 = add nsw i64 %8, 256
  %arrayidx15.4 = getelementptr inbounds <2 x float>, <2 x float>* %add.ptr, i64 %16
  %17 = load <2 x float>, <2 x float>* %arrayidx15.4, align 8, !tbaa !9
  %18 = add nsw i64 %8, 320
  %arrayidx15.5 = getelementptr inbounds <2 x float>, <2 x float>* %add.ptr, i64 %18
  %19 = load <2 x float>, <2 x float>* %arrayidx15.5, align 8, !tbaa !9
  %20 = add nsw i64 %8, 384
  %arrayidx15.6 = getelementptr inbounds <2 x float>, <2 x float>* %add.ptr, i64 %20
  %21 = load <2 x float>, <2 x float>* %arrayidx15.6, align 8, !tbaa !9
  %22 = add nsw i64 %8, 448
  %arrayidx15.7 = getelementptr inbounds <2 x float>, <2 x float>* %add.ptr, i64 %22
  %23 = load <2 x float>, <2 x float>* %arrayidx15.7, align 8, !tbaa !9
  %24 = extractelement <2 x float> %0, i64 0
  %25 = extractelement <2 x float> %9, i64 0
  %cmp29 = fcmp une float %24, %25
  br i1 %cmp29, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %26 = fcmp une <2 x float> %0, %9
  %cmp35 = extractelement <2 x i1> %26, i64 1
  br i1 %cmp35, label %if.then, label %for.inc37

if.then:                                          ; preds = %lor.lhs.false, %entry
  store i32 1, i32* %c, align 4, !tbaa !12
  br label %for.inc37

for.inc37:                                        ; preds = %lor.lhs.false, %if.then
  %27 = extractelement <2 x float> %1, i64 0
  %28 = extractelement <2 x float> %11, i64 0
  %cmp29.1 = fcmp une float %27, %28
  br i1 %cmp29.1, label %if.then.1, label %lor.lhs.false.1

lor.lhs.false.1:                                  ; preds = %for.inc37
  %29 = fcmp une <2 x float> %1, %11
  %cmp35.1 = extractelement <2 x i1> %29, i64 1
  br i1 %cmp35.1, label %if.then.1, label %for.inc37.1

if.then.1:                                        ; preds = %lor.lhs.false.1, %for.inc37
  store i32 1, i32* %c, align 4, !tbaa !12
  br label %for.inc37.1

for.inc37.1:                                      ; preds = %if.then.1, %lor.lhs.false.1
  %30 = extractelement <2 x float> %2, i64 0
  %31 = extractelement <2 x float> %13, i64 0
  %cmp29.2 = fcmp une float %30, %31
  br i1 %cmp29.2, label %if.then.2, label %lor.lhs.false.2

lor.lhs.false.2:                                  ; preds = %for.inc37.1
  %32 = fcmp une <2 x float> %2, %13
  %cmp35.2 = extractelement <2 x i1> %32, i64 1
  br i1 %cmp35.2, label %if.then.2, label %for.inc37.2

if.then.2:                                        ; preds = %lor.lhs.false.2, %for.inc37.1
  store i32 1, i32* %c, align 4, !tbaa !12
  br label %for.inc37.2

for.inc37.2:                                      ; preds = %if.then.2, %lor.lhs.false.2
  %33 = extractelement <2 x float> %3, i64 0
  %34 = extractelement <2 x float> %15, i64 0
  %cmp29.3 = fcmp une float %33, %34
  br i1 %cmp29.3, label %if.then.3, label %lor.lhs.false.3

lor.lhs.false.3:                                  ; preds = %for.inc37.2
  %35 = fcmp une <2 x float> %3, %15
  %cmp35.3 = extractelement <2 x i1> %35, i64 1
  br i1 %cmp35.3, label %if.then.3, label %for.inc37.3

if.then.3:                                        ; preds = %lor.lhs.false.3, %for.inc37.2
  store i32 1, i32* %c, align 4, !tbaa !12
  br label %for.inc37.3

for.inc37.3:                                      ; preds = %if.then.3, %lor.lhs.false.3
  %36 = extractelement <2 x float> %4, i64 0
  %37 = extractelement <2 x float> %17, i64 0
  %cmp29.4 = fcmp une float %36, %37
  br i1 %cmp29.4, label %if.then.4, label %lor.lhs.false.4

lor.lhs.false.4:                                  ; preds = %for.inc37.3
  %38 = fcmp une <2 x float> %4, %17
  %cmp35.4 = extractelement <2 x i1> %38, i64 1
  br i1 %cmp35.4, label %if.then.4, label %for.inc37.4

if.then.4:                                        ; preds = %lor.lhs.false.4, %for.inc37.3
  store i32 1, i32* %c, align 4, !tbaa !12
  br label %for.inc37.4

for.inc37.4:                                      ; preds = %if.then.4, %lor.lhs.false.4
  %39 = extractelement <2 x float> %5, i64 0
  %40 = extractelement <2 x float> %19, i64 0
  %cmp29.5 = fcmp une float %39, %40
  br i1 %cmp29.5, label %if.then.5, label %lor.lhs.false.5

lor.lhs.false.5:                                  ; preds = %for.inc37.4
  %41 = fcmp une <2 x float> %5, %19
  %cmp35.5 = extractelement <2 x i1> %41, i64 1
  br i1 %cmp35.5, label %if.then.5, label %for.inc37.5

if.then.5:                                        ; preds = %lor.lhs.false.5, %for.inc37.4
  store i32 1, i32* %c, align 4, !tbaa !12
  br label %for.inc37.5

for.inc37.5:                                      ; preds = %if.then.5, %lor.lhs.false.5
  %42 = extractelement <2 x float> %6, i64 0
  %43 = extractelement <2 x float> %21, i64 0
  %cmp29.6 = fcmp une float %42, %43
  br i1 %cmp29.6, label %if.then.6, label %lor.lhs.false.6

lor.lhs.false.6:                                  ; preds = %for.inc37.5
  %44 = fcmp une <2 x float> %6, %21
  %cmp35.6 = extractelement <2 x i1> %44, i64 1
  br i1 %cmp35.6, label %if.then.6, label %for.inc37.6

if.then.6:                                        ; preds = %lor.lhs.false.6, %for.inc37.5
  store i32 1, i32* %c, align 4, !tbaa !12
  br label %for.inc37.6

for.inc37.6:                                      ; preds = %if.then.6, %lor.lhs.false.6
  %45 = extractelement <2 x float> %7, i64 0
  %46 = extractelement <2 x float> %23, i64 0
  %cmp29.7 = fcmp une float %45, %46
  br i1 %cmp29.7, label %if.then.7, label %lor.lhs.false.7

lor.lhs.false.7:                                  ; preds = %for.inc37.6
  %47 = fcmp une <2 x float> %7, %23
  %cmp35.7 = extractelement <2 x i1> %47, i64 1
  br i1 %cmp35.7, label %if.then.7, label %for.inc37.7

if.then.7:                                        ; preds = %lor.lhs.false.7, %for.inc37.6
  store i32 1, i32* %c, align 4, !tbaa !12
  br label %for.inc37.7

for.inc37.7:                                      ; preds = %if.then.7, %lor.lhs.false.7
  ret void
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_local_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_group_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

attributes #0 = { convergent norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "uniform-work-group-size"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { convergent nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { convergent nounwind readnone }

!llvm.module.flags = !{!0, !1}
!opencl.ocl.version = !{!2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 2}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 2, i32 0}
!3 = !{!"clang version 12.0.0"}
!4 = !{i32 1, i32 0, i32 1}
!5 = !{!"none", !"none", !"none"}
!6 = !{!"float2*", !"int", !"int*"}
!7 = !{!"float __attribute__((ext_vector_type(2)))*", !"int", !"int*"}
!8 = !{!"", !"", !""}
!9 = !{!10, !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = !{!13, !13, i64 0}
!13 = !{!"int", !10, i64 0}
