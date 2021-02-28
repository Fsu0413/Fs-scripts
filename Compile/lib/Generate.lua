-- TODO: separate compression to another process
-- for Qt builds, it needs other operations(copy OpenSSL libraries, copy config.opt etc., copy/build QQtPatcher)

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
-- CONFIGFAIL
-- CONFIGRETRY
gen.win.template4Qt = [[

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

set pd=o
if "!DOWNLOADTOOL!" == "wget" set pd=O

&DOWNLOADPACKAGE&

endlocal

set SEVENZIP=7z

&UNCOMPRESSPACKAGE&
&DELETEUNCOMPRESSED&

&MSVCBATCALL&
&EMCALL&

&PATHSET&

&ENVSET&

rmdir /s /q &BUILDDIR&
mkdir &BUILDDIR&
cd /d &BUILDDIR&

set PARALLELNUM=0

set /a PARALLELNUM=%NUMBER_OF_PROCESSORS%+1

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

cd &INSTALLROOT&\..

%SEVENZIP% a -t7z -m0=LZMA2:d256m:fb273 -mmt=3 -myx -mqs -ms=on -- &INSTALLPATHWITHDATE&.7z &INSTALLPATH&
copy /y &INSTALLPATHWITHDATE&.7z &INSTALLPATH&.7z

exit 0

]]

-- QTDIR
-- VERSION
-- MAKE
gen.win.template4QQtPatcher = [[

mkdir build-QQtPatcher

pushd build-QQtPatcher

cmd /c &QTDIR&\bin\qmake CONFIG+=release ..\QQtPatcher-&VERSION&\QQtPatcher.pro
if errorlevel 1 exit 1

cmd /c &MAKE&
if errorlevel 1 exit 1

copy release\QQtPatcher.exe ..

popd

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

set pd=o
if "!DOWNLOADTOOL!" == "wget" set pd=O

&DOWNLOADPACKAGE&

endlocal

set SEVENZIP=7z

&UNCOMPRESSPACKAGE&
&DELETEUNCOMPRESSED&

&MSVCBATCALL&

&PATHSET&

&ENVSET&

rmdir /s /q &BUILDDIR&
mkdir &BUILDDIR&
cd /d &BUILDDIR&

set PARALLELNUM=0

set /a PARALLELNUM=%NUMBER_OF_PROCESSORS%+1

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

cd &INSTALLROOT&\..

%SEVENZIP% a -t7z -m0=LZMA2:d256m:fb273 -mmt=3 -myx -mqs -ms=on -- &INSTALLPATH&.7z &INSTALLPATH&

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

&EMCALL&

&PATHSET&

&ENVSET&

rm -rf &BUILDDIR&
mkdir &BUILDDIR&
cd &BUILDDIR&

PARALLELNUM=3
if [ "$NUMBER_OF_PROCESSORS" ]; then
	PARALLELNUM=`expr $NUMBER_OF_PROCESSORS + 1`
elif [ -e /proc/cpuinfo ]; then
	PARALLELNUM=$(expr `cat /proc/cpuinfo | grep processor | wc -l` + 1 )
elif [ x`uname` = xDarwin ]; then
	PARALLELNUM=$(expr `sysctl machdep.cpu.thread_count | cut -d " " -f 2` + 1 )
fi

&CONFIGURECOMMANDLINE&
[ $? -eq 0 ] || exit 1

&MAKE&
[ $? -eq 0 ] || exit 1

&INSTALLCOMMANDLINE&
[ $? -eq 0 ] || exit 1

cd &WORKSPACE&/buildDir

&EXTRAINSTALL&

cd &INSTALLROOT&/..

$TAR -cf - &INSTALLPATH& | $SEVENZIP a -txz -m0=LZMA2:d256m:fb273 -mmt=3 -myx -si -- &INSTALLPATHWITHDATE&.tar.xz
$SEVENZIP a -t7z -m0=LZMA2:d256m:fb273 -mmt=3 -myx -mqs -ms=on -- &INSTALLPATHWITHDATE&.7z &INSTALLPATH&

cp &INSTALLPATHWITHDATE&.tar.xz &INSTALLPATH&.tar.xz
cp &INSTALLPATHWITHDATE&.7z &INSTALLPATH&.7z

]]

-- QTDIR
-- VERSION
-- MAKE
gen.unix.template4QQtPatcher = [[
set -x

mkdir build-QQtPatcher

pushd build-QQtPatcher

&QTDIR&/bin/qmake CONFIG+=release ../QQtPatcher-&VERSION&/QQtPatcher.pro
[ $? -eq 0 ] || exit 1

&MAKE&
[ $? -eq 0 ] || exit 1

cp -f QQtPatcher ..

popd

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
gen.unix.template4OpenSSL = [[
set -x

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

DOWNLOADP="o"
if [ "x$DOWNLOADTOOL" = "xwget" ]; then
	DOWNLOADP="O"
fi

&DOWNLOADPACKAGE&

TAR=

for i in bsdtar tar >/dev/null 2>/dev/null; do
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

&PATHSET&

&ENVSET&

rm -rf &BUILDDIR&
mkdir &BUILDDIR&
cd &BUILDDIR&

PARALLELNUM=3
if [ "$NUMBER_OF_PROCESSORS" ]; then
	PARALLELNUM=`expr $NUMBER_OF_PROCESSORS + 1`
elif [ -e /proc/cpuinfo ]; then
	PARALLELNUM=$(expr `cat /proc/cpuinfo | grep processor | wc -l` + 1 )
elif [ x`uname` = xDarwin ]; then
	PARALLELNUM=$(expr `sysctl machdep.cpu.thread_count | cut -d " " -f 2` + 1 )
fi

&CONFIGURECOMMANDLINE&
[ $? -eq 0 ] || exit 1

&MAKE& clean

&MAKE&
[ $? -eq 0 ] || exit 1

&INSTALLCOMMANDLINE&
[ $? -eq 0 ] || exit 1

cd &INSTALLROOT&/..

$TAR -cf - &INSTALLPATH& | $SEVENZIP a -txz -m0=LZMA2:d256m:fb273 -mmt=3 -myx -si -- &INSTALLPATH&.tar.xz
$SEVENZIP a -t7z -m0=LZMA2:d256m:fb273 -mmt=3 -myx -mqs -ms=on -- &INSTALLPATH&.7z &INSTALLPATH&

]]

-- PATHSET
-- ENVSET
-- OPENSSLDIRFUNCTION
-- ARCHITECTURES
-- WORKSPACE
-- INSTALLROOT
-- INSTALLPATH
gen.unix.template4OpenSSLAndroidAll = [[
set -x

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

mkdir lib
mkdir bin

for ar in &ARCHITECTURES&; do
	getOpenSSLDir "$ar"
	if [ $? -ne 0 ]; then
		exit 1
	fi
	cp ../$CURRENTARCHDIR/lib/libssl.a ./lib/libssl_$ar.a
	cp ../$CURRENTARCHDIR/lib/libcrypto.a ./lib/libcrypto_$ar.a
	cp ../$CURRENTARCHDIR/bin/openssl ./bin/openssl_$ar
	if [ "x$ar" = "xarm64-v8a" ]; then
		cp -R ../$CURRENTARCHDIR/include ./include
		cp -R ../$CURRENTARCHDIR/ssl ./ssl
	fi
done

cd &INSTALLROOT&/..

$TAR -cf - &INSTALLPATH& | $SEVENZIP a -txz -m0=LZMA2:d256m:fb273 -mmt=3 -myx -si -- &INSTALLPATH&.tar.xz
$SEVENZIP a -t7z -m0=LZMA2:d256m:fb273 -mmt=3 -myx -mqs -ms=on -- &INSTALLPATH&.7z &INSTALLPATH&

]]

local filenameAndToolFromUrl = function(url)
	-- get filename from URL since we don't use redirections
	local n, n2
	repeat
		n = n2
		n2 = string.find(url, "/", n and (n + 1) or 1)
	until n2 == nil
	local target = string.sub(url, n + 1)
	local tool = "unknown"

	-- uncompress
	if (string.sub(target, -3) == ".7z") or (string.sub(target, -4) == ".zip") then
		tool = "sevenzip"
	elseif ((string.sub(target, -7) == ".tar.gz") or (string.sub(target, -8) == ".tar.bz2") or (string.sub(target, -7) == ".tar.xz")) then
		tool = "tar"
	end

	return target, tool
end

gen.generate = function(self, para)
	-- para.template should be "unix" or "win"
	-- para.buildContent should be "Qt", "OpenSSL", "OpenSSLAndroidAll" or "QQtPatcher"
	-- other contents in para goes to the replacement function
	-- for buildContent other than QQtPatcher:
	--   "MAKE" "SOURCEFILE" "CONFIGURECOMMANDLINE" "date" must be provided. Fails if either one is missing.
	--   MSVC builds must provide "MSVCBATCALL". MinGW builds must not provide "MSVCBATCALL".
	--   if there is "path" and no "PATHSET" we calculate the PATHSET for user. If both are missing the PATHSET will be "". "path" should be a table with numbered index
	--   if there is "download" the final script will download and extract the needed files.
	-- QQtPatcher buildContent is designed to be put in EXTRAINSTALL so there is neither seprate PATHSET nor ENVSET
	--   however, MAKE is needed
	local paraCopy = {}
	for k, v in pairs(para) do
		paraCopy[k] = v
	end

	-- check paraCopy.template && paraCopy.buildContent
	local template = self[para.template]["template4" .. para.buildContent]
	if not template then
		return
	end

	if template == "OpenSSLAndroidAll" then
		if para.template ~= "unix" then
			print("[Generate.generate] ERROR: Generation of OpenSSL Android All builds is not available in para.template ~= \"unix\"")
			os.exit(1)
		end
	end

	if template ~= "QQtPatcher" then
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
				if not paraCopy.DOWNLOADPACKAGE then
					paraCopy.DOWNLOADPACKAGE = ""
				end
				paraCopy.DOWNLOADPACKAGE = paraCopy.DOWNLOADPACKAGE .. self[para.template].download .. " \"" .. filename .. "\" \"" .. url .. "\"\n"
				if not paraCopy.UNCOMPRESSPACKAGE then
					paraCopy.UNCOMPRESSPACKAGE = ""
				end
				paraCopy.UNCOMPRESSPACKAGE = paraCopy.UNCOMPRESSPACKAGE .. self[para.template].extract[tool] .. " \"" .. filename .. "\"\n"
				if not paraCopy.DELETEUNCOMPRESSED then
					paraCopy.DELETEUNCOMPRESSED = ""
				end
				paraCopy.DELETEUNCOMPRESSED = paraCopy.DELETEUNCOMPRESSED .. self[para.template].delete .. " \"" .. filename .. "\"\n"
			end
		end
	end
	if para.msvcBat then
		if para.template == "win" then
			paraCopy.MSVCBATCALL = "call \"" .. para.msvcBat .. "\"\n" .. "echo on\n"
		else
			print("[Generate.generate] WARNING: para.msvcBat is set when para.template ~= \"win\"")
		end
	end
	if para.emBat then
		if para.template == "win" then
			-- emsdk construct_env on Windows nukes local paths https://github.com/emscripten-core/emsdk/issues/189
			-- the associated pull request has not closed yet
			paraCopy.EMCALL = "call " .. para.emBat .. "\nif errorlevel 1 exit 1\n" .. "echo on\nset PATH=%TOOLSPATH%;%PATH%\n"
		else
			-- emsdk failes to compile a program when switching from high version to lower version.
			-- It seems to be cache problem. Removing cache seems work with a simple program like "int main(){return 0;}".
			paraCopy.EMCALL = para.emBat .. "\n[ $? -eq 0 ] || exit 1\n. " .. para.emSource .. "\nrm -rf $EM_CACHE\n"
		end
	end
	if para.buildContent == "Qt" then
		paraCopy.INSTALLPATHWITHDATE = para.INSTALLPATH .. "-" .. para.date
	end

	local ret = string.gsub(template, "%&([%w_]+)%&", function(s)
			if paraCopy[s] then
				return paraCopy[s]
			else
				return ""
			end
		end)

	return ret
end

local mo = {
	__call = function(self, para)
		return self:generate(para)
	end,
}

setmetatable(gen, mo)

return gen
