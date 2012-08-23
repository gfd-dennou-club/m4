# _DC_FORTRAN_MODULE_FLAG
#-------------------------------------------------------------------------
# Authors:: Youhei SASAKI, Eizi TOYODA, Yasuhiro Morikawa
# Copyright:: 2002-2012 DCMODEL Development Group, All rights, reserved.
# License:: MIT(Expat), See COPYRIGHT in detail
#-------------------------------------------------------------------------
AC_DEFUN([DC_FORTRAN_MODULE_FLAG],
         [AC_CACHE_CHECK([$FC's modules include flag],
                         [ax_cv_fortran_modflag],
         [AC_LANG_PUSH(Fortran)
          AC_FC_SRCEXT(f90)
i=0
while test \( -f tmpdir_$i \) -o \( -d tmpdir_$i \) ; do
  i=`expr $i + 1`
done
mkdir tmpdir_$i
cd tmpdir_$i
AC_COMPILE_IFELSE([module conftest_module
   contains
   subroutine conftest_routine
   character(len=4) :: a = "test"
   print '(a)', a
   end subroutine conftest_routine
   end module conftest_module
],[],[])
cd ..
ax_cv_fortran_modflag="NG"
for ax_flag in "-I" "-M" "-p"; do
  if test x"$ax_cv_fortran_modflag" = x"NG" ; then
    ax_save_FCFLAGS="$FCFLAGS"
    FCFLAGS="$ax_save_FCFLAGS ${ax_flag}tmpdir_$i"
    AC_COMPILE_IFELSE([program conftest_program
      use conftest_module
      call conftest_routine
      end program conftest_program
    ],[ax_cv_fortran_modflag="$ax_flag"],[])
    FCFLAGS="$ax_save_FCFLAGS"
  fi
done
rm -fr tmpdir_$i
AC_LANG_POP(Fortran)
])])
