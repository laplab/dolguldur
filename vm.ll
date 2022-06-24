; ModuleID = 'vm.cpp'
source_filename = "vm.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.State = type { i32, [100 x i8] }

; Function Attrs: alwaysinline nofree norecurse nounwind ssp uwtable willreturn mustprogress
define dso_local void @_Z9pushConstP5Stateh(%struct.State* nocapture %0, i8 zeroext %1) local_unnamed_addr #0 {
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i64 0, i32 0
  %4 = load i32, i32* %3, align 4, !tbaa !3
  %5 = add nsw i32 %4, 1
  store i32 %5, i32* %3, align 4, !tbaa !3
  %6 = sext i32 %4 to i64
  %7 = getelementptr inbounds %struct.State, %struct.State* %0, i64 0, i32 1, i64 %6
  store i8 %1, i8* %7, align 1, !tbaa !8
  ret void
}

; Function Attrs: alwaysinline nofree norecurse nounwind ssp uwtable willreturn mustprogress
define dso_local void @_Z3addP5State(%struct.State* nocapture %0) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %struct.State, %struct.State* %0, i64 0, i32 0
  %3 = load i32, i32* %2, align 4, !tbaa !3
  %4 = add nsw i32 %3, -1
  %5 = sext i32 %4 to i64
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i64 0, i32 1, i64 %5
  %7 = load i8, i8* %6, align 1, !tbaa !8
  %8 = add nsw i32 %3, -2
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds %struct.State, %struct.State* %0, i64 0, i32 1, i64 %9
  %11 = load i8, i8* %10, align 1, !tbaa !8
  %12 = add i8 %11, %7
  store i32 %4, i32* %2, align 4, !tbaa !3
  store i8 %12, i8* %10, align 1, !tbaa !8
  ret void
}

attributes #0 = { alwaysinline nofree norecurse nounwind ssp uwtable willreturn mustprogress "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"Homebrew clang version 12.0.1"}
!3 = !{!4, !5, i64 0}
!4 = !{!"_ZTS5State", !5, i64 0, !6, i64 4}
!5 = !{!"int", !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C++ TBAA"}
!8 = !{!6, !6, i64 0}
