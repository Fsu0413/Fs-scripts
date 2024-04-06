
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

parseConfTable = reuqire("ParseConfTable")
compare = require("Compare")
download = require("Download")

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

--[====[
-- unusable for now, need refactor.
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
]====]
