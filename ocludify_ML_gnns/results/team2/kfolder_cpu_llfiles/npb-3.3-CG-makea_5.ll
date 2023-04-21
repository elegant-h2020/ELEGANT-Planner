; ModuleID = './kernels/kernels/npb-3.3-CG-makea_5.cl'
source_filename = "./kernels/kernels/npb-3.3-CG-makea_5.cl"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc19.16.27025"

; Function Attrs: convergent nofree norecurse nounwind uwtable
define dso_local spir_kernel void @A(i32* nocapture %a, i32* nocapture readonly %b, i32* nocapture readonly %c, i32* nocapture readonly %d, i32 %e, i32 %f) local_unnamed_addr #0 !kernel_arg_addr_space !4 !kernel_arg_access_qual !5 !kernel_arg_type !6 !kernel_arg_base_type !6 !kernel_arg_type_qual !7 {
entry:
  %call = tail call i64 @"?get_global_id@@$$J0YAKI@Z"(i32 0) #2
  %conv = trunc i64 %call to i32
  %call1 = tail call i64 @"?get_global_size@@$$J0YAKI@Z"(i32 0) #2
  %sext = shl i64 %call, 32
  %idxprom = ashr exact i64 %sext, 32
  %arrayidx = getelementptr inbounds i32, i32* %c, i64 %idxprom
  %0 = load i32, i32* %arrayidx, align 4, !tbaa !8
  %cmp.not = icmp slt i32 %0, %e
  br i1 %cmp.not, label %if.end, label %cleanup

if.end:                                           ; preds = %entry
  %conv2 = trunc i64 %call1 to i32
  %arrayidx5 = getelementptr inbounds i32, i32* %d, i64 %idxprom
  %1 = load i32, i32* %arrayidx5, align 4, !tbaa !8
  %cmp6 = icmp slt i32 %conv, %conv2
  %cmp959 = icmp sgt i32 %conv, 0
  %or.cond = and i1 %cmp6, %cmp959
  br i1 %or.cond, label %for.body.preheader, label %cleanup

for.body.preheader:                               ; preds = %if.end
  %wide.trip.count64 = and i64 %call, 4294967295
  %2 = add nsw i64 %wide.trip.count64, -1
  %xtraiter68 = and i64 %call, 7
  %3 = icmp ult i64 %2, 7
  br i1 %3, label %if.end13.unr-lcssa, label %for.body.preheader.new

for.body.preheader.new:                           ; preds = %for.body.preheader
  %unroll_iter = sub nsw i64 %wide.trip.count64, %xtraiter68
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader.new
  %indvars.iv62 = phi i64 [ 0, %for.body.preheader.new ], [ %indvars.iv.next63.7, %for.body ]
  %k.060 = phi i32 [ 0, %for.body.preheader.new ], [ %add.7, %for.body ]
  %niter = phi i64 [ %unroll_iter, %for.body.preheader.new ], [ %niter.nsub.7, %for.body ]
  %arrayidx12 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv62
  %4 = load i32, i32* %arrayidx12, align 4, !tbaa !8
  %add = add nsw i32 %4, %k.060
  %indvars.iv.next63 = or i64 %indvars.iv62, 1
  %arrayidx12.1 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv.next63
  %5 = load i32, i32* %arrayidx12.1, align 4, !tbaa !8
  %add.1 = add nsw i32 %5, %add
  %indvars.iv.next63.1 = or i64 %indvars.iv62, 2
  %arrayidx12.2 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv.next63.1
  %6 = load i32, i32* %arrayidx12.2, align 4, !tbaa !8
  %add.2 = add nsw i32 %6, %add.1
  %indvars.iv.next63.2 = or i64 %indvars.iv62, 3
  %arrayidx12.3 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv.next63.2
  %7 = load i32, i32* %arrayidx12.3, align 4, !tbaa !8
  %add.3 = add nsw i32 %7, %add.2
  %indvars.iv.next63.3 = or i64 %indvars.iv62, 4
  %arrayidx12.4 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv.next63.3
  %8 = load i32, i32* %arrayidx12.4, align 4, !tbaa !8
  %add.4 = add nsw i32 %8, %add.3
  %indvars.iv.next63.4 = or i64 %indvars.iv62, 5
  %arrayidx12.5 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv.next63.4
  %9 = load i32, i32* %arrayidx12.5, align 4, !tbaa !8
  %add.5 = add nsw i32 %9, %add.4
  %indvars.iv.next63.5 = or i64 %indvars.iv62, 6
  %arrayidx12.6 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv.next63.5
  %10 = load i32, i32* %arrayidx12.6, align 4, !tbaa !8
  %add.6 = add nsw i32 %10, %add.5
  %indvars.iv.next63.6 = or i64 %indvars.iv62, 7
  %arrayidx12.7 = getelementptr inbounds i32, i32* %b, i64 %indvars.iv.next63.6
  %11 = load i32, i32* %arrayidx12.7, align 4, !tbaa !8
  %add.7 = add nsw i32 %11, %add.6
  %indvars.iv.next63.7 = add nuw nsw i64 %indvars.iv62, 8
  %niter.nsub.7 = add i64 %niter, -8
  %niter.ncmp.7 = icmp eq i64 %niter.nsub.7, 0
  br i1 %niter.ncmp.7, label %if.end13.unr-lcssa, label %for.body

if.end13.unr-lcssa:                               ; preds = %for.body, %for.body.preheader
  %add.lcssa.ph = phi i32 [ undef, %for.body.preheader ], [ %add.7, %for.body ]
  %indvars.iv62.unr = phi i64 [ 0, %for.body.preheader ], [ %indvars.iv.next63.7, %for.body ]
  %k.060.unr = phi i32 [ 0, %for.body.preheader ], [ %add.7, %for.body ]
  %lcmp.mod69.not = icmp eq i64 %xtraiter68, 0
  br i1 %lcmp.mod69.not, label %if.end13, label %for.body.epil

for.body.epil:                                    ; preds = %if.end13.unr-lcssa, %for.body.epil
  %indvars.iv62.epil = phi i64 [ %indvars.iv.next63.epil, %for.body.epil ], [ %indvars.iv62.unr, %if.end13.unr-lcssa ]
  %k.060.epil = phi i32 [ %add.epil, %for.body.epil ], [ %k.060.unr, %if.end13.unr-lcssa ]
  %epil.iter = phi i64 [ %epil.iter.sub, %for.body.epil ], [ %xtraiter68, %if.end13.unr-lcssa ]
  %arrayidx12.epil = getelementptr inbounds i32, i32* %b, i64 %indvars.iv62.epil
  %12 = load i32, i32* %arrayidx12.epil, align 4, !tbaa !8
  %add.epil = add nsw i32 %12, %k.060.epil
  %indvars.iv.next63.epil = add nuw nsw i64 %indvars.iv62.epil, 1
  %epil.iter.sub = add i64 %epil.iter, -1
  %epil.iter.cmp.not = icmp eq i64 %epil.iter.sub, 0
  br i1 %epil.iter.cmp.not, label %if.end13, label %for.body.epil, !llvm.loop !12

if.end13:                                         ; preds = %for.body.epil, %if.end13.unr-lcssa
  %add.lcssa = phi i32 [ %add.lcssa.ph, %if.end13.unr-lcssa ], [ %add.epil, %for.body.epil ]
  %cmp14 = icmp sgt i32 %add.lcssa, 0
  br i1 %cmp14, label %if.then16, label %cleanup

if.then16:                                        ; preds = %if.end13
  %idxprom17 = sext i32 %f to i64
  %arrayidx18 = getelementptr inbounds i32, i32* %a, i64 %idxprom17
  %cmp2057 = icmp slt i32 %0, %1
  br i1 %cmp2057, label %for.body23.preheader, label %cleanup

for.body23.preheader:                             ; preds = %if.then16
  %13 = sext i32 %0 to i64
  %wide.trip.count = sext i32 %1 to i64
  %14 = sub nsw i64 %wide.trip.count, %13
  %15 = xor i64 %13, -1
  %16 = add nsw i64 %15, %wide.trip.count
  %xtraiter = and i64 %14, 3
  %lcmp.mod.not = icmp eq i64 %xtraiter, 0
  br i1 %lcmp.mod.not, label %for.body23.prol.loopexit, label %for.body23.prol

for.body23.prol:                                  ; preds = %for.body23.preheader, %for.body23.prol
  %indvars.iv.prol = phi i64 [ %indvars.iv.next.prol, %for.body23.prol ], [ %13, %for.body23.preheader ]
  %prol.iter = phi i64 [ %prol.iter.sub, %for.body23.prol ], [ %xtraiter, %for.body23.preheader ]
  %arrayidx25.prol = getelementptr inbounds i32, i32* %arrayidx18, i64 %indvars.iv.prol
  %17 = load i32, i32* %arrayidx25.prol, align 4, !tbaa !8
  %add26.prol = add nsw i32 %17, %add.lcssa
  store i32 %add26.prol, i32* %arrayidx25.prol, align 4, !tbaa !8
  %indvars.iv.next.prol = add nsw i64 %indvars.iv.prol, 1
  %prol.iter.sub = add i64 %prol.iter, -1
  %prol.iter.cmp.not = icmp eq i64 %prol.iter.sub, 0
  br i1 %prol.iter.cmp.not, label %for.body23.prol.loopexit, label %for.body23.prol, !llvm.loop !14

for.body23.prol.loopexit:                         ; preds = %for.body23.prol, %for.body23.preheader
  %indvars.iv.unr = phi i64 [ %13, %for.body23.preheader ], [ %indvars.iv.next.prol, %for.body23.prol ]
  %18 = icmp ult i64 %16, 3
  br i1 %18, label %cleanup, label %for.body23

for.body23:                                       ; preds = %for.body23.prol.loopexit, %for.body23
  %indvars.iv = phi i64 [ %indvars.iv.next.3, %for.body23 ], [ %indvars.iv.unr, %for.body23.prol.loopexit ]
  %arrayidx25 = getelementptr inbounds i32, i32* %arrayidx18, i64 %indvars.iv
  %19 = load i32, i32* %arrayidx25, align 4, !tbaa !8
  %add26 = add nsw i32 %19, %add.lcssa
  store i32 %add26, i32* %arrayidx25, align 4, !tbaa !8
  %indvars.iv.next = add nsw i64 %indvars.iv, 1
  %arrayidx25.1 = getelementptr inbounds i32, i32* %arrayidx18, i64 %indvars.iv.next
  %20 = load i32, i32* %arrayidx25.1, align 4, !tbaa !8
  %add26.1 = add nsw i32 %20, %add.lcssa
  store i32 %add26.1, i32* %arrayidx25.1, align 4, !tbaa !8
  %indvars.iv.next.1 = add nsw i64 %indvars.iv, 2
  %arrayidx25.2 = getelementptr inbounds i32, i32* %arrayidx18, i64 %indvars.iv.next.1
  %21 = load i32, i32* %arrayidx25.2, align 4, !tbaa !8
  %add26.2 = add nsw i32 %21, %add.lcssa
  store i32 %add26.2, i32* %arrayidx25.2, align 4, !tbaa !8
  %indvars.iv.next.2 = add nsw i64 %indvars.iv, 3
  %arrayidx25.3 = getelementptr inbounds i32, i32* %arrayidx18, i64 %indvars.iv.next.2
  %22 = load i32, i32* %arrayidx25.3, align 4, !tbaa !8
  %add26.3 = add nsw i32 %22, %add.lcssa
  store i32 %add26.3, i32* %arrayidx25.3, align 4, !tbaa !8
  %indvars.iv.next.3 = add nsw i64 %indvars.iv, 4
  %exitcond.not.3 = icmp eq i64 %indvars.iv.next.3, %wide.trip.count
  br i1 %exitcond.not.3, label %cleanup, label %for.body23

cleanup:                                          ; preds = %for.body23.prol.loopexit, %for.body23, %if.then16, %if.end, %if.end13, %entry
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
!4 = !{i32 1, i32 1, i32 1, i32 1, i32 0, i32 0}
!5 = !{!"none", !"none", !"none", !"none", !"none", !"none"}
!6 = !{!"int*", !"int*", !"int*", !"int*", !"int", !"int"}
!7 = !{!"", !"", !"", !"", !"", !""}
!8 = !{!9, !9, i64 0}
!9 = !{!"int", !10, i64 0}
!10 = !{!"omnipotent char", !11, i64 0}
!11 = !{!"Simple C/C++ TBAA"}
!12 = distinct !{!12, !13}
!13 = !{!"llvm.loop.unroll.disable"}
!14 = distinct !{!14, !13}
