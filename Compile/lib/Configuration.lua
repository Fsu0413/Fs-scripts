local conf = {}

conf.host = {}

conf.host.win = {
	-- Preinstalled jom(need to set path manually)
	-- Preinstalled MSVC(need to set path manually)
	-- Preinstalled MinGW-w64 toolchain(need to set path manually)
	-- Preinstalled Android-NDK/SDK toolchain(no need to set path, path is managed in Qt Makefiles)
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
		["r21b"] = "D:\\android-ndk-r21b",
		["r21d"] = "D:\\android-ndk-r21d",
	},
	["emscriptenPath"] = "D:\\emsdk\\",
	["cMakePath"] = { "D:\\cmake-3.19.1-win64-x64\\bin", "D:\\ninja" },
}

-- msys is treated as another host since it uses windows agent and unix shell
-- used in compiling OpenSSL
conf.host.msys = {
	-- Preinstalled Android-NDK toolchain(no need to set path, path is set in openssl_compile_android.sh)
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
		["r21b"] = "/d/android-ndk-r21b/",
		["r21d"] = "/d/android-ndk-r21d/",
	},
}

conf.host.linux = {
	-- Preinstalled OpenSSL(using software source)
	-- Preinstalled GNU make in path and is used
	-- Preinstalled Android-NDK/SDK toolchain(no need to set path, path is managed in Qt Makefiles/openssl_compile_android.sh)
	-- Preinstalled host toolchain in path and is used
	-- Preinstalled p7zip in path and is used
	["makefileTemplate"] = "unix",
	["pathSep"] = '/',
	["androidSdkPath"] = {
		["Latest"] = "/opt/env/android-sdk-linux/",
	},
	["androidNdkPath"] = {
		["r21b"] = "/opt/env/android-ndk-r21b/",
		["r21d"] = "/opt/env/android-ndk-r21d/",
	},
	["sourcePackagePath"] = "/opt/sources/",
	["buildRootPath"] = "/opt/build/",
	["emscriptenPath"] = "/opt/env/emsdk/",
}

conf.host.mac = {
	-- Preinstalled GNU make in path and is used
	-- Preinstalled Android-NDK/SDK toolchain(no need to set path, path is managed in Qt Makefiles/openssl_compile_android.sh)
	-- Preinstalled host toolchain in path and is used
	-- Preinstalled p7zip in path and is used
	["makefileTemplate"] = "unix",
	["pathSep"] = '/',
	["androidSdkPath"] = {
		["Latest"] = "/opt/env/android-sdk-mac-2/",
	},
	["androidNdkPath"] = {
		["r21b"] = "/opt/env/android-ndk-r21b/",
		["r21d"] = "/opt/env/android-ndk-r21d/",
	},
	["sourcePackagePath"] = "/opt/sources/",
	["buildRootPath"] = "/opt/build/",
	["emscriptenPath"] = "/opt/env/emsdk/",
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
	ret.BUILDDIR = confHost.buildRootPath .. "build-Qt" .. job
	local download = {}

	if confDetail.toolchain ~= "PATH" then
		if string.sub(confDetail.toolchain, 1, 4) == "MSVC" then
			ret.msvcBat = confHost.toolchainPath[confDetail.toolchain]
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
	local installRoot = os.getenv("WORKSPACE") .. confHost.pathSep .. "buildDir" .. confHost.pathSep .. installFolderName

	if confDetail.opensslConf then
		table.insert(download, conf.OpenSSL:binaryFileDownloadPath(host, confDetail.opensslConf))
		repl.OPENSSLDIR = os.getenv("WORKSPACE") .. confHost.pathSep .. "buildDir" .. confHost.pathSep .. conf.OpenSSL.configurations[confDetail.opensslConf].name
		if confHost.makefileTemplate == "win" then
			repl.OPENSSLDIR_DOUBLESLASH = string.gsub(repl.OPENSSLDIR, "%\\", "\\\\")
			repl.OPENSSLDIR_FRONTSLASH = string.gsub(repl.OPENSSLDIR, "%\\", "/")
		end
		if confDetail.OPENSSL_LIBS then
			local opensslLibs = string.gsub(confDetail.OPENSSL_LIBS, "%&OPENSSLDIR%&", repl.OPENSSLDIR)
			ret.envSet.OPENSSL_LIBS = opensslLibs
		end
	end

	if confDetail.crossCompile then
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
	else
		repl.INSTALLROOT = installRoot
	end

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
		if confDetail.cMakeTwice then
			ret.reconfigure = "cmake ."
		end
	end

	if not confDetail.useCMake then
		if confHost.makefileTemplate == "unix" then
			ret.MAKE = "make -j10"
		elseif string.sub(confDetail.toolchain, 1, 5) == "MinGW" then
			ret.MAKE = "mingw32-make -j10"
		elseif string.sub(confDetail.toolchain, 1, 4) == "MSVC" then
			ret.MAKE = "jom"
		else
			error("not supported")
		end
	else
		-- TODO: support ninja in CMake builds? or let CMake call the underlayer make tool?
		ret.MAKE = "cmake --build . --parallel -- "
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
		ret.INSTALLCOMMANDLINE = "cmake --install . "
	end

	ret.INSTALLROOT = installRoot
	ret.INSTALLPATH = installFolderName

	ret.EXTRAINSTALL = ""

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
			table.insert(download, confDetail["qQtPatcherSourceUrl" .. confHost.makefileTemplate])
		else
			table.insert(download, confDetail["qQtPatcherUrl" .. confHost.makefileTemplate])
		end
		ret.EXTRAINSTALL = ret.EXTRAINSTALL .. copyCmd .. "QQtPatcher" .. (((confHost.makefileTemplate == "unix") and (conf.hostToConfMap[host] ~= "msys")) and "" or ".exe") .. " " .. installRoot .. "\n"

		if (confHost.makefileTemplate == "unix") and (conf.hostToConfMap[host] ~= "msys") then
			ret.EXTRAINSTALL = ret.EXTRAINSTALL .. "chmod +x " .. installRoot .. "/QQtPatcher\n"
		end
	end

	return download, ret, qQtPatcherTable
end

conf.OpenSSL = {}

conf.OpenSSL.configurations = dofile(scriptPath .. "/lib/opensslCompile/conf.lua")

conf.OpenSSL.generateConfTable = function(self, host, job)
	local confHost = conf.host[conf.hostToConfMap[host]]
	local confDetail = conf.OpenSSL.configurations[job]

	local ret = {}
	ret.buildContent = "OpenSSL"
	ret.template = confHost.makefileTemplate
	ret.path = {}
	local download = {}
	table.insert(download, confDetail["sourcePackageUrl" .. confHost.makefileTemplate])

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

	if confDetail.crossCompile then
		if string.sub(confDetail.toolchainT, 1, 7) == "Android" then -- Android
			repl.commandLine = scriptPath .. "/../openssl_compile_android.sh"
			local matchStr = "Android%-(%d+)%-(r%d+%a?)%-(.+)"
			local api, ndkVer, archi = string.match(confDetail.toolchainT, matchStr)
			if api then
				repl.parameter = {
					archi,
					confHost.androidNdkPath[ndkVer],
					api,
					(confDetail.useClang and "true" or "false"),
				}
			else
				error("confDetail.toolchainT is not matched")
			end
		elseif string.sub(confDetail.toolchainT, 1, 10) == "emscripten" then -- WebAssembly
			error("todo....")
		elseif string.sub(confDetail.toolchainT, 1, 4) == "MSVC" then -- Windows UWP/ARM64 Desktop
			-- First, deal with ret.msvcBat
			ret.msvcBat = confHost.toolchainPath[confDetail.toolchainT]
			-- ... then copy what host build of MSVC does.
			for _, i in ipairs(confDetail.variant) do
				table.insert(repl.parameter, i)
			end
			repl.commandLine = "cscript " .. scriptPath .. "/../openssl_compile_MSVC.vbs"
		elseif string.sub(confDetail.toolchainT, 1, 11) == "GCCForLinux" then -- GNU/Linux cross builds(Todo)
			error("todo....")
		elseif string.sub(confDetail.toolchainT, 1, 5) == "MinGW" then -- MinGW cross builds(Todo)
			error("todo....")
		else
			error("not supported")
		end
	else
		if string.sub(confDetail.toolchain, 1, 4) == "MSVC" then -- if conf.hostToConfMap[host] == "win" then
			for _, i in ipairs(confDetail.variant) do
				table.insert(repl.parameter, i)
			end
			repl.commandLine = "cscript " .. scriptPath .. "/../openssl_compile_MSVC.vbs"
		elseif string.sub(confDetail.toolchain, 1, 5) == "MinGW" then -- elseif conf.hostToConfMap[host] == "msys" then
			-- no parameter needed
			repl.commandLine = scriptPath .. "/../openssl_compile_MinGW.sh"
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

	ret.CONFIGURECOMMANDLINE = repl.commandLine .. " " .. confDetail.sourcePackageBaseName .. " " .. string.gsub(configureArgs, "%s+", " ")
	ret.INSTALLPATH = confDetail.name

	return download, ret
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
	["macOS1014"] = "mac",
	["macOS1015"] = "mac",
}

return conf

