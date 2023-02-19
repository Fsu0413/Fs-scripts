
local scriptFile = arg[0]
local n, n2
repeat
	n = n2
	n2 = string.find(scriptFile, "/", n and (n + 1) or 1)
	if n2 == nil then
		n2 = string.find(scriptFile, "\\", n and (n + 1) or 1)
	end
until n2 == nil

scriptPath = (n and string.sub(scriptFile, 1, n - 1) or ".")

package.path = scriptPath .. "/lib/?.lua;" .. package.path

local fileName = function(confTable)
	return confTable.INSTALLPATH .. "-" .. tostring(confTable.date) .. ((confTable.template == "win") and ".7z" or ".tar.xz")
end

local dataDotVersion = function(confTable)
	return confTable.buildContentVersion
end

local dataDotBuildHost = function(confTable)
	local buildHostNameTable = {
		Win10 = "Windows 11 10.0.22621",
		Win10SH = "Windows 11 10.0.22621",
		Win8 = "Windows 8.1 Update",
		Win8SH = "Windows 8.1 Update",
		CentOS8 = "RockyLinux 8.7",
		Rocky9 = "RockyLinux 9.1",
		macOS1015 = "macOS 12.6.3",
		macOSLegacy = "macOS 11.7.2",
		macOSM1 = "macOS 12.6.3",
	}

	return buildHostNameTable[confTable.buildHost]
end

local dataDotToolchain = function(confTable)
	-- only Target counts?

	if confTable.buildTargetToolchain == "PATH" then
		if string.sub(confTable.buildHost, 1, 5) == "macOS" then
			return "AppleClang " .. tostring(confTable.buildTargetToolchainVersion)
		else
			return "GCC " .. tostring(confTable.buildTargetToolchainVersion)
		end
	elseif string.sub(confTable.buildTargetToolchain, 1, 7) == "Android" then
		return "ndk " .. tostring(confTable.buildTargetToolchainVersion)
	elseif string.sub(confTable.buildTargetToolchain, 1, 5) == "MinGW" then
		-- TODO: need generator compile a program for get mingw-w64 version.
		-- Let's just hard-code it here
		local MinGWVersion = 0
		local compilerId, compilerSuffix = "GCC", ""
		if string.sub(confTable.buildTargetToolchain, 1, 9) == "MinGWLLVM" then
			MinGWVersion = 10
			compilerId = "LLVM"
			if string.sub(confTable.buildTargetToolchain, 11, 4) == "ucrt" then
				compilerSuffix = " (ucrt)"
			else
				compilerSuffix = " (msvcrt)"
			end
		elseif string.sub(confTable.buildTargetToolchainVersion, 1, 3) == "12." then
			MinGWVersion = 10
		elseif string.sub(confTable.buildTargetToolchainVersion, 1, 3) == "11." then
			MinGWVersion = 9
		elseif string.sub(confTable.buildTargetToolchainVersion, 1, 2) == "8." then
			MinGWVersion = 6
		elseif string.sub(confTable.buildTargetToolchainVersion, 1, 2) == "7." then
			MinGWVersion = 5
		elseif string.sub(confTable.buildTargetToolchainVersion, 1, 4) == "4.9." then
			MinGWVersion = 5
		end

		return "MinGW-w64 v" .. tostring(MinGWVersion) .. " w/ " .. compilerId .. " " .. confTable.buildTargetToolchainVersion .. compilerSuffix
	elseif string.sub(confTable.buildTargetToolchain, 1, 4) == "MSVC" then
		if string.sub(confTable.buildTargetToolchain, 5, 4) == "2015" then
			return "VS2015 Update 3"
		elseif string.sub(confTable.buildTargetToolchain, 5, 4) == "2017" then
			return "VS2017 " .. confTable.buildTargetToolchainVersion .. "w/ Windows SDK 10.0.17763"
		elseif string.sub(confTable.buildTargetToolchain, 5, 4) == "2019" then
			return "VS2019 " .. confTable.buildTargetToolchainVersion .. "w/ Windows SDK 10.0.22000"
		elseif string.sub(confTable.buildTargetToolchain, 5, 4) == "2022" then
			return "VS2022 " .. confTable.buildTargetToolchainVersion .. "w/ Windows SDK 10.0.22621"
		end
	elseif string.sub(confTable.buildTargetToolchain, 1, 10) == "emscripten" then
		return confTable.buildTargetToolchain
	end

	return confTable.buildTargetToolchainVersion
end

local buildContent = function(buildJob)
	if string.sub(buildJob, 1, 1) == "q" then
		return "Qt"
	elseif (string.sub(buildJob, 1, 1) == 'o') then
		return "OpenSSL"
	elseif (string.sub(buildJob, 1, 1) == 'm') then
		return "MariaDB"
	else
		error(buildJob .. " is not supported.")
	end
end

local main = function(argc, argv)
	local dl = require("Download")
	local buildJob = os.getenv("UPDATE_JOB")
	local xContent = buildContent(buildJob)
	local buildInfoUrl = "http://172.24.13.6:8080/job/" .. xContent .. "/job/" .. name .. "/lastSuccessfulBuild/artifact/buildDir/buildInfo.lua"

	if not dl:download(buildInfoUrl) then return 1 end

	local confTable = dofile("buildInfo.lua")

	local modifyData = {
		JOB = buildJob,
		BUILDCONTENT = xContent,
		VERSION = dataDotVersion(confTable),
		BUILDHOST = dataDotBuildHost(confTable),
		TOOLCHAIN = dataDotToolchain(confTable),
		SUFFIX = (confTable.isPreview and "Preview" or ""),
	}

	local template

	if string.sub(xContent, 1, 12) == "OpenSSLUnify" then
		template = "exit 0" -- do nothing intentionally
	elseif xContent == "Qt" then
		template = [[
			mv ../QtCompile/Fsu0413&BUILDCONTENT&Builds&SUFFIX&.json ./temp.json
			jq '
				.&JOB&.fileName = "&FILENAME&" |
				.&JOB&.data.version = "&VERSION&" |
				.&JOB&.data.buildHost = "&BUILDHOST&" |
				.&JOB&.data.toolchain = "&TOOLCHAIN&"
			' < ./temp.json > ../QtCompile/Fsu0413&BUILDCONTENT&Builds&SUFFIX&.json
		]]
		modifyData.FILENAME = fileName(confTable)
	else
		template = [[
			mv ../QtCompile/Fsu0413&BUILDCONTENT&Builds&SUFFIX&.json ./temp.json
			jq '
				.&JOB&.data.version = "&VERSION&" |
				.&JOB&.data.buildHost = "&BUILDHOST&" |
				.&JOB&.data.toolchain = "&TOOLCHAIN&"
			' < ./temp.json > ../QtCompile/Fsu0413&BUILDCONTENT&Builds&SUFFIX&.json
		]]
	end

	local ret = string.gsub(template, "%&([%w_]+)%&", function(s)
		if modifyData[s] then
			return modifyData[s]
		else
			return ""
		end
	end)

	local modifyDataFile = io.open("dataCommand.cmd", "w+")
	if modifyDataFile then
		modifyDataFile:write(ret)
		modifyDataFile:close()
	else
		return 1
	end

	return 0
end

local exceptionHandler = function(err)
	io.stderr:write(tostring(err) .. "\n")
	io.stderr:write(debug.traceback())
	os.exit(1)
end

local r, re = xpcall(main, exceptionHandler, #arg + 1, arg)

if r then
	os.exit(re)
else
	os.exit(1)
end
