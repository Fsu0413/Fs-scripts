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

&MSVCBATCALL&
&EMCALL&

&PATHSET&

&ENVSET&

rmdir /s /q &BUILDDIR&
mkdir &BUILDDIR&
cd /d &BUILDDIR&

set PARALLELNUM=0

set /a PARALLELNUM=%NUMBER_OF_PROCESSORS%+1

set j=0

cmd /c &CONFIGURECOMMANDLINE&
if errorlevel 1 &CONFIGFAIL&

:RESUME

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

7z a -t7z -m0=LZMA2:d256m:fb273 -mmt=3 -myx -mqs -ms=on -- &INSTALLPATHWITHDATE&.7z &INSTALLPATH&
copy /y &INSTALLPATHWITHDATE&.7z &INSTALLPATH&.7z

exit 0

:LOOP2

set /a j=%j%+1
if %j% gtr 3 exit 1
cmd /c &CONFIGRETRY&
if errorlevel 1 goto LOOP2

goto RESUME

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

7z a -t7z -m0=LZMA2:d256m:fb273 -mmt=3 -myx -mqs -ms=on -- &INSTALLPATH&.7z &INSTALLPATH&

]]

gen.unix = {}

gen.unix.pathEnvPre = "PATH=\""
gen.unix.pathEnvSep = ":"
gen.unix.pathEnvSuf = "$PATH\"; export PATH"

gen.unix.envPre = "&ENVNAME&=\""
gen.unix.envSuf = "\"; export &ENVNAME&"

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

&EMCALL&

&PATHSET&

&ENVSET&

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
	if $i; then
		SEVENZIP=$i
		break
	fi
done

if [ "x$SEVENZIP" = "x" ]; then
	echo "7-zip not found" >&2
	exit 1
fi

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

&PATHSET&

&ENVSET&

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
	if $i; then
		SEVENZIP=$i
		break
	fi
done

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

gen.generate = function(self, para)
	-- para.template should be "unix" or "win"
	-- para.buildContent should be "Qt" or "OpenSSL" or "QQtPatcher"
	-- other contents in para goes to the replacement function
	-- for buildContent other than QQtPatcher:
	--   "MAKE" "SOURCEFILE" "CONFIGURECOMMANDLINE" "date" must be provided. Fails if either one is missing.
	--   MSVC builds must provide "MSVCBATCALL". MinGW builds must not provide "MSVCBATCALL".
	--   if there is "path" and no "PATHSET" we calculate the PATHSET for user. If both are missing the PATHSET will be "". "path" should be a table with numbered index
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

	if template ~= "QQtPatcher" then
		if not para.PATHSET then
			if para.path and (type(para.path) == "table") then
				paraCopy.PATHSET = pathEnvCalc(self[para.template], para.path)
			end
		end

		if para.envSet then
			paraCopy.ENVSET = otherEnvCalc(self[para.template], para.envSet)
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
	if para.reconfigure then
		if para.template == "win" then
			paraCopy.CONFIGFAIL = "goto LOOP2"
			paraCopy.CONFIGRETRY = para.reconfigure
		else
			-- todo
		end
	else
		if para.template == "win" then
			paraCopy.CONFIGFAIL = "exit 1"
		else
			-- todo
		end
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
