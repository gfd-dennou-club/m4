# DC_FORTRAN_LIBRARY_CHECK
#---------------------------------------------------------------
# Authors:: Youhei SASAKI
# Copyright:: 2014 DCMODEL Development Group, All rights, reserved.
# License:: MIT(Expat), See COPYRIGHT in detail
#---------------------------------------------------------------
AC_DEFUN([DC_FORTRAN_LIBRARY_CHECK],[
  AC_LANG_PUSH(Fortran)
  ac_cv_dcf90_library_check=""
  AC_MSG_CHECKING([try compile $1 test without any flags])
  AC_LINK_IFELSE([
program libcheck
$2
end program libcheck],
  [ac_cv_dcf90_library_check="yes"],
  [ac_cv_dcf90_library_check="no"])
  ac_cv_f90lib_$1_check=$ac_cv_dcf90_library_check
  AC_LANG_POP(Fortran)
  if test x"$ac_cv_f90lib_$1_check" = x"no" ; then
    AC_MSG_RESULT([failed])
    AC_MSG_ERROR([specify $1 library file name with --with-$1=])
  else
    AC_MSG_RESULT([ok])
  fi
])
