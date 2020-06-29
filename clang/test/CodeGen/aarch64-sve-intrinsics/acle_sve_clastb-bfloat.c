// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -D__ARM_FEATURE_SVE -D__ARM_FEATURE_SVE_BF16 -D__ARM_FEATURE_BF16_SCALAR_ARITHMETIC -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -D__ARM_FEATURE_SVE -D__ARM_FEATURE_SVE_BF16 -D__ARM_FEATURE_BF16_SCALAR_ARITHMETIC -DSVE_OVERLOADED_FORMS -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s

// RUN: %clang_cc1 -D__ARM_FEATURE_SVE -D__ARM_FEATURE_SVE_BF16 -D__ARM_FEATURE_BF16_SCALAR_ARITHMETIC -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -fallow-half-arguments-and-returns -S -O1 -Werror -Wall -o - %s >/dev/null 2>%t
// RUN: FileCheck --check-prefix=ASM --allow-empty %s <%t
// RUN: %clang_cc1 -D__ARM_FEATURE_SVE -D__ARM_FEATURE_BF16_SCALAR_ARITHMETIC -triple aarch64-none-linux-gnu -target-feature +sve -target-feature +bf16 -fallow-half-arguments-and-returns -fsyntax-only -verify -verify-ignore-unexpected=error -verify-ignore-unexpected=note %s

// If this check fails please read test/CodeGen/aarch64-sve-intrinsics/README for instructions on how to resolve it.
// ASM-NOT: warning
#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1, A2_UNUSED, A3, A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1, A2, A3, A4) A1##A2##A3##A4
#endif

svbfloat16_t test_svclastb_bf16(svbool_t pg, svbfloat16_t fallback, svbfloat16_t data) {
  // CHECK-LABEL: test_svclastb_bf16
  // CHECK: %[[PG:.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> %pg)
  // CHECK: %[[INTRINSIC:.*]] = call <vscale x 8 x bfloat> @llvm.aarch64.sve.clastb.nxv8bf16(<vscale x 8 x i1> %[[PG]], <vscale x 8 x bfloat> %fallback, <vscale x 8 x bfloat> %data)
  // CHECK: ret <vscale x 8 x bfloat> %[[INTRINSIC]]
  // expected-warning@+1 {{implicit declaration of function 'svclastb_bf16'}}
  return SVE_ACLE_FUNC(svclastb, _bf16, , )(pg, fallback, data);
}

bfloat16_t test_svclastb_n_bf16(svbool_t pg, bfloat16_t fallback, svbfloat16_t data) {
  // CHECK-LABEL: test_svclastb_n_bf16
  // CHECK: %[[PG:.*]] = call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> %pg)
  // CHECK: %[[INTRINSIC:.*]] = call bfloat @llvm.aarch64.sve.clastb.n.nxv8bf16(<vscale x 8 x i1> %[[PG]], bfloat %fallback, <vscale x 8 x bfloat> %data)
  // CHECK: ret bfloat %[[INTRINSIC]]
  // expected-warning@+1 {{implicit declaration of function 'svclastb_n_bf16'}}
  return SVE_ACLE_FUNC(svclastb, _n_bf16, , )(pg, fallback, data);
}