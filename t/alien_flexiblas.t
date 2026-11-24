use Test::More;
use Test::Alien;
use Test::Alien::Diag;
use Alien::FlexiBLAS;

alien_diag 'Alien::FlexiBLAS';
alien_ok 'Alien::FlexiBLAS';

my $xs = <<'END';
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <math.h>
#include <cblas.h>

MODULE = main PACKAGE = main

NV
do_calc()
CODE:
  int i;
  double A[6] = {1.0, 2.0, 1.0, -3.0, 4.0, -1.0};
  double B[6] = {1.0, 2.0, 1.0, -3.0, 4.0, -1.0};
  double C[9] = {.5, .5, .5, .5, .5, .5, .5, .5, .5};
  cblas_dgemm(CblasColMajor, CblasNoTrans, CblasTrans,
              3, 3, 2, 1, A, 3, B, 3, 2, C, 3);
  RETVAL = fabs(C[0]-11) + fabs(C[4]-21);
OUTPUT:
  RETVAL
END
xs_ok $xs, with_subtest {
  cmp_ok do_calc(), '<', 2e-5;
};

# ffi_ok { symbols => [...] }, with_subtest {
#   my $ffi = shift;
#   ...
# };

done_testing;
