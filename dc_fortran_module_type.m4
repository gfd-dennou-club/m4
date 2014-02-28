# _DC_FORTRAN_MODULE_TYPE
#---------------------------------------------------------------
# Authors:: Youhei SASAKI, Eizi TOYODA, Yasuhiro Morikawa
# Copyright:: 2002-2012 DCMODEL Development Group, All rights, reserved.
# License:: MIT(Expat), See COPYRIGHT in detail
# MEMO:: Add suppot HITACHI, Fujitsu Compiler
#---------------------------------------------------------------
AC_DEFUN([DC_FORTRAN_MODULE_TYPE],
[
AC_CACHE_CHECK(
[$FC module type],
[ac_cv_dcf90_modtype],
[
AC_LANG_PUSH(Fortran)
i=0
while test \( -f tmpdir_$i \) -o \( -d tmpdir_$i \) ; do
  i=`expr $i + 1`
done
mkdir tmpdir_$i
cd tmpdir_$i
cat <<EOF > conftes1.f90
module conftesa
logical :: b = .false.
end module conftesa
EOF
$FC $FCFLAGS -c conftes1.f90 1> /dev/null 2>&1
ac_cv_dcf90_modtype="NG"
if test -f conftes1.d ; then
  ac_cv_dcf90_modtype=intel.d
elif test -f CONFTESA.mod ; then
  ac_cv_dcf90_modtype=HP.mod
elif test -f conftesa.mod ; then
  ac_cv_dcf90_modtype=std.mod
else
  cat <<EOF > conftes2.f90
program conftes2
use conftesa, only: b
b = .true.
end program conftes2
EOF
  ln conftes1.f90 conftesa.f90
  if $FC $FCFLAGS -c conftes2.f90 1>/dev/null 2>&1 && test -f contes2.o  ; then
     ac_cv_dcf90_modtype=hitachi.f90
  elif $FC $FCFLAGS -c -Am conftes1.f90 && $FC $FCFLAGS -c -Am conftes2.f90 1>/dev/null 2>&1 ;then
     ac_cv_dcf90_modtype=fqs.mod
  fi
fi
cd ..
rm -fr tmpdir_$i
AC_LANG_POP(Fortran)
if test x"$ac_cv_dcf90_modtype" = x"NG" ; then
  AC_MSG_ERROR([unable to find $FC module type])
fi
])
ac_cv_dcf90_modext="NG"
case "${ac_cv_dcf90_modtype:-undef}" in
intel.d)
  ac_cv_dcf90_modext=.d
  ;;
HP.mod|std.mod|fqs.mod)
  ac_cv_dcf90_modext=.mod
  ;;
hitachi.f90)
  ac_cv_dcf90_modext=.f90
  ;;
esac
])
