; ModuleID = './kernels/kernels/rodinia-3.1-gaussian-Fan1.cl'
source_filename = "./kernels/kernels/rodinia-3.1-gaussian-Fan1.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(float* nocapture %a, float* nocapture readonly %b, float* nocapture readnone %c, i32 %d, i32 %e) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #2
  %conv = trunc i64 %call to i32
  %0 = xor i32 %e, -1
  %sub1 = add i32 %0, %d
  %cmp = icmp sgt i32 %sub1, %conv
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %add = add i32 %e, 1
  %add3 = add i32 %add, %conv
  %mul = mul nsw i32 %add3, %d
  %idx.ext = sext i32 %mul to i64
  %add.ptr = getelementptr inbounds float, float* %b, i64 %idx.ext
  %idx.ext4 = sext i32 %e to i64
  %add.ptr5 = getelementptr inbounds float, float* %add.ptr, i64 %idx.ext4
  %1 = load float, float* %add.ptr5, align 4, !tbaa !8
  %mul6 = mul nsw i32 %e, %d
  %idx.ext7 = sext i32 %mul6 to i64
  %add.ptr8 = getelementptr inbounds float, float* %b, i64 %idx.ext7
  %add.ptr10 = getelementptr inbounds float, float* %add.ptr8, i64 %idx.ext4
  %2 = load float, float* %add.ptr10, align 4, !tbaa !8
  %div = fdiv float %1, %2, !fpmath !12
  %add.ptr15 = getelementptr inbounds float, float* %a, i64 %idx.ext
  %add.ptr17 = getelementptr inbounds float, float* %add.ptr15, i64 %idx.ext4
  store float %div, float* %add.ptr17, align 4, !tbaa !8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
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
!4 = !{i32 1, i32 1, i32 1, i32 0, i32 0}
!5 = !{!"none", !"none", !"none", !"none", !"none"}
!6 = !{!"float*", !"float*", !"float*", !"int", !"int"}
!7 = !{!"", !"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"float", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = !{float 2.500000e+00}
