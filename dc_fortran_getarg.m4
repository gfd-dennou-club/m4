# _DC_FORTRAN_GETARG
#-------------------------------------------------------------------------
# Authors:: Youhei SASAKI, Eizi TOYODA
# Copyright:: 2002-2012 DCMODEL Development Group, All rights, reserved.
# License:: MIT(Expat), See COPYRIGHT in detail
#-------------------------------------------------------------------------
AC_DEFUN([DC_FORTRAN_GETARG],
         [AC_CACHE_CHECK(
           [Check Fortran GETARG implementation],
           [ac_cv_sysdeparg],
           [AC_LANG_PUSH(Fortran)
            AC_FC_SRCEXT(f90)
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
            ac_cv_sysdeparg=$ax_getarg
            AC_LANG_POP(Fortran)
           ])
         ])
