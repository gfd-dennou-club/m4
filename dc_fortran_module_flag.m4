# _DC_FORTRAN_MODULE_FLAG
#-------------------------------------------------------------------------
# COPYRIGHT
#
#   Copyright (c) 2009 Luc Maisonobe <luc@spaceroots.org>
#   Copyright (c) 2009 Julian C. Cummings <cummings@cacr.caltech.edu>
#   Copyright (c) 2009 Alexander Pletzer <pletzer@txcorp.com>
#   Copyright (c) 2009-2014 Youhei SASAKI <uwabami@gfd-dennou.org>
#
# LICENSE
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.
#
# DESCRIPTION: This is enhanced version of "ax_f90_module_flag.m4"
#   Original Version:
#     http://www.gnu.org/software/autoconf-archive/ax_f90_module_flag.html
#
# MEMO:
#  - Fujitsu Fortran Driver: "-Am -I"
#  - HITACHI Fortran: "-mod"
#
#-------------------------------------------------------------------------
AC_DEFUN([DC_FORTRAN_MODULE_FLAG],
[
AC_CACHE_CHECK(
  [$FC module path include flag],
  [ac_cv_dcf90_modflag],
  [
AC_LANG_PUSH(Fortran)
i=0
while test \( -f tmpdir_$i \) -o \( -d tmpdir_$i \) ; do
  i=`expr $i + 1`
done
mkdir tmpdir_$i
cd tmpdir_$i
AC_COMPILE_IFELSE([
module conftest_module
  contains
    subroutine conftest_routine
      character(len=4) :: a = "test"
    print *, a
  end subroutine conftest_routine
end module conftest_module
],[],[])
cd ..
ac_cv_dcf90_modflag="NG"
for ax_flag in "-I" "-M" "-p" "-mod" "-Am -I" ; do
  if test x"$ac_cv_dcf90_modflag" = x"NG" ; then
    ac_save_FCFLAGS="$FCFLAGS"
    FCFLAGS="$ac_save_FCFLAGS ${ax_flag}tmpdir_$i"
    AC_COMPILE_IFELSE([program conftest_program
      use conftest_module
      call conftest_routine
      end program conftest_program
    ],[ac_cv_dcf90_modflag="$ax_flag"],[])
    FCFLAGS="$ac_save_FCFLAGS"
  fi
done
rm -fr tmpdir_$i
AC_LANG_POP(Fortran)
if test x"$ac_cv_dcf90_modflag" = x"NG" ; then
  AC_MSG_ERROR([unable to find $FC's compiler flag for modules inclusion]) #'
fi
])
])
