# _DC_FORTRAN_CHECK
#------------------------------------------------------------------------
# Authors:: Youhei SASAKI
# Copyright:: 2012 DCMODEL Development Group, All rights, reserved.
# License:: MIT(Expat), See COPYRIGHT in detail
# MEMO:: Need update for fortran >= 95 sample program
#------------------------------------------------------------------------
AC_DEFUN([DC_FORTRAN_CHECK],
         [AC_CACHE_CHECK(
           [$FC can handle fortran >= 90 program.],
           [ac_cv_f90_check],
           [AC_LANG_PUSH(Fortran)
            AC_FC_SRCEXT(f90)
            ax_f90_check=""
            AC_COMPILE_IFELSE([
program conftest
  real, parameter :: a = 3.141592
end program conftest
                              ],[ax_f90_check="OK"],[ax_f90_check="NG"])
            ac_cv_f90_check=$ax_f90_check
            AC_LANG_POP(Fortran)
           ])
        ])
