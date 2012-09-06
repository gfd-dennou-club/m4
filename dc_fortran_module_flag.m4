# _DC_FORTRAN_MODULE_FLAG
#-------------------------------------------------------------------------
# Authors:: Youhei SASAKI, Eizi TOYODA, Yasuhiro Morikawa
# Copyright:: 2002-2012 DCMODEL Development Group, All rights, reserved.
# License:: MIT(Expat), See COPYRIGHT in detail
# MEMO: Check module path flags.
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
  AC_MSG_ERROR([unable to find $FC's module include flag]) #'
fi
])
AC_SUBST(MODPATHFLAG, ${ac_cv_dcf90_modflag})
])
