# _DC_FORTRAN_CHECK
#------------------------------------------------------------------------
# Authors:: Youhei SASAKI
# Copyright:: 2014 DCMODEL Development Group, All rights, reserved.
# License:: MIT/X11, See COPYRIGHT in detail
#------------------------------------------------------------------------
AC_DEFUN([DC_FORTRAN_F2003_CHECK],
[
AC_CACHE_CHECK(
 [$FC can handle fortran >= 2003 feature.],
 [ac_cv_dcf2003_check],
 [
  AC_LANG_PUSH(Fortran)
  ax_f2003_check=""
  AC_COMPILE_IFELSE([
program conftest
  use, intrinsic :: ISO_C_BINDING
  use, intrinsic :: ISO_FORTRAN_ENV
end program conftest
                     ],[ax_f2003_check="yes"],[ax_f2003_check="no"])
  ac_cv_dcf2003_check=$ax_f2003_check
  AC_LANG_POP(Fortran)
 ])
 AC_SUBST([F03ENABLE], [$ac_cv_dcf2003_check])
 if test x"$ac_cv_dcf2003_check" = x"yes"; then
   CPPFLAGS="$CPPFLAGS -DF03_FEATURE"
 fi
])
