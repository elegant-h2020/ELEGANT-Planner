; ModuleID = './kernels/kernels/npb-3.3-CG-makea_2.cl'
source_filename = "./kernels/kernels/npb-3.3-CG-makea_2.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(i32* nocapture %a, i32* nocapture readonly %b, i32* nocapture readonly %c, i32* nocapture readonly %d) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #2
  %conv = trunc i64 %call to i32
  %call1 = tail call i64 @"?get_global_size@@$$J0YAKI@Z"(i32 0) #2
  %conv2 = trunc i64 %call1 to i32
  %cmp = icmp slt i32 %conv, %conv2
  %cmp455 = icmp sgt i32 %conv, 0
  %or.cond = and i1 %cmp, %cmp455
  br i1 %or.cond, label %for.body.preheader, label %if.end30

for.body.preheader:                               ; preds = %entry
  %wide.trip.count = and i64 %call, 4294967295
  %0 = add nsw i64 %wide.trip.count, -1
  %xtraiter64 = and i64 %call, 7
  %1 = icmp ult i64 %0, 7
  br i1 %1, label %if.end.unr-lcssa, label %for.body.preheader.new

for.body.preheader.new:                           ; preds = %for.body.preheader
  %unroll_iter = sub nsw i64 %wide.trip.count, %xtraiter64
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader.new
  %indvars.iv58 = phi i64 [ 0, %for.body.preheader.new ], [ %indvars.iv.next59.7, %for.body ]
  %g.057 = phi i32 [ 0, %for.body.preheader.new ], [ %add.7, %for.body ]
  %niter = phi i64 [ %unroll_iter, %for.body.preheader.new ], [ %niter.nsub.7, %for.body ]
  %arrayidx = getelementptr inbounds i32, i32* %b, i64 %indvars.iv58
  %2 = load i32, i32* %arrayidx, align 4, !tbaa !8
  %add = add nsw i32 %2, %g.057
  %indvars.iv.next59 = or i64 %indvars.iv58, 1
  %arrayidx.1 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv.next59
  %3 = load i32, i32* %arrayidx.1, align 4, !tbaa !8
  %add.1 = add nsw i32 %3, %add
  %indvars.iv.next59.1 = or i64 %indvars.iv58, 2
  %arrayidx.2 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv.next59.1
  %4 = load i32, i32* %arrayidx.2, align 4, !tbaa !8
  %add.2 = add nsw i32 %4, %add.1
  %indvars.iv.next59.2 = or i64 %indvars.iv58, 3
  %arrayidx.3 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv.next59.2
  %5 = load i32, i32* %arrayidx.3, align 4, !tbaa !8
  %add.3 = add nsw i32 %5, %add.2
  %indvars.iv.next59.3 = or i64 %indvars.iv58, 4
  %arrayidx.4 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv.next59.3
  %6 = load i32, i32* %arrayidx.4, align 4, !tbaa !8
  %add.4 = add nsw i32 %6, %add.3
  %indvars.iv.next59.4 = or i64 %indvars.iv58, 5
  %arrayidx.5 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv.next59.4
  %7 = load i32, i32* %arrayidx.5, align 4, !tbaa !8
  %add.5 = add nsw i32 %7, %add.4
  %indvars.iv.next59.5 = or i64 %indvars.iv58, 6
  %arrayidx.6 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv.next59.5
  %8 = load i32, i32* %arrayidx.6, align 4, !tbaa !8
  %add.6 = add nsw i32 %8, %add.5
  %indvars.iv.next59.6 = or i64 %indvars.iv58, 7
  %arrayidx.7 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv.next59.6
  %9 = load i32, i32* %arrayidx.7, align 4, !tbaa !8
  %add.7 = add nsw i32 %9, %add.6
  %indvars.iv.next59.7 = add nuw nsw i64 %indvars.iv58, 8
  %niter.nsub.7 = add i64 %niter, -8
  %niter.ncmp.7 = icmp eq i64 %niter.nsub.7, 0
  br i1 %niter.ncmp.7, label %if.end.unr-lcssa, label %for.body

if.end.unr-lcssa:                                 ; preds = %for.body, %for.body.preheader
  %add.lcssa.ph = phi i32 [ undef, %for.body.preheader ], [ %add.7, %for.body ]
  %indvars.iv58.unr = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next59.7, %for.body ]
  %g.057.unr = phi i32 [ 0, %for.body.preheader ], [ %add.7, %for.body ]
  %lcmp.mod65.not = icmp eq i64 %xtraiter64, 0
  br i1 %lcmp.mod65.not, label %if.end, label %for.body.epil

for.body.epil:                                    ; preds = %if.end.unr-lcssa, %for.body.epil
  %indvars.iv58.epil = phi i64 [ %indvars.iv.next59.epil, %for.body.epil ], [ %indvars.iv58.unr, %if.end.unr-lcssa ]
  %g.057.epil = phi i32 [ %add.epil, %for.body.epil ], [ %g.057.unr, %if.end.unr-lcssa ]
  %epil.iter = phi i64 [ %epil.iter.sub, %for.body.epil ], [ %xtraiter64, %if.end.unr-lcssa ]
  %arrayidx.epil = getelementptr inbounds i32, i32* %b, i64 %indvars.iv58.epil
  %10 = load i32, i32* %arrayidx.epil, align 4, !tbaa !8
  %add.epil = add nsw i32 %10, %g.057.epil
  %indvars.iv.next59.epil = add nuw nsw i64 %indvars.iv58.epil, 1
  %epil.iter.sub = add i64 %epil.iter, -1
  %epil.iter.cmp.not = icmp eq i64 %epil.iter.sub, 0
  br i1 %epil.iter.cmp.not, label %if.end, label %for.body.epil, !llvm.loop !12

if.end:                                           ; preds = %for.body.epil, %if.end.unr-lcssa
  %add.lcssa = phi i32 [ %add.lcssa.ph, %if.end.unr-lcssa ], [ %add.epil, %for.body.epil ]
  %cmp6 = icmp sgt i32 %add.lcssa, 0
  br i1 %cmp6, label %if.then8, label %if.end30

if.then8:                                         ; preds = %if.end
  %cmp9 = icmp eq i32 %conv, 0
  %.pre = shl i64 %call, 32
  %.pre61 = ashr exact i64 %.pre, 32
  br i1 %cmp9, label %cond.end, label %cond.false

cond.false:                                       ; preds = %if.then8
  %arrayidx12 = getelementptr inbounds i32, i32* %c, i64 %.pre61
  %11 = load i32, i32* %arrayidx12, align 4, !tbaa !8
  %add13 = add nsw i32 %11, 1
  br label %cond.end

cond.end:                                         ; preds = %if.then8, %cond.false
  %cond = phi i32 [ %add13, %cond.false ], [ 0, %if.then8 ]
  %arrayidx15 = getelementptr inbounds i32, i32* %d, i64 %.pre61
  %12 = load i32, i32* %arrayidx15, align 4, !tbaa !8
  %cmp18.not53 = icmp slt i32 %12, %cond
  br i1 %cmp18.not53, label %if.end30, label %for.body21.preheader

for.body21.preheader:                             ; preds = %cond.end
  %13 = sext i32 %cond to i64
  %14 = add i32 %12, 1
  %15 = sub i32 %14, %cond
  %16 = sub i32 %12, %cond
  %xtraiter = and i32 %15, 3
  %lcmp.mod.not = icmp eq i32 %xtraiter, 0
  br i1 %lcmp.mod.not, label %for.body21.prol.loopexit, label %for.body21.prol

for.body21.prol:                                  ; preds = %for.body21.preheader, %for.body21.prol
  %indvars.iv.prol = phi i64 [ %indvars.iv.next.prol, %for.body21.prol ], [ %13, %for.body21.preheader ]
  %prol.iter = phi i32 [ %prol.iter.sub, %for.body21.prol ], [ %xtraiter, %for.body21.preheader ]
  %arrayidx23.prol = getelementptr inbounds i32, i32* %a, i64 %indvars.iv.prol
  %17 = load i32, i32* %arrayidx23.prol, align 4, !tbaa !8
  %add24.prol = add nsw i32 %17, %add.lcssa
  store i32 %add24.prol, i32* %arrayidx23.prol, align 4, !tbaa !8
  %indvars.iv.next.prol = add nsw i64 %indvars.iv.prol, 1
  %prol.iter.sub = add i32 %prol.iter, -1
  %prol.iter.cmp.not = icmp eq i32 %prol.iter.sub, 0
  br i1 %prol.iter.cmp.not, label %for.body21.prol.loopexit, label %for.body21.prol, !llvm.loop !14

for.body21.prol.loopexit:                         ; preds = %for.body21.prol, %for.body21.preheader
  %indvars.iv.unr = phi i64 [ %13, %for.body21.preheader ], [ %indvars.iv.next.prol, %for.body21.prol ]
  %18 = icmp ult i32 %16, 3
  br i1 %18, label %if.end30, label %for.body21

for.body21:                                       ; preds = %for.body21.prol.loopexit, %for.body21
  %indvars.iv = phi i64 [ %indvars.iv.next.3, %for.body21 ], [ %indvars.iv.unr, %for.body21.prol.loopexit ]
  %arrayidx23 = getelementptr inbounds i32, i32* %a, i64 %indvars.iv
  %19 = load i32, i32* %arrayidx23, align 4, !tbaa !8
  %add24 = add nsw i32 %19, %add.lcssa
  store i32 %add24, i32* %arrayidx23, align 4, !tbaa !8
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %arrayidx23.1 = getelementptr inbounds i32, i32* %a, i64 %indvars.iv.next
  %20 = load i32, i32* %arrayidx23.1, align 4, !tbaa !8
  %add24.1 = add nsw i32 %20, %add.lcssa
  store i32 %add24.1, i32* %arrayidx23.1, align 4, !tbaa !8
  %indvars.iv.next.1 = add nsw i64 %indvars.iv, 2
  %arrayidx23.2 = getelementptr inbounds i32, i32* %a, i64 %indvars.iv.next.1
  %21 = load i32, i32* %arrayidx23.2, align 4, !tbaa !8
  %add24.2 = add nsw i32 %21, %add.lcssa
  store i32 %add24.2, i32* %arrayidx23.2, align 4, !tbaa !8
  %indvars.iv.next.2 = add nsw i64 %indvars.iv, 3
  %arrayidx23.3 = getelementptr inbounds i32, i32* %a, i64 %indvars.iv.next.2
  %22 = load i32, i32* %arrayidx23.3, align 4, !tbaa !8
  %add24.3 = add nsw i32 %22, %add.lcssa
  store i32 %add24.3, i32* %arrayidx23.3, align 4, !tbaa !8
  %indvars.iv.next.3 = add nsw i64 %indvars.iv, 4
  %lftr.wideiv.3 = trunc i64 %indvars.iv.next.3 to i32
  %exitcond.not.3 = icmp eq i32 %14, %lftr.wideiv.3
  br i1 %exitcond.not.3, label %if.end30, label %for.body21

if.end30:                                         ; preds = %for.body21.prol.loopexit, %for.body21, %cond.end, %entry, %if.end
  ret void
}

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_global_id@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

; Function Attrs: convergent nounwind readnone
declare dso_local i64 @"?get_global_size@@$$J0YAKI@Z"(i32) local_unnamed_addr #1

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
!4 = !{i32 1, i32 1, i32 1, i32 1}
!5 = !{!"none", !"none", !"none", !"none"}
!6 = !{!"int*", !"int*", !"int*", !"int*"}
!7 = !{!"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"int", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = distinct !{!12, !13}
!13 = !{!"llvm.loop.unroll.disable"}
!14 = distinct !{!14, !13}
