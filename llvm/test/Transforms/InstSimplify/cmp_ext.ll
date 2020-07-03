; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instsimplify -S | FileCheck %s

define i1 @zext_uge_sext(i32 %x) {
; CHECK-LABEL: @zext_uge_sext(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    [[CMP:%.*]] = icmp uge i64 [[ZEXT]], [[SEXT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sext = sext i32 %x to i64
  %zext = zext i32 %x to i64
  %cmp = icmp uge i64 %zext, %sext
  ret i1 %cmp
}

define i1 @zext_ugt_sext(i32 %x) {
; CHECK-LABEL: @zext_ugt_sext(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[ZEXT]], [[SEXT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sext = sext i32 %x to i64
  %zext = zext i32 %x to i64
  %cmp = icmp ugt i64 %zext, %sext
  ret i1 %cmp
}

define i1 @zext_ult_sext(i32 %x) {
; CHECK-LABEL: @zext_ult_sext(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[ZEXT]], [[SEXT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sext = sext i32 %x to i64
  %zext = zext i32 %x to i64
  %cmp = icmp ult i64 %zext, %sext
  ret i1 %cmp
}

define i1 @zext_ule_sext(i32 %x) {
; CHECK-LABEL: @zext_ule_sext(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    [[CMP:%.*]] = icmp ule i64 [[ZEXT]], [[SEXT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sext = sext i32 %x to i64
  %zext = zext i32 %x to i64
  %cmp = icmp ule i64 %zext, %sext
  ret i1 %cmp
}

define i1 @zext_sge_sext(i32 %x) {
; CHECK-LABEL: @zext_sge_sext(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    [[CMP:%.*]] = icmp sge i64 [[ZEXT]], [[SEXT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sext = sext i32 %x to i64
  %zext = zext i32 %x to i64
  %cmp = icmp sge i64 %zext, %sext
  ret i1 %cmp
}

define i1 @zext_sgt_sext(i32 %x) {
; CHECK-LABEL: @zext_sgt_sext(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i64 [[ZEXT]], [[SEXT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sext = sext i32 %x to i64
  %zext = zext i32 %x to i64
  %cmp = icmp sgt i64 %zext, %sext
  ret i1 %cmp
}

define i1 @zext_slt_sext(i32 %x) {
; CHECK-LABEL: @zext_slt_sext(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i64 [[ZEXT]], [[SEXT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sext = sext i32 %x to i64
  %zext = zext i32 %x to i64
  %cmp = icmp slt i64 %zext, %sext
  ret i1 %cmp
}

define i1 @zext_sle_sext(i32 %x) {
; CHECK-LABEL: @zext_sle_sext(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle i64 [[ZEXT]], [[SEXT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sext = sext i32 %x to i64
  %zext = zext i32 %x to i64
  %cmp = icmp sle i64 %zext, %sext
  ret i1 %cmp
}

define i1 @sext_uge_zext(i32 %x) {
; CHECK-LABEL: @sext_uge_zext(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    [[CMP:%.*]] = icmp uge i64 [[SEXT]], [[ZEXT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sext = sext i32 %x to i64
  %zext = zext i32 %x to i64
  %cmp = icmp uge i64 %sext, %zext
  ret i1 %cmp
}

define i1 @sext_ugt_zext(i32 %x) {
; CHECK-LABEL: @sext_ugt_zext(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[SEXT]], [[ZEXT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sext = sext i32 %x to i64
  %zext = zext i32 %x to i64
  %cmp = icmp ugt i64 %sext, %zext
  ret i1 %cmp
}

define i1 @sext_ult_zext(i32 %x) {
; CHECK-LABEL: @sext_ult_zext(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i64 [[SEXT]], [[ZEXT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sext = sext i32 %x to i64
  %zext = zext i32 %x to i64
  %cmp = icmp ult i64 %sext, %zext
  ret i1 %cmp
}

define i1 @sext_ule_zext(i32 %x) {
; CHECK-LABEL: @sext_ule_zext(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    [[CMP:%.*]] = icmp ule i64 [[SEXT]], [[ZEXT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sext = sext i32 %x to i64
  %zext = zext i32 %x to i64
  %cmp = icmp ule i64 %sext, %zext
  ret i1 %cmp
}

define i1 @sext_sge_zext(i32 %x) {
; CHECK-LABEL: @sext_sge_zext(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    [[CMP:%.*]] = icmp sge i64 [[SEXT]], [[ZEXT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sext = sext i32 %x to i64
  %zext = zext i32 %x to i64
  %cmp = icmp sge i64 %sext, %zext
  ret i1 %cmp
}

define i1 @sext_sgt_zext(i32 %x) {
; CHECK-LABEL: @sext_sgt_zext(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i64 [[SEXT]], [[ZEXT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sext = sext i32 %x to i64
  %zext = zext i32 %x to i64
  %cmp = icmp sgt i64 %sext, %zext
  ret i1 %cmp
}

define i1 @sext_slt_zext(i32 %x) {
; CHECK-LABEL: @sext_slt_zext(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i64 [[SEXT]], [[ZEXT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sext = sext i32 %x to i64
  %zext = zext i32 %x to i64
  %cmp = icmp slt i64 %sext, %zext
  ret i1 %cmp
}

define i1 @sext_sle_zext(i32 %x) {
; CHECK-LABEL: @sext_sle_zext(
; CHECK-NEXT:    [[SEXT:%.*]] = sext i32 [[X:%.*]] to i64
; CHECK-NEXT:    [[ZEXT:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    [[CMP:%.*]] = icmp sle i64 [[SEXT]], [[ZEXT]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %sext = sext i32 %x to i64
  %zext = zext i32 %x to i64
  %cmp = icmp sle i64 %sext, %zext
  ret i1 %cmp
}