
local gen = {}

local pathEnvCalc = function(self, path)
	local ret = "" .. self.pathEnvPre
	for _, p in ipairs(path) do
		ret = ret .. p .. self.pathEnvSep
	end
	ret = ret .. self.pathEnvSuf
	return ret
end

local otherEnvCalc = function(self, envs)
	local ret = ""
	for k, v in pairs(envs) do
		local line = "" .. self.envPre .. "&ENVVALUE&" .. self.envSuf .. "\n"
		local parsedLine = string.gsub(line, "%&([%w_]+)%&", { ENVNAME = k, ENVVALUE = v })
		ret = ret .. parsedLine
	end

	return ret
end

gen.win = {}

gen.win.pathEnvPre = "set path="
gen.win.pathEnvSep = ";"
gen.win.pathEnvSuf = "%PATH%"

gen.win.envPre = "set &ENVNAME&="
gen.win.envSuf = ""

gen.win.delete = "del /q"
gen.win.extract = {}
gen.win.extract.sevenzip = "%SEVENZIP% x -y"
gen.win.download = "!DOWNLOADTOOL! -!pd!"

-- MSVCBATCALL
-- EMCALL
-- PATHSET
-- ENVSET
-- BUILDDIR
-- WORKSPACE
-- CONFIGURECOMMANDLINE
-- MAKE
-- INSTALLCOMMANDLINE
-- INSTALLROOT
-- INSTALLPATH
-- EXTRAINSTALL
-- INSTALLPATHWITHDATE
gen.win.template4Qt = [[

rem Unset it for now since it is only used in Jenkins.
rem Building Qt doesn't need JDK, except for Android versions.
rem Set it in ENVSET instead for using correct JDK version for building.

set JAVA_HOME=

setlocal enabledelayedexpansion

set DOWNLOADTOOL=

for %%i in (aria2c curl wget) do (
	if "!DOWNLOADTOOL!" == "" (
		set p="--help"
		if "%%i" == "aria2c" set p="-h"
		%%i !p! >NUL 2>NUL
		if not ERRORLEVEL 1 set DOWNLOADTOOL=%%i
		set p=
	)
)

rem TODO - set --no-conf parameter to aria2c

set pd=o
if "!DOWNLOADTOOL!" == "wget" set pd=O

&DOWNLOADPACKAGE&

endlocal

set SEVENZIP=7z

&UNCOMPRESSPACKAGE&
&DELETEUNCOMPRESSED&

&PATHSET&

&MSVCBATCALL&
&EMCALL&

&PATHSET&

&ENVSET&

rmdir /s /q &BUILDDIR&
mkdir &BUILDDIR&
cd /d &BUILDDIR&

set PARALLELNUM=0

set /a PARALLELNUM=%NUMBER_OF_PROCESSORS%+1

rem Pay attention to space before EOL next line! Keep it!
set NINJA_STATUS=[%%f/%%t %%P/%%o/%%c %%w/%%W] 

cmd /c &CONFIGURECOMMANDLINE&
if errorlevel 1 exit 1

set i=0

:LOOP
set /a i=%i%+1
if %i% gtr 3 exit 1

cmd /c &MAKE&
if errorlevel 1 goto LOOP

cmd /c &INSTALLCOMMANDLINE&
if errorlevel 1 exit 1

cd /d &WORKSPACE&\buildDir

&EXTRAINSTALL&

cd /d &INSTALLROOT&\..

%SEVENZIP% a -t7z -m0=LZMA2:d256m:fb273 -mmt=3 -myx -mqs -ms=on -- &INSTALLPATHWITHDATE&.7z &INSTALLPATH&
copy /y &INSTALLPATHWITHDATE&.7z &INSTALLPATH&.7z

rmdir /s /q &BUILDDIR&

exit 0

]]

-- MSVCBATCALL
-- PATHSET
-- ENVSET
-- BUILDDIR
-- WORKSPACE
-- CONFIGURECOMMANDLINE
-- MAKE
-- INSTALLCOMMANDLINE
-- INSTALLROOT
-- INSTALLPATH
gen.win.template4OpenSSL = [[

rem Unset it for now since it is only used in Jenkins.
rem Building OpenSSL doesn't need JDK.

set JAVA_HOME=

setlocal enabledelayedexpansion

set DOWNLOADTOOL=

for %%i in (aria2c curl wget) do (
	if "!DOWNLOADTOOL!" == "" (
		set p="--help"
		if "%%i" == "aria2c" set p="-h"
		%%i !p! >NUL 2>NUL
		if not ERRORLEVEL 1 set DOWNLOADTOOL=%%i
		set p=
	)
)

rem TODO - set --no-conf parameter to aria2c

set pd=o
if "!DOWNLOADTOOL!" == "wget" set pd=O

&DOWNLOADPACKAGE&

endlocal

set SEVENZIP=7z

&UNCOMPRESSPACKAGE&
&DELETEUNCOMPRESSED&

&PATHSET&

&MSVCBATCALL&

&PATHSET&

&ENVSET&

rmdir /s /q &BUILDDIR&
mkdir &BUILDDIR&
cd /d &BUILDDIR&

set PARALLELNUM=0

set /a PARALLELNUM=%NUMBER_OF_PROCESSORS%+1

rem Pay attention to space before EOL next line! Keep it!
set NINJA_STATUS=[%%f/%%t %%P/%%o/%%c %%w/%%W] 

cmd /c &CONFIGURECOMMANDLINE&
if errorlevel 1 exit 1

cmd /c &MAKE& clean

set i=0

:LOOP
set /a i=%i%+1
if %i% gtr 3 exit 1

cmd /c &MAKE&
if errorlevel 1 goto LOOP

set j=0

:LOOP2
set /a j=%j%+1
if %j% gtr 3 exit 1

cmd /c &INSTALLCOMMANDLINE&
if errorlevel 1 goto LOOP2

cd /d &INSTALLROOT&\..

%SEVENZIP% a -t7z -m0=LZMA2:d256m:fb273 -mmt=3 -myx -mqs -ms=on -- &INSTALLPATH&.7z &INSTALLPATH&

rmdir /s /q &BUILDDIR&

exit 0

]]

-- MSVCBATCALL
-- PATHSET
-- ENVSET
-- BUILDDIR
-- WORKSPACE
-- CONFIGURECOMMANDLINE
-- MAKE
-- INSTALLCOMMANDLINE
-- INSTALLROOT
-- INSTALLPATH
gen.win.template4MariaDB = [[

rem Unset it for now since it is only used in Jenkins.
rem Building MariaDB doesn't need JDK.

set JAVA_HOME=

setlocal enabledelayedexpansion

set DOWNLOADTOOL=

for %%i in (aria2c curl wget) do (
	if "!DOWNLOADTOOL!" == "" (
		set p="--help"
		if "%%i" == "aria2c" set p="-h"
		%%i !p! >NUL 2>NUL
		if not ERRORLEVEL 1 set DOWNLOADTOOL=%%i
		set p=
	)
)

rem TODO - set --no-conf parameter to aria2c

set pd=o
if "!DOWNLOADTOOL!" == "wget" set pd=O

&DOWNLOADPACKAGE&

endlocal

set SEVENZIP=7z

&UNCOMPRESSPACKAGE&
&DELETEUNCOMPRESSED&

&PATHSET&

&MSVCBATCALL&

&PATHSET&

&ENVSET&

rmdir /s /q &BUILDDIR&
mkdir &BUILDDIR&
cd /d &BUILDDIR&

set PARALLELNUM=0

set /a PARALLELNUM=%NUMBER_OF_PROCESSORS%+1

rem Pay attention to space before EOL next line! Keep it!
set NINJA_STATUS=[%%f/%%t %%P/%%o/%%c %%w/%%W] 

cmd /c &CONFIGURECOMMANDLINE&
if errorlevel 1 exit 1

set i=0

:LOOP
set /a i=%i%+1
if %i% gtr 3 exit 1

cmd /c &MAKE&
if errorlevel 1 goto LOOP

set j=0

:LOOP2
set /a j=%j%+1
if %j% gtr 3 exit 1

cmd /c &INSTALLCOMMANDLINE&
if errorlevel 1 goto LOOP2

cd /d &INSTALLROOT&\..

%SEVENZIP% a -t7z -m0=LZMA2:d256m:fb273 -mmt=3 -myx -mqs -ms=on -- &INSTALLPATH&.7z &INSTALLPATH&

rmdir /s /q &BUILDDIR&

exit 0

]]

gen.unix = {}

gen.unix.pathEnvPre = "PATH=\""
gen.unix.pathEnvSep = ":"
gen.unix.pathEnvSuf = "$PATH\"; export PATH"

gen.unix.envPre = "&ENVNAME&=\""
gen.unix.envSuf = "\"; export &ENVNAME&"

gen.unix.delete = "rm -f"
gen.unix.extract = {}
gen.unix.extract.sevenzip = "$SEVENZIP x -y"
gen.unix.extract.tar = "$TAR -xf"
gen.unix.download = "$DOWNLOADTOOL -$DOWNLOADP"

-- EMCALL
-- PATHSET
-- ENVSET
-- BUILDDIR
-- WORKSPACE
-- CONFIGURECOMMANDLINE
-- MAKE
-- INSTALLPARAMETER
-- INSTALLROOT
-- INSTALLPATH
-- EXTRAINSTALL
-- INSTALLPATHWITHDATE
gen.unix.template4Qt = [[

set -x

unset JAVA_HOME

DOWNLOADTOOL=

for i in aria2c wget curl; do
	p="--help"
	if [ x$i = xaria2c ]; then
		p="-h"
	fi
	if $i $p >/dev/null 2>/dev/null; then
		DOWNLOADTOOL=$i
		break
	fi
done

if [ "x$DOWNLOADTOOL" = "x" ]; then
	echo "no download tool" >&2
	exit 1
fi

if [ "x$DOWNLOADTOOL" = "xaria2c" ]; then
	DOWNLOADTOOL="aria2c --no-conf"
fi

DOWNLOADP="o"
if [ "x$DOWNLOADTOOL" = "xwget" ]; then
	DOWNLOADP="O"
fi

&DOWNLOADPACKAGE&

TAR=

for i in bsdtar tar; do
	if $i --help >/dev/null 2>/dev/null; then
		TAR=$i
		break
	fi
done

if [ "x$TAR" = "x" ]; then
	echo "tar not found" >&2
	exit 1
fi

SEVENZIP=

for i in 7zr 7za 7z; do
	if $i >/dev/null 2>/dev/null; then
		SEVENZIP=$i
		break
	fi
done

if [ "x$SEVENZIP" = "x" ]; then
	echo "7-zip not found" >&2
	exit 1
fi

&UNCOMPRESSPACKAGE&
&DELETEUNCOMPRESSED&

&PATHSET&

&EMCALL&

&PATHSET&

&ENVSET&

rm -rf &BUILDDIR&
mkdir &BUILDDIR&
cd &BUILDDIR&

PARALLELNUM=`nproc 2> /dev/null`
if [ $? -ne 0 ]; then
	PARALLELNUM=3
	if [ "$NUMBER_OF_PROCESSORS" ]; then
		PARALLELNUM=`expr $NUMBER_OF_PROCESSORS + 1`
	elif [ -e /proc/cpuinfo ]; then
		PARALLELNUM=$(expr `cat /proc/cpuinfo | grep processor | wc -l` + 1 )
	elif [ x`uname` = xDarwin ]; then
		PARALLELNUM=$(expr `sysctl machdep.cpu.thread_count | cut -d " " -f 2` + 1 )
	fi
fi

NINJA_STATUS='[%f/%t %P/%o/%c %w/%W] '; export NINJA_STATUS

&CONFIGURECOMMANDLINE&
[ $? -eq 0 ] || exit 1

for i in `seq 4`; do
if &MAKE&; then break; fi
if [ $i -eq 4 ]; then exit 1; fi
done

&INSTALLCOMMANDLINE&
[ $? -eq 0 ] || exit 1

cd &WORKSPACE&/buildDir

&EXTRAINSTALL&

cd &INSTALLROOT&/..

$TAR -cf - &INSTALLPATH& | $SEVENZIP a -txz -m0=LZMA2:d256m:fb273 -mmt=3 -myx -si -- &INSTALLPATHWITHDATE&.tar.xz
$SEVENZIP a -t7z -m0=LZMA2:d256m:fb273 -mmt=3 -myx -mqs -ms=on -- &INSTALLPATHWITHDATE&.7z &INSTALLPATH&

cp &INSTALLPATHWITHDATE&.tar.xz &INSTALLPATH&.tar.xz
cp &INSTALLPATHWITHDATE&.7z &INSTALLPATH&.7z

rm -rf &BUILDDIR&

exit 0

]]

-- PATHSET
-- ENVSET
-- BUILDDIR
-- WORKSPACE
-- CONFIGURECOMMANDLINE
-- MAKE
-- INSTALLCOMMANDLINE
-- INSTALLROOT
-- INSTALLPATH
-- EXTRAINSTALL
gen.unix.template4OpenSSL = [[
set -x

unset JAVA_HOME

DOWNLOADTOOL=

for i in aria2c wget curl; do
	p="--help"
	if [ x$i = xaria2c ]; then
		p="-h"
	fi
	if $i $p >/dev/null 2>/dev/null; then
		DOWNLOADTOOL=$i
		break
	fi
done

if [ "x$DOWNLOADTOOL" = "x" ]; then
	echo "no download tool" >&2
	exit 1
fi

if [ "x$DOWNLOADTOOL" = "xaria2c" ]; then
	DOWNLOADTOOL="aria2c --no-conf"
fi

DOWNLOADP="o"
if [ "x$DOWNLOADTOOL" = "xwget" ]; then
	DOWNLOADP="O"
fi

&DOWNLOADPACKAGE&

TAR=

for i in bsdtar tar; do
	if $i --help >/dev/null 2>/dev/null; then
		TAR=$i
		break
	fi
done

if [ "x$TAR" = "x" ]; then
	echo "tar not found" >&2
	exit 1
fi

SEVENZIP=

for i in 7zr 7za 7z; do
	if $i >/dev/null 2>/dev/null; then
		SEVENZIP=$i
		break
	fi
done

&UNCOMPRESSPACKAGE&
&DELETEUNCOMPRESSED&

&PATHSET&

&ENVSET&

rm -rf &BUILDDIR&
mkdir &BUILDDIR&
cd &BUILDDIR&

PARALLELNUM=`nproc 2> /dev/null`
if [ $? -ne 0 ]; then
	PARALLELNUM=3
	if [ "$NUMBER_OF_PROCESSORS" ]; then
		PARALLELNUM=`expr $NUMBER_OF_PROCESSORS + 1`
	elif [ -e /proc/cpuinfo ]; then
		PARALLELNUM=$(expr `cat /proc/cpuinfo | grep processor | wc -l` + 1 )
	elif [ x`uname` = xDarwin ]; then
		PARALLELNUM=$(expr `sysctl machdep.cpu.thread_count | cut -d " " -f 2` + 1 )
	fi
fi

NINJA_STATUS='[%f/%t %P/%o/%c %w/%W] '; export NINJA_STATUS

&CONFIGURECOMMANDLINE&
[ $? -eq 0 ] || exit 1

&MAKE& clean

for i in `seq 4`; do
if &MAKE&; then break; fi
if [ $i -eq 4 ]; then exit 1; fi
done

for i in `seq 4`; do
if &INSTALLCOMMANDLINE&; then break; fi
if [ $i -eq 4 ]; then exit 1; fi
done

cd &WORKSPACE&/buildDir

&EXTRAINSTALL&

cd &INSTALLROOT&/..

$TAR -cf - &INSTALLPATH& | $SEVENZIP a -txz -m0=LZMA2:d256m:fb273 -mmt=3 -myx -si -- &INSTALLPATH&.tar.xz
$SEVENZIP a -t7z -m0=LZMA2:d256m:fb273 -mmt=3 -myx -mqs -ms=on -- &INSTALLPATH&.7z &INSTALLPATH&

rm -rf &BUILDDIR&

exit 0

]]

-- PATHSET
-- ENVSET
-- OPENSSLDIRFUNCTION
-- ARCHITECTURES
-- WORKSPACE
-- INSTALLROOT
-- INSTALLPATH
gen.unix.template4OpenSSLUnifyAndroid = [[
set -x

unset JAVA_HOME

DOWNLOADTOOL=

for i in aria2c wget curl; do
	p="--help"
	if [ x$i = xaria2c ]; then
		p="-h"
	fi
	if $i $p >/dev/null 2>/dev/null; then
		DOWNLOADTOOL=$i
		break
	fi
done

if [ "x$DOWNLOADTOOL" = "x" ]; then
	echo "no download tool" >&2
	exit 1
fi

if [ "x$DOWNLOADTOOL" = "xaria2c" ]; then
	DOWNLOADTOOL="aria2c --no-conf"
fi

DOWNLOADP="o"
if [ "x$DOWNLOADTOOL" = "xwget" ]; then
	DOWNLOADP="O"
fi

&DOWNLOADPACKAGE&

TAR=

for i in bsdtar tar; do
	if $i --help; then
		TAR=$i
		break
	fi
done

if [ "x$TAR" = "x" ]; then
	echo "tar not found" >&2
	exit 1
fi

SEVENZIP=

for i in 7zr 7za 7z; do
	if $i >/dev/null 2>/dev/null; then
		SEVENZIP=$i
		break
	fi
done

&UNCOMPRESSPACKAGE&
&DELETEUNCOMPRESSED&

getOpenSSLDir() {
	&OPENSSLDIRFUNCTION&
	return 0
}

&PATHSET&

&ENVSET&

rm -rf &INSTALLROOT&
mkdir &INSTALLROOT&
cd &INSTALLROOT&

mkdir lib bin

for ar in &ARCHITECTURES&; do
	getOpenSSLDir "$ar"
	if [ $? -ne 0 ]; then
		exit 1
	fi
	# It is certain that we built OpenSSL to static library
	# so all we need are following files
	cp ../$CURRENTARCHDIR/lib/libssl.a ./lib/libssl_$ar.a
	cp ../$CURRENTARCHDIR/lib/libcrypto.a ./lib/libcrypto_$ar.a
	cp ../$CURRENTARCHDIR/bin/openssl ./bin/openssl_$ar
	if ! [ -d include ]; then
		cp -R ../$CURRENTARCHDIR/include ./include
	fi
	if ! [ -d ssl ]; then
		cp -R ../$CURRENTARCHDIR/ssl ./ssl
	fi
done

cd &INSTALLROOT&/..

$TAR -cf - &INSTALLPATH& | $SEVENZIP a -txz -m0=LZMA2:d256m:fb273 -mmt=3 -myx -si -- &INSTALLPATH&.tar.xz
$SEVENZIP a -t7z -m0=LZMA2:d256m:fb273 -mmt=3 -myx -mqs -ms=on -- &INSTALLPATH&.7z &INSTALLPATH&

exit 0

]]

-- PATHSET
-- ENVSET
-- OPENSSLDIRFUNCTION
-- ARCHITECTURES
-- WORKSPACE
-- INSTALLROOT
-- INSTALLPATH
gen.unix.template4OpenSSLUnifymacOS = [[
set -x

unset JAVA_HOME

DOWNLOADTOOL=

for i in aria2c wget curl; do
	p="--help"
	if [ x$i = xaria2c ]; then
		p="-h"
	fi
	if $i $p >/dev/null 2>/dev/null; then
		DOWNLOADTOOL=$i
		break
	fi
done

if [ "x$DOWNLOADTOOL" = "x" ]; then
	echo "no download tool" >&2
	exit 1
fi

if [ "x$DOWNLOADTOOL" = "xaria2c" ]; then
	DOWNLOADTOOL="aria2c --no-conf"
fi

DOWNLOADP="o"
if [ "x$DOWNLOADTOOL" = "xwget" ]; then
	DOWNLOADP="O"
fi

&DOWNLOADPACKAGE&

TAR=

for i in bsdtar tar; do
	if $i --help; then
		TAR=$i
		break
	fi
done

if [ "x$TAR" = "x" ]; then
	echo "tar not found" >&2
	exit 1
fi

SEVENZIP=

for i in 7zr 7za 7z; do
	if $i >/dev/null 2>/dev/null; then
		SEVENZIP=$i
		break
	fi
done

&UNCOMPRESSPACKAGE&
&DELETEUNCOMPRESSED&

getOpenSSLDir() {
	&OPENSSLDIRFUNCTION&
	return 0
}

MakeOpenSSLLibLinks()
{
	while [ "$#" -gt 0 ]; do
		ln -s "$1" "$2"
		shift
		shift
	done
}

&PATHSET&

&ENVSET&

rm -rf &INSTALLROOT&
mkdir &INSTALLROOT&
cd &INSTALLROOT&

# We builds only OpenSSL 3 on macOS so following are only for OpenSSL 3.

mkdir lib bin
mkdir lib/ossl-modules

LIPONAMES="bin/openssl lib/libssl.3.dylib lib/libcrypto.3.dylib lib/libssl.a lib/libcrypto.a lib/ossl-modules/legacy.dylib"

for ar in &ARCHITECTURES&; do
	getOpenSSLDir "$ar"
	if [ $? -ne 0 ]; then
		exit 1
	fi
	if ! [ -d include ]; then
		cp -R ../$CURRENTARCHDIR/include ./include
	fi
	if ! [ -d ssl ]; then
		cp -R ../$CURRENTARCHDIR/ssl ./ssl
	fi
done

for n in $LIPONAMES; do
	EXECUTABLELIST=
	for ar in &ARCHITECTURES&; do
		getOpenSSLDir "$ar"
		EXECUTABLELIST=$EXECUTABLELIST\ "../$CURRENTARCHDIR/$n"
	done

	lipo $EXECUTABLELIST -create -output "$n"
done

MakeOpenSSLLibLinks libssl.3.dylib lib/libssl.dylib libcrypto.3.dylib lib/libcrypto.dylib

cd &INSTALLROOT&/..

$TAR -cf - &INSTALLPATH& | $SEVENZIP a -txz -m0=LZMA2:d256m:fb273 -mmt=3 -myx -si -- &INSTALLPATH&.tar.xz
$SEVENZIP a -t7z -m0=LZMA2:d256m:fb273 -mmt=3 -myx -mqs -ms=on -- &INSTALLPATH&.7z &INSTALLPATH&

exit 0

]]

-- PATHSET
-- ENVSET
-- BUILDDIR
-- WORKSPACE
-- CONFIGURECOMMANDLINE
-- MAKE
-- INSTALLCOMMANDLINE
-- INSTALLROOT
-- INSTALLPATH
gen.unix.template4MariaDB = [[
set -x

unset JAVA_HOME

DOWNLOADTOOL=

for i in aria2c wget curl; do
	p="--help"
	if [ x$i = xaria2c ]; then
		p="-h"
	fi
	if $i $p >/dev/null 2>/dev/null; then
		DOWNLOADTOOL=$i
		break
	fi
done

if [ "x$DOWNLOADTOOL" = "x" ]; then
	echo "no download tool" >&2
	exit 1
fi

if [ "x$DOWNLOADTOOL" = "xaria2c" ]; then
	DOWNLOADTOOL="aria2c --no-conf"
fi

DOWNLOADP="o"
if [ "x$DOWNLOADTOOL" = "xwget" ]; then
	DOWNLOADP="O"
fi

&DOWNLOADPACKAGE&

TAR=

for i in bsdtar tar; do
	if $i --help >/dev/null 2>/dev/null; then
		TAR=$i
		break
	fi
done

if [ "x$TAR" = "x" ]; then
	echo "tar not found" >&2
	exit 1
fi

SEVENZIP=

for i in 7zr 7za 7z; do
	if $i >/dev/null 2>/dev/null; then
		SEVENZIP=$i
		break
	fi
done

&UNCOMPRESSPACKAGE&
&DELETEUNCOMPRESSED&

&PATHSET&

&ENVSET&

rm -rf &BUILDDIR&
mkdir &BUILDDIR&
cd &BUILDDIR&

PARALLELNUM=`nproc 2> /dev/null`
if [ $? -ne 0 ]; then
	PARALLELNUM=3
	if [ "$NUMBER_OF_PROCESSORS" ]; then
		PARALLELNUM=`expr $NUMBER_OF_PROCESSORS + 1`
	elif [ -e /proc/cpuinfo ]; then
		PARALLELNUM=$(expr `cat /proc/cpuinfo | grep processor | wc -l` + 1 )
	elif [ x`uname` = xDarwin ]; then
		PARALLELNUM=$(expr `sysctl machdep.cpu.thread_count | cut -d " " -f 2` + 1 )
	fi
fi

NINJA_STATUS='[%f/%t %P/%o/%c %w/%W] '; export NINJA_STATUS

&CONFIGURECOMMANDLINE&
[ $? -eq 0 ] || exit 1

&MAKE&
[ $? -eq 0 ] || exit 1

&INSTALLCOMMANDLINE&
[ $? -eq 0 ] || exit 1

cd &INSTALLROOT&/..

$TAR -cf - &INSTALLPATH& | $SEVENZIP a -txz -m0=LZMA2:d256m:fb273 -mmt=3 -myx -si -- &INSTALLPATH&.tar.xz
$SEVENZIP a -t7z -m0=LZMA2:d256m:fb273 -mmt=3 -myx -mqs -ms=on -- &INSTALLPATH&.7z &INSTALLPATH&

rm -rf &BUILDDIR&

exit 0

]]

local filenameAndToolFromUrl = function(url)
	-- get filename from URL since we don't use redirections
	local n, n2
	repeat
		n = n2
		n2 = string.find(url, "/", n and (n + 1) or 1)
	until not n2
	local target = string.sub(url, n + 1)
	local tool = nil

	-- uncompress
	if (string.sub(target, -3) == ".7z") or (string.sub(target, -4) == ".zip") then
		tool = "sevenzip"
	elseif ((string.sub(target, -7) == ".tar.gz") or (string.sub(target, -8) == ".tar.bz2") or (string.sub(target, -7) == ".tar.xz")) then
		tool = "tar"
	end

	return target, tool
end

gen.generateBuildCommand = function(self, para)
	-- para.template should be "unix" or "win"
	-- para.buildContent should be "Qt", "OpenSSL", "OpenSSLUnify***" or "MariaDB"
	-- other contents in para goes to the replacement function
	-- for buildContent:
	--   "MAKE" "CONFIGURECOMMANDLINE" "date" must be provided. Fails if either one is missing.
	--   MSVC builds must provide "MSVCBATCALL". MinGW builds must not provide "MSVCBATCALL".
	--   if there is "path" and no "PATHSET" we calculate the PATHSET for user. If both are missing the PATHSET will be "". "path" should be a table with numbered index
	--   if there is "download" the final script will download and extract the needed files.
	local paraCopy = {}
	for k, v in pairs(para) do
		paraCopy[k] = v
	end

	-- check paraCopy.template && paraCopy.buildContent
	local template = self[para.template]["template4" .. para.buildContent]
	if not template then
		return
	end

	if string.sub(template, 1, 12) == "OpenSSLUnify" then
		if para.template ~= "unix" then
			print("[Generate.generateBuildCommand] ERROR: Generation of OpenSSL Unify builds is not available in para.template ~= \"unix\"")
			os.exit(1)
		end
	end

	if not para.PATHSET then
		if para.path and (type(para.path) == "table") then
			paraCopy.PATHSET = pathEnvCalc(self[para.template], para.path)
		end
	end

	if para.envSet then
		paraCopy.ENVSET = otherEnvCalc(self[para.template], para.envSet)
	end

	if para.download and type(para.download) == "table" then
		for _, url in ipairs(para.download) do
			local filename, tool = filenameAndToolFromUrl(url)
			paraCopy.DOWNLOADPACKAGE = paraCopy.DOWNLOADPACKAGE or ""
			paraCopy.DOWNLOADPACKAGE = paraCopy.DOWNLOADPACKAGE .. self[para.template].download .. " \"" .. filename .. "\" \"" .. url .. "\"\n"
			paraCopy.UNCOMPRESSPACKAGE = paraCopy.UNCOMPRESSPACKAGE or ""
			if tool then
				paraCopy.UNCOMPRESSPACKAGE = paraCopy.UNCOMPRESSPACKAGE .. self[para.template].extract[tool] .. " \"" .. filename .. "\"\n"
				paraCopy.DELETEUNCOMPRESSED = paraCopy.DELETEUNCOMPRESSED or ""
				paraCopy.DELETEUNCOMPRESSED = paraCopy.DELETEUNCOMPRESSED .. self[para.template].delete .. " \"" .. filename .. "\"\n"
			end
		end
	end

	if para.msvcBat then
		if para.template == "win" then
			paraCopy.MSVCBATCALL = "call \"" .. para.msvcBat .. "\"\n" .. "echo on\n"
		else
			print("[Generate.generateBuildCommand] WARNING: para.msvcBat is set when para.template ~= \"win\"")
		end
	end
	if para.emSource then
		if para.template == "win" then
			-- emsdk construct_env on Windows nukes local paths https://github.com/emscripten-core/emsdk/issues/189 (on 1.39.8 / 2.0.14)
			paraCopy.EMCALL = "call " .. para.emSource .. "\nif errorlevel 1 exit 1\necho on\nset PATH=%TOOLSPATH%;%PATH%\n"
		else
			paraCopy.EMCALL = ". " .. para.emSource .. " || exit 1\nrm -rf $EM_CACHE\n"
		end
	end
	if para.buildContent == "Qt" then
		paraCopy.INSTALLPATHWITHDATE = para.INSTALLPATH .. "-" .. para.date
	end

	local ret = string.gsub(template, "%&([%w_]+)%&", function(s)
		return paraCopy[s] or ""
	end)

	return ret
end

gen.dumpConfTable = function(self, para, indent)
	indent = indent or 1

	local returnText = "{\n"
	local keys = {}

	for k in pairs(para) do
		table.insert(keys, k)
	end

	table.sort(keys)

	for _, k in ipairs(keys) do
		local v = para[k]
		-- key is always string
		returnText = returnText .. string.rep("\t", indent) .. "[\"" .. k .. "\"] = "
		if type(v) == "nil" then
			returnText = returnText .. "nil"
		elseif type(v) == "string" then
			returnText = returnText .. "[====[" .. v .. "]====]"
		elseif type(v) == "boolean" then
			returnText = returnText .. (v and "true" or "false")
		elseif type(v) == "table" then
			returnText = returnText .. self:dumpConfTable(v, indent + 1)
		else
			returnText = returnText .. tostring(v)
		end
		returnText = returnText .. ",\n"
	end
	returnText = returnText .. string.rep("\t", indent - 1) .. "}"
	return returnText
end

gen.generateBuildInfo = function(self, para)
	return "return " .. self:dumpConfTable(para)
end

local mo = {
	__call = function(self, para)
		return self:generateBuildCommand(para)
	end,
}

setmetatable(gen, mo)

return gen
