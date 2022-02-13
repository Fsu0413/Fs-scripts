
local compilerVer = {}

local runCmdScript = function(script)
	local fileName = os.tmpname()
	local fileName2 = os.tmpname()
	local file = io.open(fileName .. ".cmd", "w+")
	file:write(script)
	file:close()
	
	local result, reason, progRet = os.execute("cmd /c \"" .. fileName .. "\" > " .. fileName2)
	
	local ret
	if result and (reason == "exit") and (progRet == 0) then
		local resFile = io.open(fileName2, "r")
		ret = resFile:read()
		resFile:close()
	end
	
	os.remove(fileName .. ".cmd")
	os.remove(fileName2)
	
	return ret
end

local parseVersionNum = function(str)
	local major, minor, patch
	string.gsub(str, "(%d+)%.(%d+)%.(%d+)", function(...) major, minor, patch = ...  end )
	return major, minor, patch
end

local runShScript = function(script)
	local fileName = os.tmpname()
	local fileName2 = os.tmpname()
	local file = io.open(fileName, "w+")
	file:write(script)
	file:close()
	
	local result, reason, progRet = os.execute("sh \"" .. fileName .. "\" > " .. fileName2)
	local ret
	if result and (reason == "exit") and (progRet == 0) then
		local resFile = io.open(fileName2, "r")
		ret = resFile:read()
		resFile:close()
	end
	
	os.remove(fileName)
	os.remove(fileName2)
	
	return ret
end

compilerVer.msvc = function(envBat)
	local shellScript = "@call \"" .. envBat .. "\" > NUL\r\n@echo %VSCMD_VER%\r\n"
	local ret = runCmdScript(shellScript)
	return parseVersionNum(ret)
end

local gccCommon = function(isWin, executableName)
	local script = ""

	if not executableName then
		executableName = "gcc"
	end
	
	script = script .. executableName .. " -dumpfullversion -dumpversion"
	if isWin then
		script = script .. "\r\n"
	else
		script = script .. "\n"
	end

	return script
end

compilerVer.gcc = function(isWin, path, executableName)
	local script = ""
	if path then
		if isWin then
			script = "@set path=" .. path .. ";%path%\r\n@"
		else
			script = "PATH=\"" .. path .. ":$PATH\"; export PATH\n"
		end
	end
	
	script = script .. gccCommon(isWin, executableName)

	local ret
	if isWin then
		ret = runCmdScript(script)
	else
		ret = runShScript(script)
	end
	
	return parseVersionNum(ret)
end

compilerVer.appleClang = function()
	local ret = runShScript(gccCommon(nil, "clang"))
	return parseVersionNum(ret)
end

compilerVer.emcc = function(isWin, path)
	local script = ""
	if path then
		if isWin then
			script = "@call " .. path .. "\\emsdk_env.bat > NUL 2> NUL\r\n@"
		else
			script = ". " .. path .. "/emsdk_env.sh > /dev/null 2> /dev/null\n"
		end
	end
	
	script = script .. gccCommon(isWin, "emcc")

	local ret
	if isWin then
		ret = runCmdScript(script)
	else
		ret = runShScript(script)
	end

	return parseVersionNum(ret)
end

return compilerVer
