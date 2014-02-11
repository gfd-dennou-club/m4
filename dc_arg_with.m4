# _DC_ARG_WITH
#------------------------------------------------------------------------
# Authors:: Youhei SASAKI, Eizi TOYODA
# Copyright:: 2002-2012 DCMODEL Development Group, All rights, reserved.
# License:: MIT(Expat), See COPYRIGHT in detail
# MEMO:: Wrapper for AC_ARG_WITH, cache support
#------------------------------------------------------------------------
AC_DEFUN([DC_ARG_WITH],
[
  AC_ARG_WITH([$1],
    AC_HELP_STRING([--with-$1],[$2]),
    [
    AC_MSG_CHECKING([$2])
    if test x"$withval" != x"" ; then
      $3=$withval
    else
      $3=no
    fi
    AC_MSG_RESULT([$$3])
    ],
   [AC_CACHE_CHECK(
     [$2],
     [$3],
     [
     if test x"$$3" != x"no" ; then
       $3=no
     fi
     ])
  ])
])
#    ]
#  )
