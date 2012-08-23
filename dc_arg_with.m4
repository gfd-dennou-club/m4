# _DC_ARG_WITH
#------------------------------------------------------------------------
# Authors:: Youhei SASAKI, Eizi TOYODA
# Copyright:: 2002-2012 DCMODEL Development Group, All rights, reserved.
# License:: MIT(Expat), See COPYRIGHT in detail
#------------------------------------------------------------------------
AC_DEFUN([DC_ARG_WITH],
[AC_ARG_WITH([$1],
             AC_HELP_STRING([--with-$1], [$2]),
             [$3=$withval],
             [AC_CACHE_CHECK([$2], $3, [$4])])
             ])
