# _DC_FORTRAN_GETENV
#-------------------------------------------------------------------------
# Authors:: Youhei SASAKI, Eizi TOYODA
# Copyright:: 2002-2012 DCMODEL Development Group, All rights, reserved.
# License:: MIT(Expat), See COPYRIGHT in detail
#-------------------------------------------------------------------------
AC_DEFUN([DC_FORTRAN_GETENV_CHECK],
[
AC_LANG_PUSH(Fortran)
ax_getenv=""
AC_COMPILE_IFELSE([
program conftest
  call get_environment_variable('HOME')
end program conftest
],[ax_getenv=f2003std],[ax_getenv=""])
if test x"$ax_getenv" = x"" ; then
  AC_COMPILE_IFELSE([
program conftest
  character(len=255) :: home
  call getenv('HOME', home)
end program conftest
  ],[ax_getenv=nostd],[ax_getenv=""])
fi
AC_LANG_POP(Fortran)
if test x"$ax_getenv" = x"" ; then
  ac_cv_dcf90_sysdepenv=nogetenv
else
  ac_cv_dcf90_sysdepenv=$ax_getenv
fi
])

AC_DEFUN([DC_FORTRAN_GETENV],
[
AC_CACHE_CHECK(
  [$FC GETENV implementation],
  [ac_cv_dcf90_sysdepenv],
  [
  DC_FORTRAN_GETENV_CHECK
  ])
if test x"$ac_cv_dcf90_sysdepenv" = x"no" ; then
  DC_FORTRAN_GETENV_CHECK
fi
case $ac_cv_dcf90_sysdepenv in
f2003std)
    AC_MSG_NOTICE([sysdepenv() calls GET_ENVIRONMENT_VARIABLE])
    ;;
nostd)
    AC_MSG_NOTICE([sysdepenv() calls GETENV])
    ;;
nogetenv)
    AC_MSG_NOTICE([sysdepenv() calls DUMMY procdrures])
    ;;
*)
    AC_MSG_ERROR([Can't find GETENV implementation. Please reconfigure --with-getenv={f2003std,nostd,nogetenv}]) #'
    ;;
esac
])
