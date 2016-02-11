# _DC_ARG_ENABLE
#---------------------------------------------------------------
# Authors:: Eizi TOYODA, Yasuhiro Morikawa, Youhei SASAKI
# Version:: $Id:$
# Copyright:: SPMODEL Development Group, All rights, reserved.
# License:: MIT-Like, See COPYRIGHT
#---------------------------------------------------------------
AC_DEFUN([DC_ARG_ENABLE],
[
  AC_ARG_ENABLE([$1],
  AC_HELP_STRING([--enable-$1],[$2]),[
    if test x"$enableval" != x"" ; then
      AC_MSG_CHECKING([$2])
      $3=$enableval
      AC_MSG_RESULT([$$3])
    fi
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
