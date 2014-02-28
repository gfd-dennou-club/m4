# _DC_FORTRAN_GETARG
#-------------------------------------------------------------------------
# Authors:: Youhei SASAKI, Eizi TOYODA
# Copyright:: 2002-2012 DCMODEL Development Group, All rights, reserved.
# License:: MIT(Expat), See COPYRIGHT in detail
# MEMO :: check implementation of GETARG
#-------------------------------------------------------------------------
AC_DEFUN([DC_FORTRAN_GETARG_CHECK],
[
AC_LANG_PUSH(Fortran)
AC_COMPILE_IFELSE([
program conftest
  call get_command_argument(1)
end program conftest
],[ax_getarg=f2003std],[ax_getarg=""])
if test x"$ax_getarg" = x"" ; then
  AC_COMPILE_IFELSE([
program conftest
  character(1) :: arg
  call getarg(1, arg)
end program conftest
  ],[ax_getarg=nostd],[ax_getarg=""])
fi
AC_LANG_POP(Fortran)
ac_cv_dcf90_sysdeparg=$ax_getarg
if test x"$ac_cv_dcf90_sysdeparg" = x"" ; then
  AC_MSG_ERROR([Can not find GETARG implementation. Please reconfigure --with-getarg={f2003std,nostd,hitachi}])
fi
])

AC_DEFUN([DC_FORTRAN_GETARG],
[
AC_CACHE_CHECK(
  [$FC GETARG implementation],
  [ac_cv_dcf90_sysdeparg],
  [
  DC_FORTRAN_GETARG_CHECK
  ])
if test x"$ac_cv_dcf90_sysdeparg" = x"no" ; then
  DC_FORTRAN_GETARG_CHECK
fi
case $ac_cv_dcf90_sysdeparg in
f2003std)
  AC_MSG_NOTICE([sysdeparg() calls GET_COMMAND_ARGUMENT])
  ;;
nostd)
  AC_MSG_NOTICE([sysdeparg() calls GETARG])
  ;;
hitachi)
  AC_MSG_NOTICE([sysdeparg() calls GETARG for Hitachi Fortran])
  ;;
*)
  AC_MSG_ERROR([Can't find GETARG implementation. Please reconfigure --with-getarg={f2003std,nostd}])
  ;;
esac
AC_SUBST(SYSDEPARG, $ac_cv_dcf90_sysdeparg)
])
