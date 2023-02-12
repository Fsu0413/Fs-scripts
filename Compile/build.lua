
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

local conf = require("Configuration")
local gen = require("Generate")

local buildJob = os.getenv("JOB_BASE_NAME")
local buildHost = os.getenv("NODE_NAME")

BuildTime = os.date("*t")

local main = function(argc, argv)
	local buildContent = conf:buildContent(buildJob)

	local confTable, optionalQQtPatcherTable = conf[buildContent]:generateConfTable(buildHost, buildJob)

	-- QQtPatcher will be discontinued on 2023.9.11, the time when OpenSSL 1.1 series goes EOL
	-- Related code can be deleted after that time, when I'll give the QQtPatcher a 1.0.0 version number
	if optionalQQtPatcherTable then
		confTable.EXTRAINSTALL = gen:generate(optionalQQtPatcherTable) .. confTable.EXTRAINSTALL
	end

	local generatedBuildScript = gen:generate(confTable)

	local outputFile = io.open("buildCommands.cmd", "w+")
	if outputFile then
		outputFile:write(generatedBuildScript)
		outputFile:close()
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
