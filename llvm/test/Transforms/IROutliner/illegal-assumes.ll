; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -verify -iroutliner < %s | FileCheck %s

; This test ensures that we do not include llvm.assumes.  There are exceptions
; in the CodeExtractor's algorithm for llvm.assumes, so we ignore it for now.

define void @outline_assumes() {
; CHECK-LABEL: @outline_assumes(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DL_LOC:%.*]] = alloca i1, align 1
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[D:%.*]] = alloca i1, align 4
; CHECK-NEXT:    [[LT_CAST:%.*]] = bitcast i1* [[DL_LOC]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 -1, i8* [[LT_CAST]])
; CHECK-NEXT:    call void @outlined_ir_func_3(i1 true, i1* [[D]], i1* [[DL_LOC]])
; CHECK-NEXT:    [[DL_RELOAD:%.*]] = load i1, i1* [[DL_LOC]], align 1
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 -1, i8* [[LT_CAST]])
; CHECK-NEXT:    [[SPLIT_INST:%.*]] = sub i1 [[DL_RELOAD]], [[DL_RELOAD]]
; CHECK-NEXT:    call void @outlined_ir_func_0(i32* [[A]], i32* [[B]], i32* [[C]])
; CHECK-NEXT:    call void @llvm.assume(i1 [[DL_RELOAD]])
; CHECK-NEXT:    call void @outlined_ir_func_1(i32* [[A]], i32* [[B]], i32* [[C]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i1, align 4
  store i1 1, i1* %d, align 4
  %dl = load i1, i1* %d
  %split_inst = sub i1 %dl, %dl
  store i32 2, i32* %a, align 4
  store i32 3, i32* %b, align 4
  store i32 4, i32* %c, align 4
  call void @llvm.assume(i1 %dl)
  %al = load i32, i32* %a
  %bl = load i32, i32* %b
  %cl = load i32, i32* %c
  ret void
}

define void @outline_assumes2() {
; CHECK-LABEL: @outline_assumes2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DL_LOC:%.*]] = alloca i1, align 1
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[D:%.*]] = alloca i1, align 4
; CHECK-NEXT:    [[LT_CAST:%.*]] = bitcast i1* [[DL_LOC]] to i8*
; CHECK-NEXT:    call void @llvm.lifetime.start.p0i8(i64 -1, i8* [[LT_CAST]])
; CHECK-NEXT:    call void @outlined_ir_func_3(i1 false, i1* [[D]], i1* [[DL_LOC]])
; CHECK-NEXT:    [[DL_RELOAD:%.*]] = load i1, i1* [[DL_LOC]], align 1
; CHECK-NEXT:    call void @llvm.lifetime.end.p0i8(i64 -1, i8* [[LT_CAST]])
; CHECK-NEXT:    call void @outlined_ir_func_0(i32* [[A]], i32* [[B]], i32* [[C]])
; CHECK-NEXT:    call void @llvm.assume(i1 [[DL_RELOAD]])
; CHECK-NEXT:    call void @outlined_ir_func_1(i32* [[A]], i32* [[B]], i32* [[C]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i1, align 4
  store i1 0, i1* %d, align 4
  %dl = load i1, i1* %d
  store i32 2, i32* %a, align 4
  store i32 3, i32* %b, align 4
  store i32 4, i32* %c, align 4
  call void @llvm.assume(i1 %dl)
  %al = load i32, i32* %a
  %bl = load i32, i32* %b
  %cl = load i32, i32* %c
  ret void
}

define void @outline_assumes3() {
; CHECK-LABEL: @outline_assumes3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[D:%.*]] = alloca i1, align 4
; CHECK-NEXT:    store i1 true, i1* [[D]], align 4
; CHECK-NEXT:    [[DL:%.*]] = load i1, i1* [[D]], align 1
; CHECK-NEXT:    [[SPLIT_INST:%.*]] = add i1 [[DL]], [[DL]]
; CHECK-NEXT:    call void @outlined_ir_func_0(i32* [[A]], i32* [[B]], i32* [[C]])
; CHECK-NEXT:    call void @llvm.assume(i1 [[DL]])
; CHECK-NEXT:    call void @outlined_ir_func_2(i32* [[A]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i1, align 4
  store i1 1, i1* %d, align 4
  %dl = load i1, i1* %d
  %split_inst = add i1 %dl, %dl
  store i32 2, i32* %a, align 4
  store i32 3, i32* %b, align 4
  store i32 4, i32* %c, align 4
  call void @llvm.assume(i1 %dl)
  %al = load i32, i32* %a
  %bl = add i32 %al, %al
  ret void
}

define void @outline_assumes4() {
; CHECK-LABEL: @outline_assumes4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[B:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[C:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[D:%.*]] = alloca i1, align 4
; CHECK-NEXT:    store i1 false, i1* [[D]], align 4
; CHECK-NEXT:    [[DL:%.*]] = load i1, i1* [[D]], align 1
; CHECK-NEXT:    [[SPLIT_INST:%.*]] = add i1 [[DL]], [[DL]]
; CHECK-NEXT:    call void @outlined_ir_func_0(i32* [[A]], i32* [[B]], i32* [[C]])
; CHECK-NEXT:    call void @llvm.assume(i1 [[DL]])
; CHECK-NEXT:    call void @outlined_ir_func_2(i32* [[A]])
; CHECK-NEXT:    ret void
;
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i1, align 4
  store i1 0, i1* %d, align 4
  %dl = load i1, i1* %d
  %split_inst = add i1 %dl, %dl
  store i32 2, i32* %a, align 4
  store i32 3, i32* %b, align 4
  store i32 4, i32* %c, align 4
  call void @llvm.assume(i1 %dl)
  %al = load i32, i32* %a
  %bl = add i32 %al, %al
  ret void
}

declare void @llvm.assume(i1)
