; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S --passes=slp-vectorizer -mtriple=aarch64-unknown-linux-gnu < %s | FileCheck %s

declare noalias ptr @malloc()

define void @test() {
; CHECK-LABEL: define void @test() {
; CHECK-NEXT:    [[TMP1:%.*]] = call dereferenceable_or_null(16) ptr @malloc()
; CHECK-NEXT:    [[TMP2:%.*]] = load volatile ptr, ptr null, align 8
; CHECK-NEXT:    [[TMP3:%.*]] = load <15 x i8>, ptr [[TMP1]], align 1
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <15 x i8> [[TMP3]], <15 x i8> poison, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
; CHECK-NEXT:    store <8 x i8> [[TMP4]], ptr [[TMP2]], align 1
; CHECK-NEXT:    ret void
;
  %1 = call dereferenceable_or_null(16) ptr @malloc()
  %2 = load volatile ptr, ptr null, align 8
  %3 = load i8, ptr %1, align 1
  store i8 %3, ptr %2, align 1
  %4 = getelementptr i8, ptr %1, i64 2
  %5 = load i8, ptr %4, align 1
  %6 = getelementptr i8, ptr %2, i64 1
  store i8 %5, ptr %6, align 1
  %7 = getelementptr i8, ptr %1, i64 4
  %8 = load i8, ptr %7, align 1
  %9 = getelementptr i8, ptr %2, i64 2
  store i8 %8, ptr %9, align 1
  %10 = getelementptr i8, ptr %1, i64 6
  %11 = load i8, ptr %10, align 1
  %12 = getelementptr i8, ptr %2, i64 3
  store i8 %11, ptr %12, align 1
  %13 = getelementptr i8, ptr %1, i64 8
  %14 = load i8, ptr %13, align 1
  %15 = getelementptr i8, ptr %2, i64 4
  store i8 %14, ptr %15, align 1
  %16 = getelementptr i8, ptr %1, i64 10
  %17 = load i8, ptr %16, align 1
  %18 = getelementptr i8, ptr %2, i64 5
  store i8 %17, ptr %18, align 1
  %19 = getelementptr i8, ptr %1, i64 12
  %20 = load i8, ptr %19, align 1
  %21 = getelementptr i8, ptr %2, i64 6
  store i8 %20, ptr %21, align 1
  %22 = getelementptr i8, ptr %1, i64 14
  %23 = load i8, ptr %22, align 1
  %24 = getelementptr i8, ptr %2, i64 7
  store i8 %23, ptr %24, align 1
  ret void
}
