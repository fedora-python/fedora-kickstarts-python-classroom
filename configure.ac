AC_INIT([spin-kickstarts], 0.11.0)
AC_SUBST([RELEASE], 2)

ALL_LINGUAS="bn_IN bn ca cs da de el es fi fr gl gu hi hr hu is it ja ko ml ms nb nl or pa pl pt pt_BR ru sk sl sr@latin sr sv ta tr uk zh_CN zh_TW"

AM_INIT_AUTOMAKE
AM_MAINTAINER_MODE

#dnl prevent to copy po/Makefile.in.in
#GETTEXT_PACKAGE=revisor
#AC_SUBST(GETTEXT_PACKAGE)
#AM_GLIB_GNU_GETTEXT
#AC_PROG_INTLTOOL
#AC_PROG_LN_S

AC_SUBST(DATESTAMP,`date +"%a %b %d %Y"`)

AC_CONFIG_FILES([
Makefile
spin-kickstarts.spec
])

AC_OUTPUT
