#!/bin/bash

HELPER_SCRIPT=$0

# usage:
# showhelp
# only show help, does nothing
# return 0
showhelp()
{
	echo "OpenSSL for android compile helper script for Bash shell in Unix-like system or MSys2"
	echo "Usage:"
	echo "	$HELPER_SCRIPT PATH_TO_OPENSSL ARCHITECTURE [NDKROOT] [ANDROID_PLATFORM] [USE_CLANG]"
	echo
	echo "PATH_TO_OPENSSL points to the folder where OpenSSL is extracted."
	echo
	echo "ARCHITECTURE is one of:"
	echo "	arm (armeabi armv7)"
	echo "	arm64 (aarch64 armv8)"
	echo "	x86 (i386)"
	echo "	x86_64 (x64 amd64)"
	echo
	echo "NDKROOT points to the folder where there is ndk_build script(although we don't use this)"
	echo "If not given, it defaults to \$ANDROID_NDK_ROOT."
	echo "If \$ANDROID_NDK_ROOT is not given, we detect it in the current directory."
	echo
	echo "ANDROID_PLATFORM is the target platform version."
	echo "If not given or given to \"auto\", it is 21"
	echo
	echo "USE_CLANG means whether we use clang as compiler, default is true."
	echo "use one of false/no/gcc/0 to use the deprecated GCC compiler."
	echo
	return 0
}

# usage:
# normalize_arch ARCH
# it will export the normalized arch string to ANDROID_ARCH
# it will export the compiler name to ANDROID_COMPILER_NAME
# it will export the proper cflags to CFLAGS and the proper lflags to LFLAGS
# return 0 for success, 1 when this function cannot judge the arch given.
normalize_arch()
{
	ANDROID_ABI=$1
	ANDROID_ABI11=$1
	COMPILER_NAME=$1-linux-android
	COMPILER_CFLAGS=
	COMPILER_TARGET=
	if [ x$1 = xarmeabi ] || [ x$1 = xarmv7 ] || [ x$1 = xarm ]; then
		ANDROID_ABI=android-armv7
		ANDROID_ABI11=android-arm
		COMPILER_CFLAGS="-march=armv7-a -mfloat-abi=softfp -mfpu=vfp -fno-builtin-memmove -mthumb"
		COMPILER_TARGET=arm-linux-androideabi
		ANDROID_TOOLCHAIN=arm-linux-androideabi-4.9
		ANDROID_TOOLCHAIN_CLANG=arm-linux-androideabi-clang3.6
		ANDROID_ARCH=arm
	elif [ x$1 = xaarch64 ] || [ x$1 = xarmv8 ] || [ x$1 = xarm64 ]; then
		ANDROID_ABI=linux-aarch64
		ANDROID_ABI11=android-arm64
		COMPILER_TARGET=aarch64-linux-android
		ANDROID_TOOLCHAIN=aarch64-linux-android-4.9
		ANDROID_TOOLCHAIN_CLANG=aarch64-linux-android-clang3.6
		ANDROID_ARCH=arm64
	elif [ x$1 = xi386 ] || [ x$1 = xx86 ]; then
		ANDROID_ABI=android-x86
		ANDROID_ABI11=android-x86
		COMPILER_TARGET=i686-linux-android
		ANDROID_TOOLCHAIN=x86-4.9
		ANDROID_TOOLCHAIN_CLANG=x86-clang3.6
		ANDROID_ARCH=x86
	elif [ x$1 = xx64 ] || [ x$1 = xamd64 ] || [ x$1 = xx86_64 ]; then
		ANDROID_ABI=linux-x86_64
		ANDROID_ABI11=android-x86_64
		COMPILER_TARGET=x86_64-linux-android
		ANDROID_TOOLCHAIN=x86_64-4.9
		ANDROID_TOOLCHAIN_CLANG=x86_64-clang3.6
		ANDROID_ARCH=x86_64
	fi
	if [ x$ANDROID_ARCH != xarm ] && [ x$ANDROID_ARCH != xarm64 ] && [ x$ANDROID_ARCH != xx86 ] && [ x$ANDROID_ARCH != xx86_64 ]; then
		ANDROID_ABI=
	fi
	export LIBRESSL_ANDROID_CFLAGS="$COMPILER_CFLAGS -fstack-protector-strong -fPIC"
	export LIBRESSL_ANDROID_LFLAGS=" -Wl,-s -Wl,-z,noexecstack"
	export LIBRESSL_ANDROID_ABI=$ANDROID_ABI
	export LIBRESSL_ANDROID_ABI11=$ANDROID_ABI11
	export LIBRESSL_ANDROID_TOOLCHAIN=$ANDROID_TOOLCHAIN
	export LIBRESSL_ANDROID_TOOLCHAIN_CLANG=$ANDROID_TOOLCHAIN_CLANG
	export LIBRESSL_ANDROID_ARCH=$ANDROID_ARCH
	export LIBRESSL_ANDROID_TARGET=$COMPILER_TARGET
	[ x$ANDROID_ARCH != x ]
	return $?
}

get_library_suffix()
{
	LIBRARY_SUFFIX=
	if [ x$1 = xarmeabi ] || [ x$1 = xarmv7 ] || [ x$1 = xarm ]; then
		LIBRARY_SUFFIX=armeabi-v7a
	elif [ x$1 = xaarch64 ] || [ x$1 = xarmv8 ] || [ x$1 = xarm64 ]; then
		LIBRARY_SUFFIX=arm64-v8a
	elif [ x$1 = xi386 ] || [ x$1 = xx86 ]; then
		LIBRARY_SUFFIX=x86
	elif [ x$1 = xx64 ] || [ x$1 = xamd64 ] || [ x$1 = xx86_64 ]; then
		LIBRARY_SUFFIX=x86_64
	fi
	export LIBRESSL_LIBRARY_SUFFIX=$LIBRARY_SUFFIX
}

# usage:
# find_ndk_current
# it will find the NDK in the current dir, the name of the dir must be android-ndk-XXXX, currently it only supports r11 or higher
# return 0 for success, 1 for not found
find_ndk_current()
{
	x=
	for i in `find -maxdepth 1 -mindepth 1 -type d`; do
		case "$i" in
		./android-ndk-r[0-9]*)
			if [ -e $i/build/tools/make-standalone-toolchain.sh ]; then
				x=$x\ "$i"
			fi
			;;
		*)
			:
			;;
		esac
	done

	y="./android-ndk-r0"
	r="\\.\\/android-ndk-r([0-9]+)(.?)"
	for i in $x; do
		m=`echo $i | sed -E "s,$r,\\1,"`
		p=`echo $i | sed -E "s,$r,\\2,"`
		my=`echo $y | sed -E "s,$r,\\1,"`
		py=`echo $y | sed -E "s,$r,\\2,"`
		gt=false
		if [ $m -gt $my ]; then
			gt=true
		elif [ $m -eq $my ]; then
			if [ x"$p" ">" x"$py" ]; then
				gt=true
			fi
		fi
		if $gt; then
			y=$i
		fi
	done

	if ! [ -d $y ]; then
		return 1
	fi

	export ANDROID_NDK_ROOT=`realpath $y`
	return 0
}

# usage:
# find_ndk [directory] or ANDROID_NDK_ROOT=directory find_ndk
# if directory is set, check the existance and the ndk-build script file.
# if directory is not set, find the NDK in the current dir (using find_ndk_current)
# this function will export an environment variable called ANDROID_NDK_ROOT
# return 0 for success, 1 for not found when directory is not given, 2 for not usable when directory is given
find_ndk()
{
	if [ $# -gt 0 ]; then
		ANDROID_NDK_ROOT=$1
	elif [ x$ANDROID_NDK_ROOT = x ]; then
		find_ndk_current
		return $?
	fi

	# also check the make-standalone-toolchain.sh....
	if [ ! -d $ANDROID_NDK_ROOT ] || [ ! -e $ANDROID_NDK_ROOT/build/tools/make-standalone-toolchain.sh ]; then
		return 2
	fi
	export ANDROID_NDK_ROOT=`realpath $ANDROID_NDK_ROOT`
	return 0
}

detect_buildall()
{
	if [ x$1 = xall ] || [ x$1 = xentire ]; then
		return 0
	fi
	return 1
}

if [ $# -eq 0 ] ||  [ x$1 = x ]; then
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

build_arch=arm
if [ $# -ne 1 ]; then
	build_arch=$2
fi

build_all=0
if detect_buildall $build_arch; then
	build_all=1
elif ! normalize_arch $build_arch; then
	echo "unknown ARCH: $build_arch, exit."
	showhelp
	exit 2
fi

res=
if [ $# -ge 3 ]; then
	find_ndk $3
	res=$?
else
	find_ndk
	res=$?
fi

if [ $res -ne 0 ]; then
	echo -n "Can not find NDK"
	if [ $# -ge 3 ]; then
		echo -n ": $3"
	fi
	echo ", exit."
	showhelp
	exit 3
fi

ANDROID_VER=21
if [ $# -ge 4 ] && ! [ x$4 = xauto ]; then
	ANDROID_VER=$4
fi

ANDROID_TOOLCHAIN=clang
if [ $# -ge 5 ]; then
	if [ x$5 = xno ] || [ x$5 = xfalse ] || [ x$5 = xgcc ] || [ x$5 = x0 ]; then
		ANDROID_TOOLCHAIN=gcc
	fi
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

case $LIBRESSL_ANDROID_ABI in
	*64*)
		if ! $OPENSSL_VERSION11; then
			echo "OpenSSL version before 1.1 does not support 64-bit android. Falling back to generic $LIBRESSL_ANDROID_ABI."
		fi
		;;
esac

if [ $build_all -eq 1 ]; then
	# since we always exit this script when using build_all, we can modify ANDROID_VER to "auto" to simplify the logic
	archs="arm arm64 x86 x86_64"
	if [ $ANDROID_VER -lt 21 ]; then
		# only 32-bit variants are built when API Level is less than 21
		# only 32-bit variants are supported before OpenSSL 1.1
		archs="arm x86"
	fi
	rm -rf OpenSSL$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-ALL
	mkdir OpenSSL$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-ALL
	mkdir OpenSSL$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-ALL/lib
	mkdir OpenSSL$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-ALL/bin
	for arch in $archs; do
		COMMAND="$0 $LIBRESSL_PATH $arch $ANDROID_NDK_ROOT $ANDROID_VER $ANDROID_TOOLCHAIN"
		echo $COMMAND
		$COMMAND
		res=$?
		if [ $res -ne 0 ]; then
			exit $res
		fi
		get_library_suffix $arch
		cp OpenSSL$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-$arch/lib/libssl.a OpenSSL$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-ALL/lib/libssl_$LIBRESSL_LIBRARY_SUFFIX.a
		cp OpenSSL$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-$arch/lib/libcrypto.a OpenSSL$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-ALL/lib/libcrypto_$LIBRESSL_LIBRARY_SUFFIX.a
		cp OpenSSL$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-$arch/bin/openssl OpenSSL$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-ALL/bin/openssl_$LIBRESSL_LIBRARY_SUFFIX
		if [ "x$arch" = "xarm64" ]; then
			cp -R OpenSSL$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-$arch/include OpenSSL$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-ALL/include
			cp -R OpenSSL$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-$arch/ssl OpenSSL$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-ALL/ssl
		fi
		rm -rf OpenSSL$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-$arch
	done
	exit 0
fi

echo "openssl path: $LIBRESSL_PATH"
echo "android arch: $LIBRESSL_ANDROID_ABI"
echo "NDK root: $ANDROID_NDK_ROOT"
echo "Use ANDROID_TOOLCHAIN: $ANDROID_TOOLCHAIN"

MSYSPYTHON=false
if [ `uname -o` = Msys ]; then
	# We assumes we are running under msys2
	# We should use an MinGW python and an MSYS perl when building OpenSSL 1.1..... Why don't they use CMake?
	# Let's find python
	if [ -e /mingw64/bin/python.exe ]; then
		. shell mingw64
	elif [ -e /mingw32/bin/python.exe ]; then
		. shell mingw32
	elif [ -e /usr/bin/python.exe ]; then
		MSYSPYTHON=true
	fi
fi

# start!

CONFIGURE_DIRNAME=build-openssl$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-$LIBRESSL_ANDROID_ARCH
rm -rf $CONFIGURE_DIRNAME
mkdir $CONFIGURE_DIRNAME; cd $CONFIGURE_DIRNAME

CONFIGURE_SCRIPT=

# make-standalone-toolchain.sh or make_standalone_toolchain.py is required for building OpenSSL
MST_COMMAND=
if [ -e $ANDROID_NDK_ROOT/build/tools/make_standalone_toolchain.py ]; then
	if $MSYSPYTHON; then
		echo "Warning: You are using MSYS python, and this step will probably fail."
		echo "Please install an MinGW Python3 to proceed this step."
	fi
	MST_COMMAND="python $ANDROID_NDK_ROOT/build/tools/make_standalone_toolchain.py \
	 --arch $LIBRESSL_ANDROID_ARCH \
	 --install-dir `realpath .`/android-ndk-standalone \
	 --api $ANDROID_VER \
	 --stl gnustl"
else
	MST_COMMAND="sh $ANDROID_NDK_ROOT/build/tools/make-standalone-toolchain.sh \
	 --arch=$LIBRESSL_ANDROID_ARCH \
	 --install-dir=`realpath .`/android-ndk-standalone \
	 --platform=android-$ANDROID_VER \
	 --stl=gnustl "

	if [ x$ANDROID_TOOLCHAIN = xclang ]; then
		MST_COMMAND="$MST_COMMAND \
		 --toolchain=$LIBRESSL_ANDROID_TOOLCHAIN_CLANG "
	else
		MST_COMMAND="$MST_COMMAND \
		 --toolchain=$LIBRESSL_ANDROID_TOOLCHAIN "
	fi
fi
echo $MST_COMMAND
if ! $MST_COMMAND; then
	exit 1
fi

# This 'make' program is broken when installing using MSYS2, remove it and use system provided one
for i in android-ndk-standalone/bin/make android-ndk-standalone/bin/make.exe android-ndk-standalone/bin/make.cmd; do
	rm -f $i
done

if [ `uname -o` = Msys ]; then
	# switch back to MSYS to use MSYS perl..... How could OpenSSL compile system be so complicated?
	. shell msys
fi

export PATH=`realpath android-ndk-standalone/bin`:$PATH

if ! $OPENSSL_VERSION11; then
	cp -R $LIBRESSL_PATH/* .
	CONFIGURE_SCRIPT=Configure
	if [ x$ANDROID_TOOLCHAIN = xclang ]; then
		sed -ibak "s/-mandroid//g" ./Configure
	fi
else
	CONFIGURE_SCRIPT=$LIBRESSL_PATH/Configure
	LIBRESSL_ANDROID_ABI=$LIBRESSL_ANDROID_ABI11
	export ANDROID_NDK_HOME=`realpath .`/android-ndk-standalone
fi

if [ x$ANDROID_TOOLCHAIN = xclang ]; then
	export CC=clang
fi

command="perl $CONFIGURE_SCRIPT \
	no-asm \
	no-shared \
	--prefix=// \
	--openssldir=//ssl"

command="$command --cross-compile-prefix=$LIBRESSL_ANDROID_TARGET- "
command="$command $LIBRESSL_ANDROID_ABI $LIBRESSL_ANDROID_CFLAGS $LIBRESSL_ANDROID_LFLAGS"

echo $command
$command

res=$?

if [ $res -ne 0 ]; then
	exit 1
fi

# judge how many parallel builds we should have using /proc/cpuinfo if exist, otherwise default to -j3
PARALLELNUM=3
if [ "$NUMBER_OF_PROCESSORS" ]; then
	PARALLELNUM=`expr $NUMBER_OF_PROCESSORS + 1`
elif [ -e /proc/cpuinfo ]; then
	PARALLELNUM=$(expr `cat /proc/cpuinfo | grep processor | wc -l` + 1 )
elif [ x`uname` = xDarwin ]; then
	PARALLELNUM=$(expr `sysctl machdep.cpu.thread_count | cut -d " " -f 2` + 1 )
fi

MAKE_COMMAND="make -j$PARALLELNUM"
#MAKE_COMMAND="make -j1"
echo $MAKE_COMMAND
if ! $MAKE_COMMAND; then
	exit 1
fi

DESTDIRVARNAME=INSTALL_PREFIX
if $OPENSSL_VERSION11; then
	DESTDIRVARNAME=DESTDIR
fi

INSTALLTARGET="install_sw"
if $OPENSSL_VERSION11; then
	INSTALLTARGET="install_sw install_ssldirs"
fi

MAKEINSTALL_COMMAND="make $INSTALLTARGET $DESTDIRVARNAME=`realpath .`/../OpenSSL$OPENSSL_VERSION-AndroidAPI$ANDROID_VER-$LIBRESSL_ANDROID_ARCH"
echo $MAKEINSTALL_COMMAND
if ! $MAKEINSTALL_COMMAND; then
	exit 1
fi

cd ..
rm -rf $CONFIGURE_DIRNAME

