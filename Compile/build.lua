
if string.sub(_VERSION, -3) ~= "5.4" then
	fail = nil
end

local scriptFile = arg[0]
local n, n2
repeat
	n = n2
	n2 = string.find(scriptFile, "/", n and (n + 1) or 1)
	if not n2 then
		n2 = string.find(scriptFile, "\\", n and (n + 1) or 1)
	end
until not n2

scriptPath = (n and string.sub(scriptFile, 1, n - 1) or ".")

package.path = scriptPath .. "/lib/?.lua;" .. package.path

local main = function(argc, argv)
	local conf = require("Configuration")
	local gen = require("Generate")

	local buildJob = os.getenv("JOB_BASE_NAME")
	local buildHost = os.getenv("NODE_NAME")
	local buildTime = os.date("*t")
	local buildContent = conf:buildContent(buildJob)

	local confTable = conf[buildContent]:generateConfTable(buildHost, buildJob, buildTime)

	for k,v in pairs(confTable) do
		print(k,tostring(v))
	end
	-- for Building - Generate the build scripts and save to buildCommands.cmd
	-- Consequent process run the buildCommands.cmd with proper script interpreter
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
