local conf = {}

local compilerVer = require("CompilerVer")

conf.host = {}

conf.host.win = {
	-- Preinstalled jom in path and is used
	-- Preinstalled MSVC (need to set path manually)
	-- Preinstalled MinGW-w64 toolchain (need to set path manually)
	-- Preinstalled CMake and ninja in path and used
	-- Preinstalled Android-NDK/SDK toolchain
	-- Preinstalled emsdk toolchain
	["makefileTemplate"] = "win",
	["pathSep"] = '\\',
	["toolchainPath"] = {
		-- MSVC toolchains
		-- Since MSVC toolchain must be configured using BAT file, we make this file appear FIRST in the table
		-- For building QtWebEngine 6.2+ on Windows, GnuWin32 is needed. Qt removes GnuWin32 since 6.0, so manually add it here
		["MSVC2022-64"] = {"C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\VC\\Auxiliary\\Build\\vcvars64.bat", "D:\\gnuwin32\\bin"},
		["MSVC2019-32"] = {"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Auxiliary\\Build\\vcvarsamd64_x86.bat", "D:\\gnuwin32\\bin"},
		["MSVC2019-64"] = {"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Auxiliary\\Build\\vcvars64.bat", "D:\\gnuwin32\\bin"},
		["MSVC2017-32"] = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Auxiliary\\Build\\vcvarsamd64_x86.bat",
		["MSVC2017-64"] = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Auxiliary\\Build\\vcvars64.bat",
		["MSVC2015-32"] = "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\bin\\amd64_x86\\vcvarsamd64_x86.bat",
		["MSVC2015-64"] = "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\bin\\amd64\\vcvars64.bat",

		-- MSVC toolchains with Clang / LLVM, currently not used
		-- use official LLVM prebuilt binary
		["MSVC2019LLVM-64"] = {"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Auxiliary\\Build\\vcvars64.bat", "D:\\LLVM\\bin", "D:\\gnuwin32\\bin"},

		-- MSVC2017 toolchains ARM64, currently not used
		["MSVC2017-arm64"] = "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Auxiliary\\Build\\vcvarsamd64_arm64.bat",

		-- MinGW toolchains with GCC / Binutils, only path
		["MinGW730-32"] = "D:\\mingw-w64\\7.3.0\\mingw32\\bin",
		["MinGW730-64"] = "D:\\mingw-w64\\7.3.0\\mingw64\\bin",
		["MinGW810-32"] = "D:\\mingw-w64\\8.1.0\\mingw32\\bin",
		["MinGW810-64"] = "D:\\mingw-w64\\8.1.0\\mingw64\\bin",
		["MinGW1120-64"] = "D:\\mingw-w64\\11.2.0-4\\mingw64\\bin",
		["MinGW1210-64"] = "D:\\mingw-w64\\12.1.0\\mingw64\\bin",

		-- MinGW toolchains with Clang / LLVM, currently used in Qt 6 only
		-- LLVM always acts as an cross compiler, but the target libraries are architecture-dependent
		-- Since some binaries built also acts as host tool, we should add the target libraries to PATH too, otherwise the program won't start
		["MinGWLLVM-msvcrt15-64"] = {"D:\\mingw-w64\\llvm-mingw-20220906-msvcrt-x86_64\\x86_64-w64-mingw32\\bin", "D:\\mingw-w64\\llvm-mingw-20220906-msvcrt-x86_64\\bin"},
		["MinGWLLVM-ucrt15-64"] = {"D:\\mingw-w64\\llvm-mingw-20220906-ucrt-x86_64\\x86_64-w64-mingw32\\bin", "D:\\mingw-w64\\llvm-mingw-20220906-ucrt-x86_64\\bin"},
	},
	["sourcePackagePath"] = "D:\\Qt\\",
	["buildRootPath"] = "D:\\Qt\\", -- On Windows, the build root should be same with source package
	["androidSdkPath"] = {
		["29"] = "D:\\android-sdk-windows",
		["Latest"] = "D:\\android-sdk-windows-20220911",
	},
	["androidNdkPath"] = {
		["r21e"] = "D:\\android-ndk-r21e",
		["r23c"] = "D:\\android-ndk-r23c",
		["r25b"] = "D:\\android-ndk-r25b",
	},
	["androidNdkHost"] = "windows-x86_64",
	["emscriptenPath"] = {
		["1.39.8"] = "D:\\emsdk-1.39.8\\",
		["2.0.14"] = "D:\\emsdk-2.0.14\\",
		["3.1.6"] = "D:\\emsdk-3.1.6\\",
		["3.1.14"] = "D:\\emsdk-3.1.14\\",
	},
	["cMakePath"] = {
		["20"] = {"D:\\cmake-3.20.2-windows-x86_64\\bin", "D:\\ninja"},
		["Latest"] = {"D:\\cmake-3.24.2-windows-x86_64\\bin", "D:\\ninja"},
	},
	["jdkPath"] = {
		["8"] = "D:\\OpenJDK8U-jdk_x64_windows_hotspot_8u332b09\\jdk8u332-b09",
		["11"] = "D:\\OpenJDK11U-jdk_x64_windows_hotspot_11.0.15_10\\jdk-11.0.15+10",
	},
	["pythonPath"] = {
		["2"] = "D:\\Python27",
		["3"] = "D:\\Python39",
	},
	["defaultToolchainExecutableName"] = "gcc",
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
		["MinGW1120-64"] = "/d/mingw-w64/11.2.0-4/mingw64/bin/",
		["MinGW1210-64"] = "/d/mingw-w64/12.1.0/mingw64/bin/",

		["MinGWLLVM-msvcrt15-64"] = {"/d/mingw-w64/llvm-mingw-20220906-msvcrt-x86_64/x86_64-w64-mingw32/bin", "/d/mingw-w64/llvm-mingw-20220906-msvcrt-x86_64/bin"},
		["MinGWLLVM-ucrt15-64"] = {"/d/mingw-w64/llvm-mingw-20220906-ucrt-x86_64/x86_64-w64-mingw32/bin", "/d/mingw-w64/llvm-mingw-20220906-ucrt-x86_64/bin"},
	},
	["sourcePackagePath"] = "/d/Qt/",
	["androidNdkPath"] = {
		["r21e"] = "/d/android-ndk-r21e/",
		["r23c"] = "/d/android-ndk-r23c/",
		["r25b"] = "/d/android-ndk-r25b/",
	},
	["androidNdkHost"] = "windows-x86_64",
	["defaultToolchainExecutableName"] = "gcc",
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
		["29"] = "/opt/env/android-sdk-linux/",
		["Latest"] = "/opt/env/android-sdk-linux-20220911/",
	},
	["androidNdkPath"] = {
		["r21e"] = "/opt/env/android-ndk-r21e/",
		["r23c"] = "/opt/env/android-ndk-r23c/",
		["r25b"] = "/opt/env/android-ndk-r25b/",
	},
	["androidNdkHost"] = "linux-x86_64",
	["sourcePackagePath"] = "/opt/sources/",
	["buildRootPath"] = "/opt/build/",
	["emscriptenPath"] = {
		["1.39.8"] = "/opt/env/emsdk-1.39.8/",
		["2.0.14"] = "/opt/env/emsdk-2.0.14/",
		["3.1.6"] = "/opt/env/emsdk-3.1.6/",
		["3.1.14"] = "/opt/env/emsdk-3.1.14/",
	},
	["jdkPath"] = {
		["8"] = "/usr/lib/jvm/java-1.8.0-openjdk",
		["11"] = "/usr/lib/jvm/java-11-openjdk",
	},
	["defaultToolchainExecutableName"] = "gcc",
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
		["29"] = "/opt/env/android-sdk-mac/",
		["Latest"] = "/opt/env/android-sdk-mac-20220911/",
	},
	["androidNdkPath"] = {
		["r21e"] = "/opt/env/android-ndk-r21e/",
		-- NDK after r23 only distributes as APP bundle, so we install the APP in /Applications.
		["r23c"] = "/Applications/AndroidNDK8568313.app/Contents/NDK/",
		["r25b"] = "/Applications/AndroidNDK8937393.app/Contents/NDK/",
	},
	["androidNdkHost"] = "darwin-x86_64",
	["sourcePackagePath"] = "/opt/sources/",
	["buildRootPath"] = "/opt/build/",
	["emscriptenPath"] = {
		["2.0.14"] = "/opt/env/emsdk-2.0.14/",
		["3.1.6"] = "/opt/env/emsdk-3.1.6/",
		["3.1.14"] = "/opt/env/emsdk-3.1.14/",
	},
	["defaultToolchainExecutableName"] = "clang",
}

conf.host.macLegacy = {
	-- Preinstalled GNU make in path and is used
	-- Preinstalled Android-NDK/SDK toolchain
	-- Preinstalled emsdk toolchain
	-- Preinstalled host toolchain in path and is used
	-- Preinstalled p7zip in path and is used
	["makefileTemplate"] = "unix",
	["pathSep"] = '/',
	["androidSdkPath"] = {
		["29"] = "/Volumes/opt/env/android-sdk-mac-2/",
		["Latest"] = "/Volumes/opt/env/android-sdk-mac-20220911/",
	},
	["androidNdkPath"] = {
		["r21e"] = "/Volumes/opt/env/android-ndk-r21e/",
		-- NDK after r23 only distributes as APP bundle, so we install the APP in /Applications.
		["r23c"] = "/Applications/AndroidNDK8568313.app/Contents/NDK/",
	},
	["androidNdkHost"] = "darwin-x86_64",
	["sourcePackagePath"] = "/Volumes/opt/sources/",
	["buildRootPath"] = "/Volumes/opt/build/",
	["emscriptenPath"] = {
		["1.39.8"] = "/opt/env/emsdk-1.39.8/",
	},
	["jdkPath"] = {
		["8"] = "/usr/local/opt/openjdk@8/",
		["11"] = "/usr/local/opt/java11/",
	},
	["defaultToolchainExecutableName"] = "clang",
}

--[[ conf.host.linuxarm = {} ]] -- Todo: Prepare an arm linux host. It should be hosted on my old mobile phone, I assumed, or raspi?

local replaceVersion = function(input, hostToolchainVersion, targetToolchainVersion)
	local output = input
	if hostToolchainVersion then
		output = string.gsub(output, "%&HOSTTOOLVERSION%&", tostring(hostToolchainVersion))
	end
	if targetToolchainVersion then
		output = string.gsub(output, "%&TARGETTOOLVERSION%&", tostring(targetToolchainVersion))
	end
	return output
end

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
	if confHost.makefileTemplate == "win" and string.sub(ret.WORKSPACE, 1, 24) == "C:\\Users\\Fs\\Work\\Jenkins" then
		local rightpart = string.sub(ret.WORKSPACE, 25)
		ret.WORKSPACE = "D:\\Jenkins" .. rightpart
	end
	-- dirty hack end
	ret.BUILDDIR = confHost.buildRootPath .. "build-Qt" .. job
	ret.download = {}
	
	-- DO REMEMBER TO USE tostring IF A VERSION STRING IS NEEDED!!
	local hostToolchainVersion, targetToolchainVersion
	local hostToolchainVersionQueryFuncName = "gcc"
	local hostToolchainVersionQueryPath
	local hostToolchainExecutableName = confHost.defaultToolchainExecutableName

	if confDetail.toolchain ~= "PATH" then
		local paths = confHost.toolchainPath[confDetail.toolchain]
		if type(confHost.toolchainPath[confDetail.toolchain]) == "string" then
			paths = {confHost.toolchainPath[confDetail.toolchain]}
		end
		hostToolchainVersionQueryPath = paths[1]
		if string.sub(confDetail.toolchain, 1, 4) == "MSVC" then
			hostToolchainVersionQueryFuncName = "msvc"
			ret.msvcBat = paths[1]
			table.remove(paths, 1)
		elseif string.sub(confDetail.toolchain, 1, 9) == "MinGWLLVM" then
			hostToolchainVersionQueryPath = paths[2]
			hostToolchainExecutableName = "clang"
		end
		for _, x in ipairs(paths) do
			table.insert(ret.path, x)
		end
	end

	hostToolchainVersion = compilerVer[hostToolchainVersionQueryFuncName](confHost.makefileTemplate == "win", hostToolchainVersionQueryPath, hostToolchainExecutableName)

	if confDetail.useCMake and confHost.cMakePath then
		for _, p in ipairs(confHost.cMakePath[confDetail.useCMake]) do
			table.insert(ret.path, p)
		end
	end

	ret.envSet = {}
	ret.date = string.format("%04d%02d%02d", BuildTime.year, BuildTime.month, BuildTime.day)

	local repl = {}
	
	if confDetail.crossCompile then
		-- Qt 6: We need host tool to cross build Qt
		if confDetail.hostToolsConf then
			table.insert(ret.download, conf.Qt:hostToolDownloadPath(confHost, job, hostToolchainVersion))
			repl.HOSTQTDIR = ret.WORKSPACE .. confHost.pathSep .. "buildDir" .. confHost.pathSep ..replaceVersion(conf.Qt.configurations[confDetail.hostToolsConf].name, hostToolchainVersion)
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

			if confHost.jdkPath then
				ret.envSet.JAVA_HOME = confHost.jdkPath["8"]
				table.insert(ret.path, confHost.jdkPath["8"] .. confHost.pathSep .. "bin")
			end
		elseif string.sub(confDetail.toolchainT, 1, 10) == "emscripten" then -- WebAssembly
			local matchStr = "^emscripten%-(.+)$"
			local emsdkVer = string.match(confDetail.toolchainT, matchStr)
			if emsdkVer then
				-- Since emsdk doesn't provide a way for downgrade, we have to split each emsdk installation.
				-- Currently all emsdk version we are using can be simply matched using only its version number, so ...
				if confHost.makefileTemplate == "unix" then
					ret.emSource = confHost.emscriptenPath[emsdkVer] .. "/emsdk_env.sh"
				else
					ret.emSource = confHost.emscriptenPath[emsdkVer] .. "emsdk_env.bat"
				end
				
				targetToolchainVersion = compilerVer.emcc(confHost.makefileTemplate == "win", confHost.emscriptenPath[emsdkVer])
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
	else
		targetToolchainVersion = hostToolchainVersion
	end

	if confDetail.opensslConf then
		table.insert(ret.download, conf.OpenSSL:binaryFileDownloadPath(confHost, confDetail.opensslConf, targetToolchainVersion))
		repl.OPENSSLDIR = ret.WORKSPACE .. confHost.pathSep .. "buildDir" .. confHost.pathSep .. replaceVersion(conf.OpenSSL.configurations[confDetail.opensslConf].name, nil, targetToolchainVersion)
		if confDetail.OPENSSL_LIBS then
			local opensslLibs = string.gsub(confDetail.OPENSSL_LIBS, "%&OPENSSLDIR%&", repl.OPENSSLDIR)
			ret.envSet.OPENSSL_LIBS = opensslLibs
		end
	end

	local installFolderName = replaceVersion(confDetail.name, hostToolchainVersion, targetToolchainVersion)
	local installRoot = ret.WORKSPACE .. confHost.pathSep .. "buildDir" .. confHost.pathSep .. installFolderName
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
		if not confDetail.useCMake then
			ret.CONFIGURECOMMANDLINE = "emconfigure " .. ret.CONFIGURECOMMANDLINE
		else
			ret.CONFIGURECOMMANDLINE = "emcmake " .. ret.CONFIGURECOMMANDLINE
		end
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
		-- let CMake call the underlying make tool
		ret.MAKE = "cmake --build . --parallel -- "
	end
	if (string.sub(confDetail.qtVersion, 1, 2) == "6.") and confDetail.crossCompile and (string.sub(confDetail.toolchainT, 1, 10) == "emscripten") then
		ret.MAKE = "emmake " .. ret.MAKE
	end

	-- For whatever reason Python can't be in PATH on Windows.
	-- Python for windows has its executable versionless. We need to prepend its path to the PATH variable.
	if confHost.pythonPath then
		if string.sub(confDetail.qtVersion, 1, 2) == "6." then
			table.insert(ret.path, confHost.pythonPath["3"])
		else
			table.insert(ret.path, confHost.pythonPath["2"])
		end
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

conf.Qt.hostToolDownloadPath = function(self, confHost, job, version)
	local pathWithVersionNotSubstituted = conf.Qt.configurations[job]["hostToolsUrl" .. confHost.makefileTemplate]
	return replaceVersion(pathWithVersionNotSubstituted, version)
end

conf.OpenSSL = {}

conf.OpenSSL.configurations = dofile(scriptPath .. "/lib/opensslCompile/conf.lua")

conf.OpenSSL.generateConfTable = function(self, host, job)
	local confHost = conf.host[conf.hostToConfMap[host]]
	local confDetail = conf.OpenSSL.configurations[job]
	local ret = {}
	ret.template = confHost.makefileTemplate
	ret.path = {}
	ret.WORKSPACE = os.getenv("WORKSPACE")
	-- dirty hack here for Windows drive since Windows services always starts in drive C
	if confHost.makefileTemplate == "win" and string.sub(ret.WORKSPACE, 1, 24) == "C:\\Users\\Fs\\Work\\Jenkins" then
		local rightpart = string.sub(ret.WORKSPACE, 25)
		ret.WORKSPACE = "D:\\Jenkins" .. rightpart
	end
	-- dirty hack end
	ret.download = {}

	-- DO REMEMBER TO USE tostring IF A VERSION STRING IS NEEDED!!
	local hostToolchainVersion, targetToolchainVersion
	local hostToolchainVersionQueryFuncName = "gcc"
	local hostToolchainVersionQueryPath
	local hostToolchainExecutableName = confHost.defaultToolchainExecutableName

	if confDetail.toolchain ~= "PATH" then
		local paths = confHost.toolchainPath[confDetail.toolchain]
		if type(confHost.toolchainPath[confDetail.toolchain]) == "string" then
			paths = {confHost.toolchainPath[confDetail.toolchain]}
		end
		hostToolchainVersionQueryPath = paths[1]
		if string.sub(confDetail.toolchain, 1, 4) == "MSVC" then
			hostToolchainVersionQueryFuncName = "msvc"
			ret.msvcBat = paths[1]
			table.remove(paths, 1)
		elseif string.sub(confDetail.toolchain, 1, 9) == "MinGWLLVM" then
			hostToolchainVersionQueryPath = paths[2]
			hostToolchainExecutableName = "clang"
		end
		for _, x in ipairs(paths) do
			table.insert(ret.path, x)
		end
	end

	hostToolchainVersion = compilerVer[hostToolchainVersionQueryFuncName](confHost.makefileTemplate == "win", hostToolchainVersionQueryPath, hostToolchainExecutableName)

	if confDetail.opensslUnifyType then
		-- This part of script runs only on whatever Unix-like host (CentOS8 / Rocky9 / macOS on my build environment) and no Windows compatibility is made.
		-- no plan for Windows support.

		-- Useful for building a unified package for Android / macOS

		if confDetail.opensslUnifyType == "macOS" then
			-- macOS build uses unified clang
			targetToolchainVersion = hostToolchainVersion
		end

		ret.buildContent = "OpenSSLUnify" .. confDetail.opensslUnifyType
		ret.INSTALLROOT = ret.WORKSPACE .. confHost.pathSep .. "buildDir" .. confHost.pathSep .. replaceVersion(confDetail.name, hostToolchainVersion, targetToolchainVersion)
		ret.INSTALLPATH = replaceVersion(confDetail.name, hostToolchainVersion, targetToolchainVersion)
		ret.OPENSSLDIRFUNCTION = ""

		local repl = {}
		repl.arch = {}

		for arch, unifiedConf in pairs(confDetail.opensslUnifyArch) do
			table.insert(ret.download, conf.OpenSSL:binaryFileDownloadPath(confHost, unifiedConf, targetToolchainVersion))
			ret.OPENSSLDIRFUNCTION = ret.OPENSSLDIRFUNCTION .. "if [ \"x$1\" = \"x" .. arch .. "\" ]; then\n" .. "CURRENTARCHDIR=\"" .. replaceVersion(conf.OpenSSL.configurations[unifiedConf].name, hostToolchainVersion, targetToolchainVersion) .. "\"\nexport CURRENTARCHDIR\nel"
			table.insert(repl.arch, arch)
		end

		ret.ARCHITECTURES = repl.arch[1]
		for i = 2, #repl.arch, 1 do
			ret.ARCHITECTURES = ret.ARCHITECTURES .. " " .. repl.arch[i]
		end

		ret.OPENSSLDIRFUNCTION = ret.OPENSSLDIRFUNCTION .. "se\nreturn 1\nfi"
	else
		ret.buildContent = "OpenSSL"
		ret.BUILDDIR = ret.WORKSPACE .. confHost.pathSep .. "buildDir" .. confHost.pathSep .. "build-OpenSSL" .. job
		ret.INSTALLCOMMANDLINE = " "
		table.insert(ret.download, confDetail["sourcePackageUrl" .. confHost.makefileTemplate])

		ret.envSet = {}

		local repl = {}
		repl.parameter = {}

		if confDetail.crossCompile then
			if string.sub(confDetail.toolchainT, 1, 7) == "Android" then -- Android
				-- Let's use NDK package directly
				local matchStr = "Android%-(%d+)%-(r%d+%a?)%-(.+)"
				local api, ndkVer, archi = string.match(confDetail.toolchainT, matchStr)
				if api then
					ret.envSet.ANDROID_NDK_HOME = confHost.androidNdkPath[ndkVer]
					ret.envSet.ANDROID_NDK_ROOT = confHost.androidNdkPath[ndkVer]
					ret.envSet.CC = "clang"
					table.insert(ret.path, confHost.androidNdkPath[ndkVer] .. confHost.pathSep .. "toolchains" .. confHost.pathSep .. "llvm" .. confHost.pathSep .. "prebuilt" .. confHost.pathSep .. confHost.androidNdkHost .. confHost.pathSep .. "bin")
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
			targetToolchainVersion = hostToolchainVersion
			if string.sub(confDetail.toolchain, 1, 4) == "MSVC" then -- if conf.hostToConfMap[host] == "win" then
				-- nothing special
			elseif string.sub(confDetail.toolchain, 1, 5) == "MinGW" then -- elseif conf.hostToConfMap[host] == "msys" then
				-- Clang-llvm need clang be called with target triplet and should be set to environment variable CC
				if confDetail.clangTriplet then
					ret.envSet.CC = "clang --target=" .. confDetail.clangTriplet
				end
			elseif string.sub(conf.hostToConfMap[host], 1, 3) == "mac" then
				-- OpenSSL build for macOS is not used when building Qt 5. SecureTransport is used instead.
				-- Since build of Qt 4 has been defuncted, this may also be defuncted,,,,, right?
				-- No! OpenSSL is revived in Qt 6! Seems Strange? It's because that SecureTransport has been deprecated by Apple and won't support TLS 1.3!
				-- Qt since 6.2 supports multiple SSL backend as Qt plugin. So we are building 2 different backends for macOS - SecureTransport and OpenSSL.

				-- nothing special
			else
				error("not supported")
			end
		end

		local installFolderName = replaceVersion(confDetail.name, nil, targetToolchainVersion)
		local installRoot = ret.WORKSPACE .. confHost.pathSep .. "buildDir" .. confHost.pathSep .. installFolderName

		repl.INSTALLROOT = installRoot

		local configureArgs = ""
		for _, p in ipairs(repl.parameter) do
			configureArgs = configureArgs .. " " .. p
		end

		-- Yeah. './config' totally sucks. It is of no use even during host build.
		ret.CONFIGURECOMMANDLINE = "perl ../" .. confDetail.sourcePackageBaseName .. "/Configure "
		ret.CONFIGURECOMMANDLINE = ret.CONFIGURECOMMANDLINE .. string.gsub(string.gsub(confDetail.configureParameter, "%&([%w_]+)%&", function(s)
			if repl[s] then
				return repl[s]
			else
				return ""
			end
		end), "%s+", " ")
		
		if confDetail.crossCompile then
			ret.INSTALLCOMMANDLINE = ret.INSTALLCOMMANDLINE .. " DESTDIR=" .. installRoot .. " "
		end

		if confHost.makefileTemplate == "unix" then
			-- OpenSSL on MinGW is built using MSYS2, so only runs on Unix environment
			-- See https://github.com/openssl/openssl/issues/6111 for MinGW without MSYS2 discussion
			ret.MAKE = "make -j$PARALLELNUM"
			ret.INSTALLCOMMANDLINE = ret.MAKE .. " install_sw install_ssldirs " .. ret.INSTALLCOMMANDLINE
		elseif string.sub(confDetail.toolchain, 1, 4) == "MSVC" then
			-- MSVC version of Makefile supports only nmake, jom is neither supported nor tested offically.
			-- On https://github.com/openssl/openssl/issues/10902 CMake is suggested to be the official supported build tool but got rejected.
			-- OpenSSL maintainers said that cmake can't cover their supported platforms, so they use a custom build system. e.g. they need to support OpenVMS where CMake can't be run.

			-- currently adding "/FS" to the compiler command line, but it fails randomly.
			-- Retry is added when build fails, for 3 times.
			ret.MAKE = "jom"

			-- however, install process of OpenSSL 3 breaks with jom and will make jom stucks. So fallback to nmake to pass build
			ret.INSTALLCOMMANDLINE = "nmake install_sw install_ssldirs " .. ret.INSTALLCOMMANDLINE
		else
			error("not supported")
		end

		ret.INSTALLROOT = installRoot
		ret.INSTALLPATH = installFolderName
	end
	return ret
end

conf.OpenSSL.binaryFileDownloadPath = function(self, confHost, job, version)
	local pathWithVersionNotSubstituted = conf.OpenSSL.configurations[job]["binaryPackageUrl" .. confHost.makefileTemplate]
	return replaceVersion(pathWithVersionNotSubstituted, nil, version)
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
	["Win10SH"] = "msys",
	["Win8"] = "win",
	["Win8SH"] = "msys",
	["CentOS8"] = "linux",
	["Rocky9"] = "linux",
	["macOS1015"] = "mac",
	["macOSLegacy"] = "macLegacy",
	["macOSM1"] = "mac",
}

return conf
