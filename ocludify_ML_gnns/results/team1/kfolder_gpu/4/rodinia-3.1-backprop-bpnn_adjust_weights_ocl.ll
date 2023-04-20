; ModuleID = './kernels/kernels/rodinia-3.1-backprop-bpnn_adjust_weights_ocl.cl'
source_filename = "./kernels/kernels/rodinia-3.1-backprop-bpnn_adjust_weights_ocl.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent norecurse nounwind uwtable
define dso_local spir_kernel void @A(float* nocapture readonly %a, i32 %b, float* nocapture readonly %c, i32 %d, float* nocapture %e, float* nocapture %f) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_group_id@@$$J0YAKI@Z"(i32 1) #4
  %conv = trunc i64 %call to i32
  %call1 = tail call i64 @"?get_local_id@@$$J0YAKI@Z"(i32 0) #4
  %conv2 = trunc i64 %call1 to i32
  %call3 = tail call i64 @"?get_local_id@@$$J0YAKI@Z"(i32 1) #4
  %conv4 = trunc i64 %call3 to i32
  %add = add nsw i32 %b, 1
  %mul5 = shl i32 %conv, 4
  %reass.add = add i32 %mul5, %conv4
  %reass.mul = mul i32 %reass.add, %add
  %add9 = add i32 %b, 2
  %add10 = add i32 %add9, %conv2
  %add12 = add i32 %add10, %reass.mul
  %add14 = or i32 %mul5, 1
  %add15 = add i32 %add14, %conv4
  %add16 = shl i64 %call1, 32
  %sext = add i64 %add16, 4294967296
  %idxprom = ashr exact i64 %sext, 32
  %arrayidx = getelementptr inbounds float, float* %a, i64 %idxprom
  %0 = load float, float* %arrayidx, align 4, !tbaa !8
  %mul17 = fmul float %0, 0x3FD3333340000000
  %idxprom18 = sext i32 %add15 to i64
  %arrayidx19 = getelementptr inbounds float, float* %c, i64 %idxprom18
  %1 = load float, float* %arrayidx19, align 4, !tbaa !8
  %idxprom21 = sext i32 %add12 to i64
  %arrayidx22 = getelementptr inbounds float, float* %f, i64 %idxprom21
  %2 = load float, float* %arrayidx22, align 4, !tbaa !8
  %mul23 = fmul float %2, 0x3FD3333340000000
  %3 = tail call float @llvm.fmuladd.f32(float %mul17, float %1, float %mul23)
  %arrayidx25 = getelementptr inbounds float, float* %e, i64 %idxprom21
  %4 = load float, float* %arrayidx25, align 4, !tbaa !8
  %add26 = fadd float %4, %3
  store float %add26, float* %arrayidx25, align 4, !tbaa !8
  %5 = load float, float* %arrayidx, align 4, !tbaa !8
  %mul29 = fmul float %5, 0x3FD3333340000000
  %6 = load float, float* %arrayidx19, align 4, !tbaa !8
  %7 = load float, float* %arrayidx22, align 4, !tbaa !8
  %mul35 = fmul float %7, 0x3FD3333340000000
  %8 = tail call float @llvm.fmuladd.f32(float %mul29, float %6, float %mul35)
  store float %8, float* %arrayidx22, align 4, !tbaa !8
  tail call void @"?barrier@@$$J0YAXI@Z"(i32 1) #5
  %9 = or i64 %call3, %call
  %10 = trunc i64 %9 to i32
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %12 = load float, float* %arrayidx, align 4, !tbaa !8
  %arrayidx45 = getelementptr inbounds float, float* %f, i64 %idxprom
  %13 = load float, float* %arrayidx45, align 4, !tbaa !8
  %mul46 = fmul float %13, 0x3FD3333340000000
  %14 = tail call float @llvm.fmuladd.f32(float %12, float 0x3FD3333340000000, float %mul46)
  %arrayidx48 = getelementptr inbounds float, float* %e, i64 %idxprom
  %15 = load float, float* %arrayidx48, align 4, !tbaa !8
  %add49 = fadd float %15, %14
  store float %add49, float* %arrayidx48, align 4, !tbaa !8
  %16 = load float, float* %arrayidx, align 4, !tbaa !8
  %17 = load float, float* %arrayidx45, align 4, !tbaa !8
  %mul55 = fmul float %17, 0x3FD3333340000000
  %18 = tail call float @llvm.fmuladd.f32(float %16, float 0x3FD3333340000000, float %mul55)
  store float %18, float* %arrayidx45, align 4, !tbaa !8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_group_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_local_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: nounwind readnone speculatable willreturn
declare float @llvm.fmuladd.f32(float, float, float) #2

; Function Attrs: convergent
declare dso_local void @"?barrier@@$$J0YAXI@Z"(i32) local_unnamed_addr #3

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
!4 = !{i32 1, i32 0, i32 1, i32 0, i32 1, i32 1}
!5 = !{!"none", !"none", !"none", !"none", !"none", !"none"}
!6 = !{!"float*", !"int", !"float*", !"int", !"float*", !"float*"}
!7 = !{!"", !"", !"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
