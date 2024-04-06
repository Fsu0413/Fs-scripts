local parseConfTable = {}

parseConfTable.fileName = function(buildInfo)
	return buildInfo.INSTALLPATH .. "-" .. tostring(buildInfo.date) .. ((buildInfo.template == "win") and ".7z" or ".tar.xz")
end

parseConfTable.dataDotVersion = function(buildInfo)
	return buildInfo.buildContentVersion
end

parseConfTable.dataDotPlatform = function(buildInfo)
	return buildInfo.buildTarget
end

parseConfTable.dataDotBuildHost = function(buildInfo)
	return buildInfo.buildHostVersion
end

parseConfTable.dataDotToolchain = function(buildInfo)
	if buildInfo.buildTargetToolchain == "PATH" then
		if string.sub(buildInfo.buildHost, 1, 5) == "macOS" then
			return "AppleClang " .. tostring(buildInfo.buildTargetToolchainVersion)
		else
			return "GCC " .. tostring(buildInfo.buildTargetToolchainVersion)
		end
	elseif string.sub(buildInfo.buildTargetToolchain, 1, 7) == "Android" then
		return "ndk " .. tostring(buildInfo.buildTargetToolchainVersion)
	elseif string.sub(buildInfo.buildTargetToolchain, 1, 5) == "MinGW" then
		local compilerId, compilerSuffix
		if string.sub(buildInfo.buildTargetToolchain, 1, 9) == "MinGWLLVM" then
			compilerId = "LLVM"
			if string.sub(buildInfo.buildTargetToolchain, 11, 4) == "ucrt" then
				compilerSuffix = " UCRT"
			else
				compilerSuffix = " MSVCRT"
			end
		else
			compilerId = "GCC"
			if string.sub(buildInfo.buildTargetToolchain, 9, 1) == "u" then
				compilerSuffix = " UCRT"
			elseif (string.sub(buildInfo.buildTargetToolchain, 9, 1) == "0") and (not (string.sub(buildInfo.buildTargetToolchain, 6, 4) == "1120")) then
				compilerSuffix = " MSVCRT"
			end
		end

		return "MinGW-w64 w/ " .. compilerId .. " " .. buildInfo.buildTargetToolchainVersion .. (compilerSuffix or "")
	elseif string.sub(buildInfo.buildTargetToolchain, 1, 4) == "MSVC" then
		if string.sub(buildInfo.buildTargetToolchain, 5, 4) == "2015" then
			return "VS2015 Update 3"
		elseif string.sub(buildInfo.buildTargetToolchain, 5, 4) == "2017" then
			return "VS2017 " .. buildInfo.buildTargetToolchainVersion
		elseif string.sub(buildInfo.buildTargetToolchain, 5, 4) == "2019" then
			return "VS2019 " .. buildInfo.buildTargetToolchainVersion
		elseif string.sub(buildInfo.buildTargetToolchain, 5, 4) == "2022" then
			return "VS2022 " .. buildInfo.buildTargetToolchainVersion
		end
	elseif string.sub(buildInfo.buildTargetToolchain, 1, 10) == "emscripten" then
		return "emscripten-" .. buildInfo.buildTargetToolchainVersion
	end

	return buildInfo.buildTargetToolchainVersion
end

parseConfTable.dataDotArch = function(buildInfo)
	return buildInfo.buildTargetArch
end

parseConfTable.dataDotVariant = function(buildInfo)
	return buildInfo.buildTargetVariant
end

return parseConfTable
