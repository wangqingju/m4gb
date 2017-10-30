# ax_openf4.m4: An m4 macro to detect and configure OpenF4
#
# Copyright  2017 Marc Stevens <marc.stevens@cwi.nl>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#
# As a special exception to the GNU General Public License, if you
# distribute this file as part of a program that contains a
# configuration script generated by Autoconf, you may include it under
# the same distribution terms that you use for the rest of that program.
#

#
# SYNOPSIS
#       AX_OPENF4()
#
# DESCRIPTION
#       Checks the existence of OpenF4 headers and libraries.
#       Options:
#       --with-openf4=(path|yes|no)
#               Indicates whether to use OpenF4 or not, and the path of a non-standard
#               installation location of OpenF4 if necessary.
#
#       This macro calls:
#               AC_SUBST(OPENF4_CPPFLAGS)
#               AC_SUBST(OPENF4_LDFLAGS)
#               AC_SUBST(OPENF4_LIB)
#
AC_DEFUN([AX_OPENF4],
[
OPENF4DIR=${OPENF4DIR:-$(pwd)/openf4}
AC_ARG_WITH([openf4], AS_HELP_STRING([--with-openf4@<:@=yes|no|DIR@:>@],[prefix where openf4 is installed (default=yes)]),
[
	if test "$withval" = "no"; then
		want_openf4="no"
	elif test "$withval" = "yes"; then
		want_openf4="yes"
	else
		want_openf4="yes"
		OPENF4DIR=$withval
	fi
],[
	want_openf4="maybe"
]
)

have_openf4=no
if test "x$want_openf4" != "xno"; then
	CPPFLAGS_SAVED="$CPPFLAGS"
	LDFLAGS_SAVED="$LDFLAGS"
	LIBS_SAVED="$LIBS"

	if test "x$OPENF4DIR" != "x" && test -d $OPENF4DIR/include; then
		OPENF4_CPPFLAGS="-I$OPENF4DIR/include"
		OPENF4_LDFLAGS="-L$OPENF4DIR/lib"
	else
		OPENF4_CPPFLAGS=""
		OPENF4_LDFLAGS=""
	fi
	OPENF4_LIB=-lopenf4
	CPPFLAGS="$OPENF4_CPPFLAGS $CPPFLAGS"
	LDFLAGS="$OPENF4_LDFLAGS $LDFLAGS"
	LIBS="$OPENF4_LIB $LIBS"

	have_openf4=yes
	AC_DEFINE(OPENF4_GLOBAL_H,1,[Force exclusion of openf4/include/config.h])
	AC_CHECK_HEADER([libopenf4.h],[],[have_openf4=no])
	AC_MSG_CHECKING(for usability of OpenF4)
	AC_LINK_IFELSE([AC_LANG_SOURCE([
		#include <libopenf4.h>
		int main() {
			std::vector<std::string> tmp;
			groebnerBasisF4 (0,0,tmp,tmp,0,0);
		}
		])],
		[AC_MSG_RESULT(yes)],
		[AC_MSG_RESULT(no)
		have_openf4=no])

	AS_IF([test "x$have_openf4" = "yes"],
		[AC_DEFINE(HAVE_OPENF4,1,[Define if OpenF4 is installed])],
		[AS_IF([test "x$want_openf4" = "yes"],[AC_MSG_ERROR(error: see log)],[])])
	CPPFLAGS="$CPPFLAGS_SAVED"
	LDFLAGS="$LDFLAGS_SAVED"
	LIBS="$LIBS_SAVED"
fi

AM_CONDITIONAL(HAVE_OPENF4, test "x${have_openf4}" = "xyes")

AC_SUBST(OPENF4_CPPFLAGS)
AC_SUBST(OPENF4_LDFLAGS)
AC_SUBST(OPENF4_LIB)

])
