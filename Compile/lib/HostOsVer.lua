
local hostOsVer = {}

local winCommon = function(...)
	local file, err = ...

	if not file then return fail, err end

	-- the version string is in the second line
	file:read()
	local line = file:read()
	file:close()

	-- currently we are using only Windows 10+
	local major, minor, patch
	string.gsub(line, "%[[^%d]+(%d+)%.(%d+)%.(%d+)[^%]]*%]", function(...)
		major, minor, patch = ...
	end)

	if not major then return fail, "pattern didn't match line " .. line end

	local prefix

	if tonumber(major) < 5 then
		-- Windows 9x / ME / NT4.0 / pre-3.2, not supported
	elseif tonumber(major) == 5 then
		if tonumber(minor) == 0 then
			prefix = "Windows 2000"
		elseif tonumber(minor) == 1 or tonumber(minor) == 2 then
			prefix = "Windows XP"
		end
	elseif tonumber(major) == 6 then
		if tonumber(minor) == 0 then
			prefix = "Windows Vista"
		elseif tonumber(minor) == 1 then
			prefix = "Windows 7"
		elseif tonumber(minor) == 2 then
			prefix = "Windows 8"
		elseif tonumber(minor) == 3 then
			prefix = "Windows 8.1"
		elseif tonumber(minor) == 4 then
			prefix = "Windows 10"
		end
	elseif tonumber(major) == 10 then
		if tonumber(minor) == 0 then
			-- first Windows 11 is build 10.0.22000.1
			if tonumber(patch) < 22000 then
				prefix = "Windows 10"
			else
				prefix = "Windows 11"
			end
		end
	end

	if not prefix then
		return fail, "Windows version not supported " .. major .. "." .. minor .. "." .. patch
	end

	-- Currently not presented so comment out
	--[==[
	-- known Windows pre-7 Service Packs / Windows 10~11 codename
	local codename = {
		["6001"]  = "Service Pack 1", -- Windows Vista
		["7601"]  = "Service Pack 1", -- Windows 7

		["10240"] = "1507",
		["10586"] = "1511",
		["14393"] = "1607", -- or Windows Server 2016
		["15063"] = "1703",
		["16299"] = "1709",
		["17134"] = "1803",
		["17763"] = "1809", -- or Windows Server 2019
		["18362"] = "1903",
		["18363"] = "1909",
		["19041"] = "2004",
		["19042"] = "20H2",
		["19043"] = "21H1",
		["19044"] = "21H2",
		["19045"] = "22H2", -- final version of Windows 10

		["20348"] = "21H2", -- Windows Server 2022 only
		["20349"] = "22H2", -- Does this really exist?

		["22000"] = "21H2", -- first version of Windows 11
		["22621"] = "22H2",
		["22631"] = "23H2",

		["25398"] = "23H2", -- What is this... Windows Server 23H2
	}

	if codename[patch] then
		prefix = prefix .. " " .. codename[patch]
	end
	]==]

	return prefix .. " " .. major .. "." .. minor .. "." .. patch
end

hostOsVer.win = function()
	-- Just "cmd /c ver" won't work under MSYS2 since MSYS2 replaces "/c" to "C:/"
	-- "ver" is Windows cmd builtin (What the hell!?) and there is no "ver.exe" at all in Windows
	-- but if "ver" or "ver.exe" is run under cmd it works magically
	return winCommon(io.popen("cmd /c ver" , "r"))
end

hostOsVer.winArm = hostOsVer.win

hostOsVer.msys = function()
	-- Workaround is setting environment variable MSYS2_ARG_CONV_EXCL before cmd is run
	return winCommon(io.popen("MSYS2_ARG_CONV_EXCL='*' cmd /c ver" , "r"))
end

hostOsVer.linux = function()
	-- /etc/os-release is suggested by the systemd guys, and is becoming the de facto standard for checking the Linux distro information.
	-- Since currently only Rocky Linux is in my build environment and it is already using systemd, /etc/os-release must be provided.
	-- Other OSes like FreeBSD is also using this file. (but macOS is not using it!)

	-- There is a blog of this file - https://0pointer.de/blog/projects/os-release
	-- The documentation of this file is - https://www.freedesktop.org/software/systemd/man/latest/os-release.html
	local file
	for _, fileName in ipairs({
		"/etc/os-release",
		"/usr/lib/os-release"
	}) do
		local err
		file, err = io.open(fileName, "r")
		if file then break end
	end

	if not file then return fail, "/etc/os-release series of file are not readable" end

	-- It is mainly for easily parsed by shell scripts, but I'm parsing this file using Lua....
	-- So, let's use pattern for parsing it
	local osRelease = {}

	for l in file:lines() do
		-- Each line have NAME_KEY="Value" format
		-- The key can contain only capital character and underscore (Pretty Okay!)
		-- The value may be escaped / quoted in any manner (What the hell?!)
		-- But since we need only NAME and VERSION_ID field this may not be that complicated
		local k, v = string.match(l, "^([A-Z_]+)=(.+)$")
		if k then
			-- Simply remove quote if needed, since NAME and VERSION_ID shouldn't be too complicated I think...
			if string.sub(v, 1, 1) == string.sub(v, -1) then
				if (string.sub(v, 1, 1) == "\"") or (string.sub(v, 1, 1) == "'") then
					v = string.sub(v, 2, -2)
				end
			end
			osRelease[k] = v
		end
	end

	-- Parse complete, and finally we can output result!
	local ret = osRelease.NAME
	if osRelease.VERSION_ID then
		ret = ret .. " " .. osRelease.VERSION_ID
	end

	return ret
end

hostOsVer.mac = function()
	-- On macOS / OS X / Mac OS X there is a command called "sw_vers"
	-- It exists so long that It should not be needed to check if it exists, just using it is possible

	local file, err = io.popen("sw_vers -productVersion", "r")

	if not file then return fail, err end

	-- The version string is in the first line
	local line = file:read()
	file:close()

	-- macOS system version may not contain the patch digit!
	local major, minor, patch = string.match(line, "^(%d+)%.(%d+)%.(%d+)$")
	if not major then major, minor = string.match(line, "^(%d+)%.(%d+)$") end
	if not major then return fail, "output from sw_vers not reconized: " .. line end

	local prefix

	-- Shall we ever support Mac OS 9 and before....???? This command may not work back in these days
	if tonumber(major) < 7 then
		prefix = "System " .. major
	elseif tonumber(major) == 7 then
		if tonumber(minor) < 5 then
			prefix = "System " .. major
		elseif tonumber(minor) == 5 then
			if not patch then
				prefix = "System " .. major
			else
				prefix = "Mac OS " .. major
			end
		else
			prefix = "Mac OS " .. major
		end
	elseif tonumber(major) < 10 then
		prefix = "Mac OS " .. major
	elseif tonumber(major) == 10 then
		if tonumber(minor) < 8 then
			-- 10.0 to 10.7 are prefixed "Mac OS X"
			prefix = "Mac OS X"
		elseif tonumber(minor) < 12 then
			-- 10.8 to 10.11 are prefixed "OS X"
			prefix = "OS X"
		elseif tonumber(minor) < 17 then
			-- 10.12 and later are prefixed "macOS"
			-- There may be macOS 10.16 if our Lua is not rebuilt using macOS 11 or later SDK.
			prefix = "macOS"
		end
	else
		-- It is not expected to change in near future
		prefix = "macOS"
	end

	if not prefix then
		return fail, "macOS version not supported " .. line
	end

	return prefix .. " " .. major .. "." .. minor .. (patch and ("." .. patch) or "")
end

hostOsVer.macM1 = hostOsVer.mac

return hostOsVer
