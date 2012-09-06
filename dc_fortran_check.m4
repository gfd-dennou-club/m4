# _DC_FORTRAN_CHECK
#------------------------------------------------------------------------
# Authors:: Youhei SASAKI
# Copyright:: 2012 DCMODEL Development Group, All rights, reserved.
# License:: MIT(Expat), See COPYRIGHT in detail
# MEMO:: Need update for fortran >= 95 sample program
#------------------------------------------------------------------------
AC_DEFUN([DC_FORTRAN_CHECK],
[
AC_CACHE_CHECK(
 [$FC can handle fortran >= 90 program.],
 [ac_cv_dcf90_check],
 [
  AC_LANG_PUSH(Fortran)
  ax_f90_check=""
  AC_COMPILE_IFELSE([
program conftest
  real, parameter :: a = 3.141592
end program conftest
                     ],[ax_f90_check="yes"],[ax_f90_check="no"])
  ac_cv_dcf90_check=$ax_f90_check
  AC_LANG_POP(Fortran)
  if test x"$ac_cv_dcf90_check" = x"no" ; then
    AC_MSG_ERROR([$FC can not handle fortran >= 90 program.])
  fi
 ])
])
