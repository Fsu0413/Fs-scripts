
-- TODO: find a more sensible name for this module.
-- The version is not for a specific compiler, but rather a version number of a whole toolchain.

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
	else
		io.stderr:write("[CompilerVer.lua][runCmdScript] Following script fails to run:\n" .. script .. "\n")
	end
	
	os.remove(fileName .. ".cmd")
	os.remove(fileName2)
	
	return ret
end

compilerVer.parseVersionNum = function(str)
	local match = { string.match(str, "(%d+)%.(%d+)%.(%d+)") }
	if #match > 0 then
		return setmetatable(match, { __tostring = function(m) return m[1] .. "." .. m[2] .. "." .. m[3] end})
	end
	return fail
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
	else
		io.stderr:write("[CompilerVer.lua][runShScript] Following script fails to run:\n" .. script .. "\n")
	end
	
	os.remove(fileName)
	os.remove(fileName2)
	
	return ret
end

compilerVer.msvc = function(isWin, envBat)
	local shellScript = "@call \"" .. envBat .. "\" > NUL\r\n@echo %VSCMD_VER%\r\n"
	local ret = runCmdScript(shellScript)
	return compilerVer.parseVersionNum(ret)
end

local gccCommon = function(isWin, executableName)
	local script = ""

	executableName = executableName or "gcc"
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
	
	return compilerVer.parseVersionNum(ret)
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
	
	if not ret then
		-- workaround: emsdk 1.39.8 don't set path of python
		io.stderr:write("[CompilerVer.lua][compilerVer.emcc] workaround emsdk version\n")
		ret = "1.39.8"
	end

	return compilerVer.parseVersionNum(ret)
end

--[==[
-- unused function. NDK version is still provided by Configuration.
compilerVer.ndk = function(_, path)
	-- NDK r13+ have a file named "source.properties" in its path.
	-- In this file there is an item calls "Pkg.Revision" which indicates the version of NDK itself.

	local file, err = io.open(path .. "/source.properties", "r")

	if not file then
		return fail
	end

	local major, minor

	for line in file:lines() do
		major, minor = string.match(line, "^Pkg%.Revision = (%d+)%.(%d+)%.%d+$")
		if major then
			break
		end
	end

	file:close()

	if not major then
		return fail
	end

	local ndkMinorRevisionTable = {
		"",
		"b",
		"c",
		"d",
		"e",
		"f", -- no NDK versions ever reached this far, so..
		"g",
	}

	return major .. ndkMinorRevisionTable[tonumber(minor) + 1]
end
]==]

return compilerVer
