AC_PREREQ([2.68])
AC_INIT([M4GB], [1.0.0], [marc@marc-stevens.nl],[m4gb],[https://github.com/cr-marcstevens/m4gb])
AC_CONFIG_SRCDIR([README.md])
AC_CONFIG_HEADERS([config.h])
AX_PREFIX_CONFIG_H([lib/config.h])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([foreign subdir-objects])

DEFAULT_CXXFLAGS="-O3 -Wall -Wfatal-errors"
AS_IF([test "x$CXXFLAGS" = "x"],
	[CXXFLAGS="$DEFAULT_CXXFLAGS"]
	[usedefaultcxxflags=yes],
	[usedefaultcxxflags=no])

LT_INIT

AC_PROG_INSTALL
AC_PROG_MAKE_SET
AC_PROG_LN_S
AC_PROG_MKDIR_P
AC_PROG_GREP

AC_LANG([C++])
AC_PROG_CXX
AX_CXX_COMPILE_STDCXX([11], [noext],[mandatory])


AC_TYPE_SIZE_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT64_T
AC_TYPE_UINT8_T


AS_IF([test "x$cross_compiling" != "xyes" && test "x$usedefaultcxxflags" = "xyes" ],
      [AX_CHECK_COMPILE_FLAG([-march=native], [CXXFLAGS="$CXXFLAGS -march=native"], [])])


AX_PTHREAD()
LIBS="$PTHREAD_LIBS $LIBS"
CXXFLAGS="$CXXFLAGS $PTHREAD_CFLAGS"


AX_OPENF4


AX_FGB


AC_ARG_ENABLE([sanitize], AS_HELP_STRING([--enable-sanitize@<:@=yes|no@:>@],[Enable -fsanitize=address (default no)])
	,[do_sanitize=$enableval],[do_sanitize=no])
AS_IF([test "$do_sanitize" = "yes"],[
		CXXFLAGS="$CXXFLAGS -fsanitize=address -fno-omit-frame-pointer -fuse-ld=gold"
		LDFLAGS="$LDFLAGS -fsanitize=address -fuse-ld=gold"
	])


AC_CONFIG_FILES([
 Makefile
])

AC_OUTPUT
