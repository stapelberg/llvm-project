; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

; Ensure that type punning using a union of vector and same-sized array
; generates an extract instead of a shuffle with an uncommon vector size:
;
;   typedef uint32_t v4i32 __attribute__((vector_size(16)));
;   union { v4i32 v; uint32_t a[4]; };
;
; This cleans up behind SROA, which inserts the uncommon vector size when
; cleaning up the alloca/store/GEP/load.


; Provide legal integer types.
target datalayout = "p:32:32"


; Extracting the zeroth element in an i32 array.
define i32 @type_pun_zeroth(<16 x i8> %in) {
; CHECK-LABEL: @type_pun_zeroth(
; CHECK-NEXT:    [[SROA_BC:%.*]] = bitcast <16 x i8> [[IN:%.*]] to <4 x i32>
; CHECK-NEXT:    [[SROA_EXTRACT:%.*]] = extractelement <4 x i32> [[SROA_BC]], i32 0
; CHECK-NEXT:    ret i32 [[SROA_EXTRACT]]
;
  %sroa = shufflevector <16 x i8> %in, <16 x i8> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %1 = bitcast <4 x i8> %sroa to i32
  ret i32 %1
}

; Extracting the first element in an i32 array.
define i32 @type_pun_first(<16 x i8> %in) {
; CHECK-LABEL: @type_pun_first(
; CHECK-NEXT:    [[SROA_BC:%.*]] = bitcast <16 x i8> [[IN:%.*]] to <4 x i32>
; CHECK-NEXT:    [[SROA_EXTRACT:%.*]] = extractelement <4 x i32> [[SROA_BC]], i32 1
; CHECK-NEXT:    ret i32 [[SROA_EXTRACT]]
;
  %sroa = shufflevector <16 x i8> %in, <16 x i8> poison, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %1 = bitcast <4 x i8> %sroa to i32
  ret i32 %1
}

; Extracting an i32 that isn't aligned to any natural boundary.
define i32 @type_pun_misaligned(<16 x i8> %in) {
; CHECK-LABEL: @type_pun_misaligned(
; CHECK-NEXT:    [[SROA_EXTRACT:%.*]] = shufflevector <16 x i8> [[IN:%.*]], <16 x i8> undef, <16 x i32> <i32 6, i32 7, i32 8, i32 9, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; CHECK-NEXT:    [[SROA_BC:%.*]] = bitcast <16 x i8> [[SROA_EXTRACT]] to <4 x i32>
; CHECK-NEXT:    [[SROA_EXTRACT1:%.*]] = extractelement <4 x i32> [[SROA_BC]], i32 0
; CHECK-NEXT:    ret i32 [[SROA_EXTRACT1]]
;
  %sroa = shufflevector <16 x i8> %in, <16 x i8> poison, <4 x i32> <i32 6, i32 7, i32 8, i32 9>
  %1 = bitcast <4 x i8> %sroa to i32
  ret i32 %1
}

; Type punning to an array of pointers.
define i32* @type_pun_pointer(<16 x i8> %in) {
; CHECK-LABEL: @type_pun_pointer(
; CHECK-NEXT:    [[SROA_BC:%.*]] = bitcast <16 x i8> [[IN:%.*]] to <4 x i32>
; CHECK-NEXT:    [[SROA_EXTRACT:%.*]] = extractelement <4 x i32> [[SROA_BC]], i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = inttoptr i32 [[SROA_EXTRACT]] to i32*
; CHECK-NEXT:    ret i32* [[TMP1]]
;
  %sroa = shufflevector <16 x i8> %in, <16 x i8> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %1 = bitcast <4 x i8> %sroa to i32
  %2 = inttoptr i32 %1 to i32*
  ret i32* %2
}

; Type punning to an array of 32-bit floating-point values.
define float @type_pun_float(<16 x i8> %in) {
; CHECK-LABEL: @type_pun_float(
; CHECK-NEXT:    [[SROA_BC:%.*]] = bitcast <16 x i8> [[IN:%.*]] to <4 x float>
; CHECK-NEXT:    [[SROA_EXTRACT:%.*]] = extractelement <4 x float> [[SROA_BC]], i32 0
; CHECK-NEXT:    ret float [[SROA_EXTRACT]]
;
  %sroa = shufflevector <16 x i8> %in, <16 x i8> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %1 = bitcast <4 x i8> %sroa to float
  ret float %1
}

; Type punning to an array of 64-bit floating-point values.
define double @type_pun_double(<16 x i8> %in) {
; CHECK-LABEL: @type_pun_double(
; CHECK-NEXT:    [[SROA_BC:%.*]] = bitcast <16 x i8> [[IN:%.*]] to <2 x double>
; CHECK-NEXT:    [[SROA_EXTRACT:%.*]] = extractelement <2 x double> [[SROA_BC]], i32 0
; CHECK-NEXT:    ret double [[SROA_EXTRACT]]
;
  %sroa = shufflevector <16 x i8> %in, <16 x i8> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %1 = bitcast <8 x i8> %sroa to double
  ret double %1
}

; Type punning to same-size floating-point and integer values.
; Verify that multiple uses with different bitcast types are properly handled.
define { float, i32 } @type_pun_float_i32(<16 x i8> %in) {
; CHECK-LABEL: @type_pun_float_i32(
; CHECK-NEXT:    [[SROA_BC:%.*]] = bitcast <16 x i8> [[IN:%.*]] to <4 x i32>
; CHECK-NEXT:    [[SROA_EXTRACT:%.*]] = extractelement <4 x i32> [[SROA_BC]], i32 0
; CHECK-NEXT:    [[SROA_BC1:%.*]] = bitcast <16 x i8> [[IN]] to <4 x float>
; CHECK-NEXT:    [[SROA_EXTRACT2:%.*]] = extractelement <4 x float> [[SROA_BC1]], i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = insertvalue { float, i32 } undef, float [[SROA_EXTRACT2]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = insertvalue { float, i32 } [[TMP1]], i32 [[SROA_EXTRACT]], 1
; CHECK-NEXT:    ret { float, i32 } [[TMP2]]
;
  %sroa = shufflevector <16 x i8> %in, <16 x i8> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %f = bitcast <4 x i8> %sroa to float
  %i = bitcast <4 x i8> %sroa to i32
  %1 = insertvalue { float, i32 } undef, float %f, 0
  %2 = insertvalue { float, i32 } %1, i32 %i, 1
  ret { float, i32 } %2
}

; Type punning two i32 values, with control flow.
; Verify that the bitcast is shared and dominates usage.
define i32 @type_pun_i32_ctrl(<16 x i8> %in) {
; CHECK-LABEL: @type_pun_i32_ctrl(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SROA_BC:%.*]] = bitcast <16 x i8> [[IN:%.*]] to <4 x i32>
; CHECK-NEXT:    br i1 undef, label [[LEFT:%.*]], label [[RIGHT:%.*]]
; CHECK:       left:
; CHECK-NEXT:    [[SROA_EXTRACT1:%.*]] = extractelement <4 x i32> [[SROA_BC]], i32 0
; CHECK-NEXT:    br label [[TAIL:%.*]]
; CHECK:       right:
; CHECK-NEXT:    [[SROA_EXTRACT:%.*]] = extractelement <4 x i32> [[SROA_BC]], i32 0
; CHECK-NEXT:    br label [[TAIL]]
; CHECK:       tail:
; CHECK-NEXT:    [[I:%.*]] = phi i32 [ [[SROA_EXTRACT1]], [[LEFT]] ], [ [[SROA_EXTRACT]], [[RIGHT]] ]
; CHECK-NEXT:    ret i32 [[I]]
;
entry:
  %sroa = shufflevector <16 x i8> %in, <16 x i8> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  br i1 undef, label %left, label %right
left:
  %lhs = bitcast <4 x i8> %sroa to i32
  br label %tail
right:
  %rhs = bitcast <4 x i8> %sroa to i32
  br label %tail
tail:
  %i = phi i32 [ %lhs, %left ], [ %rhs, %right ]
  ret i32 %i
}

; Extracting a type that won't fit in a vector isn't handled. The function
; should stay the same.
define i40 @type_pun_unhandled(<16 x i8> %in) {
; CHECK-LABEL: @type_pun_unhandled(
; CHECK-NEXT:    [[SROA:%.*]] = shufflevector <16 x i8> [[IN:%.*]], <16 x i8> poison, <5 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8>
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <5 x i8> [[SROA]] to i40
; CHECK-NEXT:    ret i40 [[TMP1]]
;
  %sroa = shufflevector <16 x i8> %in, <16 x i8> poison, <5 x i32> <i32 4, i32 5, i32 6, i32 7, i32 8>
  %1 = bitcast <5 x i8> %sroa to i40
  ret i40 %1
}
