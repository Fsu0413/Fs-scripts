local conf = {}

conf.host = {}

conf.host.win = {
	-- Preinstalled jom(need to set path manually)
	-- Preinstalled MSVC(need to set path manually)
	-- Preinstalled MinGW-w64 toolchain(need to set path manually)
	-- Preinstalled CMake and ninja
	-- Preinstalled Android-NDK/SDK toolchain
	-- Preinstalled emsdk toolchain
	["makefileTemplate"] = "win",
	["pathSep"] = '\\',
	["toolchainPath"] = {
		-- for MSVC, it is a bat file with parameter, for MinGW, it is a path to the bin folder of the toolchain
		["MSVC2019-32"] = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Auxiliary\\Build\\vcvarsamd64_x86.bat",
		["MSVC2019-64"] = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Auxiliary\\Build\\vcvars64.bat",
		["MSVC2017-arm64"] = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Auxiliary\\Build\\vcvarsamd64_arm64.bat",
		["MSVC2017-32"] = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Auxiliary\\Build\\vcvarsamd64_x86.bat",
		["MSVC2017-64"] = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Auxiliary\\Build\\vcvars64.bat",
		["MSVC2015-32"] = "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\bin\\amd64_x86\\vcvarsamd64_x86.bat",
		["MSVC2015-64"] = "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\bin\\amd64\\vcvars64.bat",

		["MinGW730-32"] = "D:\\mingw-w64\\7.3.0\\mingw32\\bin",
		["MinGW730-64"] = "D:\\mingw-w64\\7.3.0\\mingw64\\bin",
		["MinGW810-32"] = "D:\\mingw-w64\\8.1.0\\mingw32\\bin",
		["MinGW810-64"] = "D:\\mingw-w64\\8.1.0\\mingw64\\bin",
	},
	["sourcePackagePath"] = "D:\\Qt\\",
	["buildRootPath"] = "D:\\Qt\\", -- On Windows, the build root should be same with source package
	["androidSdkPath"] = {
		["Latest"] = "D:\\android-sdk-windows",
	},
	["androidNdkPath"] = {
		["r21e"] = "D:\\android-ndk-r21e",
		["r23"] = "D:\\android-ndk-r23",
	},
	["androidNdkHost"] = "windows-x86_64",
	["emscriptenPath"] = "D:\\emsdk\\",
	["cMakePath"] = { "D:\\cmake-3.20.2-windows-x86_64\\bin", "D:\\ninja" },
}

-- msys is treated as another host since it uses windows agent and unix shell
-- used in compiling OpenSSL
conf.host.msys = {
	-- Preinstalled Android-NDK toolchain
	-- Preinstalled GNU make in path and is used
	-- Preinstalled MinGW-w64 toolchain(need to set path manually)
	-- Preinstalled p7zip in path and is used
	["makefileTemplate"] = "unix",
	["pathSep"] = '/',
	["toolchainPath"] = {
		["MinGW730-32"] = "/d/mingw-w64/7.3.0/mingw32/bin/",
		["MinGW730-64"] = "/d/mingw-w64/7.3.0/mingw64/bin/",
		["MinGW810-32"] = "/d/mingw-w64/8.1.0/mingw32/bin/",
		["MinGW810-64"] = "/d/mingw-w64/8.1.0/mingw64/bin/",
	},
	["sourcePackagePath"] = "/d/Qt/",
	["androidNdkPath"] = {
		["r21e"] = "/d/android-ndk-r21e/",
		["r23"] = "/d/android-ndk-r23/",
	},
	["androidNdkHost"] = "windows-x86_64",
}

conf.host.linux = {
	-- Preinstalled OpenSSL(using software source)
	-- Preinstalled GNU make in path and is used
	-- Preinstalled CMake and ninja in path and is used
	-- Preinstalled Android-NDK/SDK toolchain
	-- Preinstalled emsdk toolchain
	-- Preinstalled host toolchain in path and is used
	-- Preinstalled p7zip in path and is used
	["makefileTemplate"] = "unix",
	["pathSep"] = '/',
	["androidSdkPath"] = {
		["Latest"] = "/opt/env/android-sdk-linux/",
	},
	["androidNdkPath"] = {
		["r21e"] = "/opt/env/android-ndk-r21e/",
		["r23"] = "/opt/env/android-ndk-r23/",
	},
	["androidNdkHost"] = "linux-x86_64",
	["sourcePackagePath"] = "/opt/sources/",
	["buildRootPath"] = "/opt/build/",
	["emscriptenPath"] = "/opt/env/emsdk/",
}

conf.host.mac = {
	-- Preinstalled GNU make in path and is used
	-- Preinstalled CMake and ninja in path and is used
	-- Preinstalled Android-NDK/SDK toolchain
	-- Preinstalled emsdk toolchain
	-- Preinstalled host toolchain in path and is used
	-- Preinstalled p7zip in path and is used
	["makefileTemplate"] = "unix",
	["pathSep"] = '/',
	["androidSdkPath"] = {
		["Latest"] = "/opt/env/android-sdk-mac-2/",
	},
	["androidNdkPath"] = {
		["r21e"] = "/opt/env/android-ndk-r21e/",
		["r23"] = "/Applications/AndroidNDK7599858.app/Contents/NDK/", -- NDK r23 only distributes as APP bundle...
	},
	["androidNdkHost"] = "darwin-x86_64",
	["sourcePackagePath"] = "/opt/sources/",
	["buildRootPath"] = "/opt/build/",
	["emscriptenPath"] = "/opt/env/emsdk/",
}

conf.host.macLegacy = {
	-- Preinstalled GNU make in path and is used
	-- Preinstalled host toolchain in path and is used
	-- Preinstalled p7zip in path and is used
	["makefileTemplate"] = "unix",
	["pathSep"] = '/',
	["sourcePackagePath"] = "/Volumes/opt/sources/",
	["buildRootPath"] = "/Volumes/opt/build/",
}

--[[ conf.host.linuxarm = {} ]] -- Todo: Prepare an arm linux host. It should be hosted on my old mobile phone, I assumed.

conf.Qt = {}

conf.Qt.configurations = dofile(scriptPath .. "/lib/qtCompile/conf.lua")

conf.Qt.generateConfTable = function(self, host, job)
	local confHost = conf.host[conf.hostToConfMap[host]]
	local confDetail = conf.Qt.configurations[job]

	local ret = {}
	ret.buildContent = "Qt"
	ret.template = confHost.makefileTemplate
	ret.path = {}
	ret.WORKSPACE = os.getenv("WORKSPACE")
	-- dirty hack here for Windows drive since Windows services always starts in drive C
	if confHost.makefileTemplate == "win" and string.sub(ret.WORKSPACE, 1, 26) == "C:\\Users\\Fs\\Work\\Jenkins10" then
		local rightpart = string.sub(ret.WORKSPACE, 27)
		ret.WORKSPACE = "D:\\Jenkins10" .. rightpart
	end
	-- dirty hack end
	ret.BUILDDIR = confHost.buildRootPath .. "build-Qt" .. job
	ret.download = {}

	if confDetail.toolchain ~= "PATH" then
		if string.sub(confDetail.toolchain, 1, 4) == "MSVC" then
			ret.msvcBat = confHost.toolchainPath[confDetail.toolchain]
			for _, p in ipairs(confHost.cMakePath) do
				table.insert(ret.path, p)
			end
		else
			table.insert(ret.path, confHost.toolchainPath[confDetail.toolchain])
			for _, p in ipairs(confHost.cMakePath) do
				table.insert(ret.path, p)
			end
		end
	end

	ret.envSet = {}

	local repl = {}

	ret.SOURCEFILE = confDetail["sourcePackageFileName" .. confHost.makefileTemplate]
	ret.date = string.format("%04d%02d%02d", BuildTime.year, BuildTime.month, BuildTime.day)
	local installFolderName =  confDetail.name
	local installRoot = ret.WORKSPACE .. confHost.pathSep .. "buildDir" .. confHost.pathSep .. installFolderName

	if confDetail.opensslConf then
		table.insert(ret.download, conf.OpenSSL:binaryFileDownloadPath(host, confDetail.opensslConf))
		repl.OPENSSLDIR = ret.WORKSPACE .. confHost.pathSep .. "buildDir" .. confHost.pathSep .. conf.OpenSSL.configurations[confDetail.opensslConf].name
		if confDetail.OPENSSL_LIBS then
			local opensslLibs = string.gsub(confDetail.OPENSSL_LIBS, "%&OPENSSLDIR%&", repl.OPENSSLDIR)
			ret.envSet.OPENSSL_LIBS = opensslLibs
		end
	end

	if confDetail.crossCompile then
		-- Qt 6: We need host tool to cross build Qt
		if confDetail.hostToolsConf then
			table.insert(ret.download, confDetail["hostToolsUrl" .. confHost.makefileTemplate])
			repl.HOSTQTDIR = ret.WORKSPACE .. confHost.pathSep .. "buildDir" .. confHost.pathSep .. conf.Qt.configurations[confDetail.hostToolsConf].name
		end

		if string.sub(confDetail.toolchainT, 1, 7) == "Android" then -- Android
			local matchStr = "Android%-(%d+)%-(r%d+%a?)%-(.+)"
			local api, ndkVer, archi = string.match(confDetail.toolchainT, matchStr)
			if api then
				repl.ANDROIDNDKROOT = confHost.androidNdkPath[ndkVer]
			else
				error("Android - confDetail.toolchainT is not matched")
			end

			if confDetail.androidSdkVersion then
				repl.ANDROIDSDKROOT = confHost.androidSdkPath[confDetail.androidSdkVersion]
			else
				error("Android - confDetail.androidSdkVersion is not set")
			end
		elseif string.sub(confDetail.toolchainT, 1, 10) == "emscripten" then -- WebAssembly
			local matchStr = "emscripten%-((%d+)%.(%d+)%.%d+)"
			local emsdkVer, ver1, ver2 = string.match(confDetail.toolchainT, matchStr)
			if emsdkVer then
				-- emsdk renamed their 1.38.x releases from "sdk-1.38.x-64bit" to "sdk-fastcomp-1.38.x-64bit", so...
				if ver1 == "1" and ver2 == "38" then
					emsdkVer = "fastcomp-" .. emsdkVer
				end
				ret.emBat = confHost.emscriptenPath .. "emsdk activate sdk-" .. emsdkVer .. "-64bit"
				if confHost.makefileTemplate == "unix" then
					ret.emSource =  confHost.emscriptenPath .. "emsdk_env.sh"
				end
			else
				error("WebAssembly - confDetail.toolchainT is not matched")
			end
		elseif string.sub(confDetail.toolchainT, 1, 4) == "MSVC" then -- Windows UWP/ARM64 Desktop
			-- Nothing needed to do
		elseif string.sub(confDetail.toolchainT, 1, 11) == "GCCForLinux" then -- GNU/Linux cross builds(Todo)
			error("todo....")
		elseif string.sub(confDetail.toolchainT, 1, 5) == "MinGW" then -- MinGW cross builds(Todo)
			error("todo....")
		end
	end

	repl.INSTALLROOT = installRoot

	local sourcePackageBaseName = confDetail.sourcePackageBaseName

	if not confDetail.useCMake then
		ret.CONFIGURECOMMANDLINE = confHost.sourcePackagePath .. sourcePackageBaseName .. confHost.pathSep .. "configure "
	else
		ret.CONFIGURECOMMANDLINE = "cmake "
	end
	ret.CONFIGURECOMMANDLINE = ret.CONFIGURECOMMANDLINE .. string.gsub(string.gsub(confDetail.configureParameter, "%&([%w_]+)%&", function(s)
		if repl[s] then
			return repl[s]
		else
			return ""
		end
	end), "%s+", " ")
	if confDetail.useCMake then
		ret.CONFIGURECOMMANDLINE = ret.CONFIGURECOMMANDLINE .. confHost.sourcePackagePath .. sourcePackageBaseName
	end
	if (string.sub(confDetail.qtVersion, 1, 2) == "6.") and confDetail.crossCompile and (string.sub(confDetail.toolchainT, 1, 10) == "emscripten") then
		ret.CONFIGURECOMMANDLINE = "emconfigure " .. ret.CONFIGURECOMMANDLINE
	end

	if not confDetail.useCMake then
		if confHost.makefileTemplate == "unix" then
			ret.MAKE = "make -j$PARALLELNUM"
		elseif string.sub(confDetail.toolchain, 1, 5) == "MinGW" then
			ret.MAKE = "mingw32-make -j%PARALLELNUM%"
		elseif string.sub(confDetail.toolchain, 1, 4) == "MSVC" then
			ret.MAKE = "jom"
		else
			error("not supported")
		end
	else
		-- let CMake call the underlayer make tool
		ret.MAKE = "cmake --build . --parallel -- "
	end
	if (string.sub(confDetail.qtVersion, 1, 2) == "6.") and confDetail.crossCompile and (string.sub(confDetail.toolchainT, 1, 10) == "emscripten") then
		ret.MAKE = "emmake " .. ret.MAKE
	end

	if not confDetail.useCMake then
		ret.INSTALLCOMMANDLINE = ret.MAKE .. " install "
		if confDetail.crossCompile then
			local installRootMake = installRoot
			if confHost.makefileTemplate == "win" then
				-- suppress "X:" in INSTALLROOT.
				-- File names with colons in Windows filesystem is not available, so...
				if string.sub(installRoot, 2, 2) == ":" then
					installRootMake = string.sub(installRoot, 3)
				end
			end
			ret.INSTALLCOMMANDLINE = ret.INSTALLCOMMANDLINE .. "\"INSTALL_ROOT=" .. installRootMake .. "\""
		end
	else
		-- $MAKE install calls cmake --install, so let's call cmake --install directly
		-- strip the binary for smaller size
		ret.INSTALLCOMMANDLINE = "cmake --install . --strip"
	end

	ret.INSTALLROOT = installRoot
	ret.INSTALLPATH = installFolderName

	ret.EXTRAINSTALL = ""

	-- Qt host tool deploy
	if confDetail.crossCompile and confDetail.hostToolsConf then
		local deployShellCommand = scriptPath .. "/../qt6_deploy_host.sh"
		if confHost.makefileTemplate == "win" then
			deployShellCommand = "cscript " .. scriptPath .. "/../qt6_deploy_host.vbs"
		end
		ret.EXTRAINSTALL = ret.EXTRAINSTALL .. deployShellCommand .. " " .. installRoot .. " " .. repl.HOSTQTDIR .. "\n"
	end

	-- Qt configure file
	local copyCmd = ((confHost.makefileTemplate == "unix") and "cp -f " or "copy /y ")
	for _, file in ipairs(confDetail.configFile) do
		if confHost.makefileTemplate == "win" then
			file = string.gsub(file, "%/", "\\")
		end
		ret.EXTRAINSTALL = ret.EXTRAINSTALL .. copyCmd .. " " .. ret.BUILDDIR .. confHost.pathSep .. file .. " " .. installRoot .. "\n"
	end

	-- OpenSSL libraries
	if confDetail.opensslConf then
		-- check for static builds
		local staticBuild = false
		for _, v in ipairs(confDetail.variant) do
			if (v == "-static") or (v == "-staticFull") then
				staticBuild = true
				break
			end
		end
		local opensslLibPath = conf.OpenSSL.configurations[confDetail.opensslConf][(staticBuild and "static" or "") .. "libPath"]
		if opensslLibPath then
			local targetDir = "lib"
			-- todo: deal with the condition where the openssl libs are symbolic link to the real file (only for unix)
			if string.sub(opensslLibPath[1], -4) == ".dll" then
				targetDir = "bin"
			end
			for _, path in ipairs(opensslLibPath) do
				ret.EXTRAINSTALL = ret.EXTRAINSTALL .. copyCmd .. repl.OPENSSLDIR .. confHost.pathSep .. path .. " " .. installRoot .. confHost.pathSep .. targetDir .. "\n"
			end
		end
	end

	local qQtPatcherTable = nil
	if confDetail.qQtPatcher ~= "no" then
		-- QQtPatcher
		if confDetail.qQtPatcher == "build" then
			qQtPatcherTable = {
				buildContent = "QQtPatcher",
				template = confHost.makefileTemplate,
				QTDIR = installRoot,
				MAKE = ret.MAKE,
				VERSION = confDetail.qQtPatcherVersion,
			}
			table.insert(ret.download, confDetail["qQtPatcherSourceUrl" .. confHost.makefileTemplate])
		else
			table.insert(ret.download, confDetail["qQtPatcherUrl" .. confHost.makefileTemplate])
		end
		ret.EXTRAINSTALL = ret.EXTRAINSTALL .. copyCmd .. "QQtPatcher" .. (((confHost.makefileTemplate == "unix") and (conf.hostToConfMap[host] ~= "msys")) and "" or ".exe") .. " " .. installRoot .. "\n"

		if (confHost.makefileTemplate == "unix") and (conf.hostToConfMap[host] ~= "msys") then
			ret.EXTRAINSTALL = ret.EXTRAINSTALL .. "chmod +x " .. installRoot .. "/QQtPatcher\n"
		end
	end

	return ret, qQtPatcherTable
end

conf.OpenSSL = {}

conf.OpenSSL.configurations = dofile(scriptPath .. "/lib/opensslCompile/conf.lua")

conf.OpenSSL.generateConfTable = function(self, host, job)
	local confHost = conf.host[conf.hostToConfMap[host]]
	local confDetail = conf.OpenSSL.configurations[job]

	if confDetail.opensslAndroidAll then
		local ret = {}
		ret.buildContent = "OpenSSLAndroidAll"
		ret.template = confHost.makefileTemplate
		ret.path = {}
		ret.WORKSPACE = os.getenv("WORKSPACE")
		-- dirty hack here for Windows drive since Windows services always starts in drive C
		if confHost.makefileTemplate == "win" and string.sub(ret.WORKSPACE, 1, 26) == "C:\\Users\\Fs\\Work\\Jenkins10" then
			local rightpart = string.sub(ret.WORKSPACE, 27)
			ret.WORKSPACE = "D:\\Jenkins10" .. rightpart
		end
		-- dirty hack end
		ret.INSTALLROOT = ret.WORKSPACE .. confHost.pathSep .. "buildDir" .. confHost.pathSep .. confDetail.name
		ret.INSTALLPATH = confDetail.name
		ret.OPENSSLDIRFUNCTION = ""
		ret.download = {}

		local repl = {}
		repl.arch = {}

		for arch, androidConf in pairs(confDetail.opensslAndroidAll) do
			table.insert(ret.download, conf.OpenSSL:binaryFileDownloadPath(host, androidConf))
			ret.OPENSSLDIRFUNCTION = ret.OPENSSLDIRFUNCTION .. "if [ \"x$1\" = \"x" .. arch .. "\" ]; then\n" .. "CURRENTARCHDIR=\"" .. conf.OpenSSL.configurations[androidConf].name .. "\"\nexport CURRENTARCHDIR\nel"
			table.insert(repl.arch, arch)
		end

		ret.ARCHITECTURES = repl.arch[1]
		for i = 2, #repl.arch, 1 do
			ret.ARCHITECTURES = ret.ARCHITECTURES .. " " .. repl.arch[i]
		end

		ret.OPENSSLDIRFUNCTION = ret.OPENSSLDIRFUNCTION .. "se\nreturn 1\nfi"

		return ret
	else
		local ret = {}
		ret.buildContent = "OpenSSL"
		ret.template = confHost.makefileTemplate
		ret.path = {}
		ret.WORKSPACE = os.getenv("WORKSPACE")
		-- dirty hack here for Windows drive since Windows services always starts in drive C
		if confHost.makefileTemplate == "win" and string.sub(ret.WORKSPACE, 1, 26) == "C:\\Users\\Fs\\Work\\Jenkins10" then
			local rightpart = string.sub(ret.WORKSPACE, 27)
			ret.WORKSPACE = "D:\\Jenkins10" .. rightpart
		end
		-- dirty hack end
		ret.BUILDDIR = ret.WORKSPACE .. confHost.pathSep .. "buildDir" .. confHost.pathSep .. "build-OpenSSL" .. job
		ret.INSTALLCOMMANDLINE = " "
		ret.download = {}
		table.insert(ret.download, confDetail["sourcePackageUrl" .. confHost.makefileTemplate])

		if confDetail.toolchain ~= "PATH" then
			if string.sub(confDetail.toolchain, 1, 4) == "MSVC" then
				ret.msvcBat = confHost.toolchainPath[confDetail.toolchain]
			else
				table.insert(ret.path, confHost.toolchainPath[confDetail.toolchain])
			end
		end

		ret.envSet = {}

		local repl = {}
		repl.parameter = {}

		local installFolderName =  confDetail.name
		local installRoot = ret.WORKSPACE .. confHost.pathSep .. "buildDir" .. confHost.pathSep .. installFolderName

		repl.INSTALLROOT = installRoot

		if confDetail.crossCompile then
			if string.sub(confDetail.toolchainT, 1, 7) == "Android" then -- Android
				-- Let's use NDK package directly
				local matchStr = "Android%-(%d+)%-(r%d+%a?)%-(.+)"
				local api, ndkVer, archi = string.match(confDetail.toolchainT, matchStr)
				if api then
					ret.envSet.ANDROID_NDK_HOME = confHost.androidNdkPath[ndkVer]
					ret.envSet.CC = "clang"
					table.insert(ret.path, confHost.androidNdkPath[ndkVer] .. confHost.pathSep .. "toolchains" .. confHost.pathSep .. "llvm" .. confHost.pathSep .. "prebuilt" .. confHost.pathSep .. confHost.androidNdkHost .. confHost.pathSep .. "bin")
					ret.INSTALLCOMMANDLINE = ret.INSTALLCOMMANDLINE .. " DESTDIR=" .. installRoot .. " "
				else
					error("confDetail.toolchainT is not matched")
				end
			elseif string.sub(confDetail.toolchainT, 1, 10) == "emscripten" then -- WebAssembly
				error("todo....")
			elseif string.sub(confDetail.toolchainT, 1, 4) == "MSVC" then -- Windows UWP/ARM64 Desktop
				-- First, deal with ret.msvcBat
				ret.msvcBat = confHost.toolchainPath[confDetail.toolchainT]
				-- ... then copy what host build of MSVC does.
				-- nothing special
			elseif string.sub(confDetail.toolchainT, 1, 11) == "GCCForLinux" then -- GNU/Linux cross builds(Todo)
				error("todo....")
			elseif string.sub(confDetail.toolchainT, 1, 5) == "MinGW" then -- MinGW cross builds(Todo)
				error("todo....")
			else
				error("not supported")
			end
		else
			if string.sub(confDetail.toolchain, 1, 4) == "MSVC" then -- if conf.hostToConfMap[host] == "win" then
				-- nothing special
			elseif string.sub(confDetail.toolchain, 1, 5) == "MinGW" then -- elseif conf.hostToConfMap[host] == "msys" then
				-- nothing special
			elseif conf.hostToConfMap[host] == "mac" then
				-- OpenSSL build for macOS is not used when compiling Qt 5. Since build of Qt 4 has been defuncted, this may also be defuncted.
				error("defuncted")
			else
				error("not supported")
			end
		end

		local configureArgs = ""
		for _, p in ipairs(repl.parameter) do
			configureArgs = configureArgs .. " " .. p
		end

		ret.CONFIGURECOMMANDLINE = "perl ../" .. confDetail.sourcePackageBaseName .. "/Configure "
		ret.CONFIGURECOMMANDLINE = ret.CONFIGURECOMMANDLINE .. string.gsub(string.gsub(confDetail.configureParameter, "%&([%w_]+)%&", function(s)
			if repl[s] then
				return repl[s]
			else
				return ""
			end
		end), "%s+", " ")

		if confHost.makefileTemplate == "unix" then
			-- OpenSSL on MinGW is using MSYS2, so only runs on Unix environment
			ret.MAKE = "make -j$PARALLELNUM"
		elseif string.sub(confDetail.toolchain, 1, 4) == "MSVC" then
			-- MSVC version of Makefile supports only nmake, jom is not supported offically
			-- some pull requests which tries to support jom on MSVC builds are simply closed.
			-- OpenSSL maintainers said that cmake can't cover their supported platforms, so they use a custom build system.
			-- It seems reasonable but is not the reason why they don't support a 'speed-boosting drop-in replacement' make tool with just a few workarounds.

			-- currently adding "/FS" to the compiler command line, but it fails randomly.
			-- Retry is added when build fails, for 3 times.
			ret.MAKE = "jom"
		else
			error("not supported")
		end

		ret.INSTALLCOMMANDLINE = ret.MAKE .. " install_sw install_ssldirs " .. ret.INSTALLCOMMANDLINE

		ret.INSTALLROOT = installRoot
		ret.INSTALLPATH = confDetail.name

		return ret
	end
end

conf.OpenSSL.binaryFileDownloadPath = function(self, host, job)
	local confHost = conf.host[conf.hostToConfMap[host]]
	return conf.OpenSSL.configurations[job]["binaryPackageUrl" .. confHost.makefileTemplate]
end

conf.buildContent = function(self, buildJob)
	if (string.sub(buildJob, 1, 1) == 'Q') or (string.sub(buildJob, 1, 1) == "q") then
		return "Qt"
	elseif (string.sub(buildJob, 1, 1) == 'o') then
		return "OpenSSL"
	else
		error(buildJob .. " is not supported.")
	end
end

conf.hostToConfMap = {
	["Win10"] = "win",
	["Win8"] = "win",
	["Win8SH"] = "msys",
	["CentOS8"] = "linux",
	["macOS1015"] = "mac",
	["macOSLegacy"] = "macLegacy",
}

return conf
