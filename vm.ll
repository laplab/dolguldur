; ModuleID = 'vm.cpp'
source_filename = "vm.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%struct.State = type { i32, [100 x i8] }

; Function Attrs: noinline nounwind optnone ssp uwtable mustprogress
define dso_local void @_Z9pushConstP5Stateh(%struct.State* %0, i8 zeroext %1) #0 {
  %3 = alloca %struct.State*, align 8
  %4 = alloca i8, align 1
  store %struct.State* %0, %struct.State** %3, align 8
  store i8 %1, i8* %4, align 1
  %5 = load i8, i8* %4, align 1
  %6 = load %struct.State*, %struct.State** %3, align 8
  %7 = getelementptr inbounds %struct.State, %struct.State* %6, i32 0, i32 1
  %8 = load %struct.State*, %struct.State** %3, align 8
  %9 = getelementptr inbounds %struct.State, %struct.State* %8, i32 0, i32 0
  %10 = load i32, i32* %9, align 4
  %11 = add nsw i32 %10, 1
  store i32 %11, i32* %9, align 4
  %12 = sext i32 %10 to i64
  %13 = getelementptr inbounds [100 x i8], [100 x i8]* %7, i64 0, i64 %12
  store i8 %5, i8* %13, align 1
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable mustprogress
define dso_local void @_Z3addP5State(%struct.State* %0) #0 {
  %2 = alloca %struct.State*, align 8
  %3 = alloca i8, align 1
  %4 = alloca i8, align 1
  store %struct.State* %0, %struct.State** %2, align 8
  %5 = load %struct.State*, %struct.State** %2, align 8
  %6 = getelementptr inbounds %struct.State, %struct.State* %5, i32 0, i32 1
  %7 = load %struct.State*, %struct.State** %2, align 8
  %8 = getelementptr inbounds %struct.State, %struct.State* %7, i32 0, i32 0
  %9 = load i32, i32* %8, align 4
  %10 = sub nsw i32 %9, 1
  %11 = sext i32 %10 to i64
  %12 = getelementptr inbounds [100 x i8], [100 x i8]* %6, i64 0, i64 %11
  %13 = load i8, i8* %12, align 1
  store i8 %13, i8* %3, align 1
  %14 = load %struct.State*, %struct.State** %2, align 8
  %15 = getelementptr inbounds %struct.State, %struct.State* %14, i32 0, i32 1
  %16 = load %struct.State*, %struct.State** %2, align 8
  %17 = getelementptr inbounds %struct.State, %struct.State* %16, i32 0, i32 0
  %18 = load i32, i32* %17, align 4
  %19 = sub nsw i32 %18, 2
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds [100 x i8], [100 x i8]* %15, i64 0, i64 %20
  %22 = load i8, i8* %21, align 1
  store i8 %22, i8* %4, align 1
  %23 = load %struct.State*, %struct.State** %2, align 8
  %24 = getelementptr inbounds %struct.State, %struct.State* %23, i32 0, i32 0
  %25 = load i32, i32* %24, align 4
  %26 = sub nsw i32 %25, 2
  store i32 %26, i32* %24, align 4
  %27 = load i8, i8* %3, align 1
  %28 = zext i8 %27 to i32
  %29 = load i8, i8* %4, align 1
  %30 = zext i8 %29 to i32
  %31 = add nsw i32 %28, %30
  %32 = trunc i32 %31 to i8
  %33 = load %struct.State*, %struct.State** %2, align 8
  %34 = getelementptr inbounds %struct.State, %struct.State* %33, i32 0, i32 1
  %35 = load %struct.State*, %struct.State** %2, align 8
  %36 = getelementptr inbounds %struct.State, %struct.State* %35, i32 0, i32 0
  %37 = load i32, i32* %36, align 4
  %38 = add nsw i32 %37, 1
  store i32 %38, i32* %36, align 4
  %39 = sext i32 %37 to i64
  %40 = getelementptr inbounds [100 x i8], [100 x i8]* %34, i64 0, i64 %39
  store i8 %32, i8* %40, align 1
  ret void
}

attributes #0 = { noinline nounwind optnone ssp uwtable mustprogress "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"Homebrew clang version 12.0.1"}
