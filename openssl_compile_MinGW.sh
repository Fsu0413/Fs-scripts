#!/bin/bash

HELPER_SCRIPT=$0

# usage:
# showhelp
# only show help, does nothing
# return 0
showhelp()
{
	echo "OpenSSL for Windows compile helper script for MinGW using MSys2"
	echo "Usage:"
	echo "	$HELPER_SCRIPT PATH_TO_OPENSSL [-static]"
	echo
	echo "PATH_TO_OPENSSL points to the folder where OpenSSL is extracted."
	echo
	echo "Note: This script must be run with \". shell msys\"."
	echo
	return 0
}

getGccVersion()
{
	# We could get the things in a single run of GCC
	pushd /tmp
	
	cat > openssl_compile_MinGWver.c << EOF
#include "stdio.h"

int main()
{
	printf("LIBRESSL_GCC_VERSION=GCC%d.%d.%d;\n", __GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__);
	printf("export LIBRESSL_GCC_VERSION;\n");
	printf("LIBRESSL_MINGW_W64_VERSION=%s;\n", __MINGW64_VERSION_STR);
	printf("export LIBRESSL_MINGW_W64_VERSION;\n");
	printf("LIBRESSL_PLATFORM=%s;\n",
#if defined _WIN64 || defined __WIN64 || defined WIN64 || defined __WIN64__
	"x64"
#else
	"x86"
#endif
	);
	printf("export LIBRESSL_PLATFORM;\n");
	
	return 0;
}
EOF
	if ! gcc openssl_compile_MinGWver.c -static -static-libgcc -o openssl_compile_MinGWver.exe; then
		return 1;
	fi
	
	r=`./openssl_compile_MinGWver.exe`
	if [ $? -ne 0 ]; then
		return 1;
	fi
	
	eval $r

	popd
}

if [ $# -eq 0 ] || [ x$1 = x ]; then
	echo "PATH_TO_OPENSSL is not given, exit."
	showhelp
	exit 1
elif [ x$1 = x--help ] || [ x$1 = x-help ] || [ x$1 = x-h ]; then
	showhelp
	exit 0
elif [ ! -d $1 ] || [ ! -e $1/Configure ]; then
	echo "PATH_TO_OPENSSL doesn\'t exist or doesn\'t contain the Configure file, exit."
	showhelp
	exit 1
fi

LIBRESSL_PATH=`realpath $1`/

build_static=
if [ $# -ne 1 ]; then
	build_static=$2
fi

OPENSSL_VERSION=$(echo `sed 2q $LIBRESSL_PATH/README` | cut -d " " -f2)
OPENSSL_VERSION11=false
case $OPENSSL_VERSION in
	1.1*)
		OPENSSL_VERSION11=true
		;;
	*)
		;;
esac

if ! getGccVersion; then
	exit 1
fi

LIBRESSL_TARGET=
LIBRESSL_TARGETARG=
case $LIBRESSL_PLATFORM in
	x86)
		LIBRESSL_TARGET=x86
		LIBRESSL_TARGETARG=mingw
		;;
	x64)
		LIBRESSL_TARGET=x86_64
		LIBRESSL_TARGETARG=mingw64
		;;
	*)
		echo Todo....
		exit 1
esac

echo "openssl path: $LIBRESSL_PATH"
echo "Platform: $LIBRESSL_PLATFORM"
echo "MinGW-W64 Version: $LIBRESSL_MINGW_W64_VERSION"

# start!

CONFIGURE_DIRNAME=build-openssl$OPENSSL_VERSION-Windows-$LIBRESSL_TARGET-MinGW-$LIBRESSL_GCC_VERSION
if [ "x$build_static" = "x-static" ]; then
	CONFIGURE_DIRNAME=$CONFIGURE_DIRNAME-static
fi

if [ -d $CONFIGURE_DIRNAME ]; then
	rm -rf $CONFIGURE_DIRNAME
fi

mkdir $CONFIGURE_DIRNAME; cd $CONFIGURE_DIRNAME

CONFIGURE_SCRIPT=

if ! $OPENSSL_VERSION11; then
	cp -R $LIBRESSL_PATH/* .
	CONFIGURE_SCRIPT=Configure
else
	CONFIGURE_SCRIPT=$LIBRESSL_PATH/Configure
fi

INSTALLDIR=OpenSSL$OPENSSL_VERSION-Windows-$LIBRESSL_TARGET-MinGW-$LIBRESSL_GCC_VERSION

command="perl $CONFIGURE_SCRIPT "
if ! $OPENSSL_VERSION11; then
	if [ x$build_static = xstatic ]; then
		command="$command no-shared"
	else
		command="$command shared"
	fi
else
	if [ x$build_static = xstatic ]; then
		command="$command no-shared"
	else
		command="$command shared"
	fi
fi

if [ x$LIBRESSL_TARGET = xx86 ] && ! $OPENSSL_VERSION11; then
	# for unknown reason, using no-asm result in build failure when using 32-bit MinGW-w64 toolchain
	:
else
	# I prefer no-asm because it suits most consequences....
	command="$command no-asm"
	if [ "x$OPENSSL_VERSION" = "x1.0.2t" ]; then
		 sed -ibak "s/^OPENSSL_rdtsc\\s.*$//" util/libeay.num
	fi
fi

command=$command\ --prefix=`realpath ..`/$INSTALLDIR
command=$command\ --openssldir=`realpath ..`/$INSTALLDIR/ssl
command=$command\ $LIBRESSL_TARGETARG

echo $command
$command

res=$?

if [ $res -ne 0 ]; then
	exit 1
fi

# judge how many parallel builds we should have using /proc/cpuinfo if exist, otherwise default to -j3
PARALLELNUM=3
if [ -e /proc/cpuinfo ]; then
	PARALLELNUM=$(expr `cat /proc/cpuinfo | grep processor | wc -l` + 1 )
fi

MAKE_COMMAND="make -j$PARALLELNUM"
#MAKE_COMMAND="make -j1"
echo $MAKE_COMMAND
if ! $MAKE_COMMAND; then
	exit 1
fi

#if $OPENSSL_VERSION11; then
#	MAKETEST_COMMAND="make -j$PARALLELNUM test"
#	echo $MAKETEST_COMMAND
#	if ! $MAKETEST_COMMAND; then
#		exit 1
#	fi
#else
#	echo "Tests for OpenSSL 1.0.2 is known to fail due to file not found error, ignoring"
#fi

INSTALLTARGET="install_sw"
if $OPENSSL_VERSION11; then
	INSTALLTARGET="install_sw install_ssldirs"
fi

MAKEINSTALL_COMMAND="make $INSTALLTARGET"
echo $MAKEINSTALL_COMMAND
if ! $MAKEINSTALL_COMMAND; then
	exit 1
fi

cd ..
rm -rf $CONFIGURE_DIRNAME

