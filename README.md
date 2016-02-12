Unofficial m4 macro
===================

"Unofficial" means "there are not part of GNU Autoconf-macro archives".

Current maintainer is Youhei SASAKI <uwabami@gfd-dennou.org>

dc_args_with.m4: handling "--with-foo" with cache support
---------------------------------------------------------

USAGE:
```m4
DC_ARG_WITH(
[foo],            #=> --with-foo
[description],    #=> output of "configure --help"
ac_cv_foo)        #=> autoconf variable, don't add line-break
```

dc_fortran_check.m4: fortran (>=90) checker
-------------------------------------------

USAGE:
```m4
DC_FORTRAN_CHECK
```

dc_fortran_module_type.m4: check module type
--------------------------------------------

This is similar "ax_f90_module_extension.m4" by GNU Autoconf-macro archives,
but support Fujitsu Fortran Driver and HITACHI FORTRAN 90.

USAGE:
```m4
DC_FORTRAN_MODULE_TYPE
AC_SUBST(F90MODTYPE, ${ac_cv_dcf90_modtype})
AC_SUBST(MODEXT, ${ac_cv_dcf90_modext})
```

dc_fortran_module_flag.m4: check module inclusion flag
------------------------------------------------------

This is similar "ax_f90_module_flag.m4" by GNU Autoconf-macro archives, but
support Fujitsu Fortran Driver and HITACHI FORTRAN 90.

USAGE:
```m4
DC_FORTRAN_MODULE_FLAG
AC_SUBST(MODPATHFLAG, ${ac_cv_dcf90_modflag})
```

dc_fortran_library_check.m4: check LIBRARY flags already included
-----------------------------------------------------------------

Some environment (e.g. CRAY module system) add FCFLAGS, LDLIBS for
specific library (e.g. LAPACK).

USAGE:
```m4
  DC_ARG_ENABLE([lapack],
    [compile with LAPACK [default=no]],
    [ac_cv_try_lapack])
  if test x"$ac_cv_try_lapack" != x"no" ; then
    DC_FORTRAN_LIBRARY_CHECK(
    [lapack],[real(8) :: alu(2,2), bb(2)
  integer :: kp(2), icon
  alu(1,:) = (/1.0d0,1.0d0/)
  alu(2,:) = (/1.0d0,0.0d0/)
  bb(:)    = (/2.0d0,0.0d0/)
  call dgetrf( 2, 2, alu, 2, kp, icon )
  call dgetrs('N', 2, 1, alu, 2, kp, bb, 2, icon)])
```

This example set "$ac_cv_f90lib_lapack_check" = "yes" or
call AC_MSG_ERROR([specifiy lapack library file name with --with-$1=])

dc_fortran_get{arg,env}.m4: check GET{ARG,ENV} implementation
-------------------------------------------------------------

Check getarg, getenv implementation.
USAGE:
```m4
  DC_ARG_WITH(
    [getarg],
    [GETARG runtime procedure:(f2003std|nostd)],
    ac_cv_dcf90_sysdeparg)
  DC_FORTRAN_GETARG_CHECK
  AC_SUBST(SYSDEPARG, $ac_cv_dcf90_sysdeparg)
```
and
```m4
  DC_ARG_WITH(
    [getenv],
    [GETENV runtime procedure:(f2003std|nostd)],
    ac_cv_dcf90_sysdepenv)
  DC_FORTRAN_GETENV_CHECK
  AC_SUBST(SYSDEPENV, $ac_cv_dcf90_sysdepenv)
```
