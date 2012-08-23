# _DC_FORTRAN_GETENV
#-------------------------------------------------------------------------
# Authors:: Youhei SASAKI, Eizi TOYODA
# Copyright:: 2002-2012 DCMODEL Development Group, All rights, reserved.
# License:: MIT(Expat), See COPYRIGHT in detail
#-------------------------------------------------------------------------
AC_DEFUN([DC_FORTRAN_GETENV],
         [AC_CACHE_CHECK(
           [Fortran GETENV implementation],
           [ac_cv_sysdepenv],
           [AC_LANG_PUSH(Fortran)
            AC_FC_SRCEXT(f90)
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
            if test x"$ax_getenv" = x"" ; then
               ac_cv_sysdepenv=nogetenv
            else
               ac_cv_sysdepenv=$ax_getenv
            fi
            AC_LANG_POP(Fortran)
           ])
         ])
