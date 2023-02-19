
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

local main = function(argc, argv)
	local conf = require("Configuration")
	local gen = require("Generate")

	local buildJob = os.getenv("JOB_BASE_NAME")
	local buildHost = os.getenv("NODE_NAME")
	local buildTime = os.date("*t")
	local buildContent = conf:buildContent(buildJob)

	local confTable, optionalQQtPatcherTable = conf[buildContent]:generateConfTable(buildHost, buildJob, buildTime)

	for k,v in pairs(confTable) do
		print(k,tostring(v))
	end
	-- QQtPatcher will be discontinued on 2023.9.11, the time when OpenSSL 1.1 series goes EOL
	-- Related code can be deleted after that time, when I'll give the QQtPatcher a 1.0.0 version number

	-- for Building - Generate the build scripts and save to buildCommands.cmd
	-- Consequent process run the buildCommands.cmd with proper script interpreter
	if optionalQQtPatcherTable then
		confTable.EXTRAINSTALL = gen:generateBuildCommand(optionalQQtPatcherTable) .. confTable.EXTRAINSTALL
	end

	local generatedBuildScript = gen:generateBuildCommand(confTable)

	local buildScriptFile = io.open("buildCommands.cmd", "w+")
	if buildScriptFile then
		buildScriptFile:write(generatedBuildScript)
		buildScriptFile:close()
	else
		return 1
	end

	-- for generating the build data - Generate the build info file for easy read using Lua
	-- This lua will be downloaded by UpdateWebsite and read by it
	local generatedBuildInfo = gen:generateBuildInfo(confTable)

	local buildInfoFile = io.open("buildInfo.lua", "w+")
	if buildInfoFile then
		buildInfoFile:write(generatedBuildInfo)
		buildInfoFile:close()
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
