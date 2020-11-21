
local conf = {}

--[[
abbrs:
	OpenSSL Versions:
		o0: OpenSSL 1.0.2u (Reached EOL at 2019/12/31)
		o1: OpenSSL 1.1.1h
		o3: OpenSSL 3.0.0 (Not released yet)
	Most of OpenSSL builds has its makefiles changed for our use. No "m" will be prefixed.

	Platforms:
		w: Windows
		l: Linux (currently no need to compile it, because we use OpenSSL from Linux distribution)
		m: macOS/OS X
		a: Android
		W: WebAssembly (currently no need to compile it, because Qt for WebAssembly doesn't support OpenSSL)
	Other platforms will be added when supported.
	Crossed compiled versions does not marked using underscore because there is no need for distinguishing it from another version.

	Architectures:
		x3: x86
		x6: x86_64
		a3: arm(eabi)_v7
		a6: arm64
		al: All architectures

	Toolchains: (especially, not in system PATH by default)
		v5: VS2015
		v7: VS2017
		v9: VS2019
		m7: MinGW 7.3.0
		n0: Android NDK r10e
		nl: Android NDK r21/Latest Available
	If suffixed with a lower-case "c", it is clang compiler, with the original one as base.
	If omitted, it use a toolchain in default PATH, which should be AppleClang in macOS, or GCC in Linux.

	Variants:
		st: Static
]]

--------------------------------------------------------------------

-- OpenSSL 1.1.1h


conf.o1wx3v5 = {
	name = "OpenSSL1.1.1h-Windows-x86-VS2015",
	opensslVersion = "1.1.1h",
	host = "Win8",
	toolchain = "MSVC2015-32",
	libPath = { "bin\\libssl-1_1.dll", "bin\\libcrypto-1_1.dll" },
}

conf.o1wx3v5st = {
	name = "OpenSSL1.1.1h-Windows-x86-VS2015-static",
	opensslVersion = "1.1.1h",
	host = "Win8",
	toolchain = "MSVC2015-32",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.lib", "lib\\libcrypto.lib" },
}

conf.o1wx6v5 = {
	name = "OpenSSL1.1.1h-Windows-x86_64-VS2015",
	opensslVersion = "1.1.1h",
	host = "Win8",
	toolchain = "MSVC2015-64",
	libPath = { "bin\\libssl-1_1-x64.dll", "bin\\libcrypto-1_1-x64.dll" },
}

conf.o1wx3m7 = {
	name = "OpenSSL1.1.1h-Windows-x86-MinGW-GCC7.3.0",
	opensslVersion = "1.1.1h",
	host = "Win8SH",
	toolchain = "MinGW730-32",
	libPath = { "bin\\libssl-1_1.dll", "bin\\libcrypto-1_1.dll" },
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
}

conf.o1wx6m7 = {
	name = "OpenSSL1.1.1h-Windows-x86_64-MinGW-GCC7.3.0",
	opensslVersion = "1.1.1h",
	host = "Win8SH",
	toolchain = "MinGW730-64",
	libPath = { "bin\\libssl-1_1-x64.dll", "bin\\libcrypto-1_1-x64.dll" },
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
}

conf.o1wx3v7 = {
	name = "OpenSSL1.1.1h-Windows-x86-VS2017-&MSVCVER&",
	opensslVersion = "1.1.1h",
	host = "Win10",
	toolchain = "MSVC2017-32",
	libPath = { "bin\\libssl-1_1.dll", "bin\\libcrypto-1_1.dll" },
}

conf.o1wx3v7st = {
	name = "OpenSSL1.1.1h-Windows-x86-VS2017-&MSVCVER&-static",
	opensslVersion = "1.1.1h",
	host = "Win10",
	toolchain = "MSVC2017-32",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.lib", "lib\\libcrypto.lib" },
}

conf.o1wx6v7 = {
	name = "OpenSSL1.1.1h-Windows-x86_64-VS2017-&MSVCVER&",
	opensslVersion = "1.1.1h",
	host = "Win10",
	toolchain = "MSVC2017-64",
	libPath = { "bin\\libssl-1_1-x64.dll", "bin\\libcrypto-1_1-x64.dll" },
}

conf.o1wx6v7st = {
	name = "OpenSSL1.1.1h-Windows-x86_64-VS2017-&MSVCVER&-static",
	opensslVersion = "1.1.1h",
	host = "Win10",
	toolchain = "MSVC2017-64",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.lib", "lib\\libcrypto.lib" },
}

conf.o1wa6v7 = {
	name = "OpenSSL1.1.1h-Windows-arm64-VS2017-&MSVCVER&",
	opensslVersion = "1.1.1h",
	host = "Win10",
	target = "Win10Arm",
	toolchain = "MSVC2017-64", -- only a placeholder here, in fact it only uses "toolchainT"
	toolchainT = "MSVC2017-arm64",
	libPath = { "bin\\libssl-1_1-arm64.dll", "bin\\libcrypto-1_1-arm64.dll" },
}

conf.o1wx3v9 = {
	name = "OpenSSL1.1.1h-Windows-x86-VS2019-&MSVCVER&",
	opensslVersion = "1.1.1h",
	host = "Win10",
	toolchain = "MSVC2019-32",
	libPath = { "bin\\libssl-1_1.dll", "bin\\libcrypto-1_1.dll" },
}

conf.o1wx6v9 = {
	name = "OpenSSL1.1.1h-Windows-x86_64-VS2019-&MSVCVER&",
	opensslVersion = "1.1.1h",
	host = "Win10",
	toolchain = "MSVC2019-64",
	libPath = { "bin\\libssl-1_1-x64.dll", "bin\\libcrypto-1_1-x64.dll" },
}

conf.o1aa3nl = {
	name = "OpenSSL1.1.1h-AndroidAPI21-arm",
	opensslVersion = "1.1.1h",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21d-arm",
	useClang = true,
}

conf.o1aa6nl = {
	name = "OpenSSL1.1.1h-AndroidAPI21-arm64",
	opensslVersion = "1.1.1h",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21d-arm64",
	useClang = true,
}

conf.o1ax3nl = {
	name = "OpenSSL1.1.1h-AndroidAPI21-x86",
	opensslVersion = "1.1.1h",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21d-x86",
	useClang = true,
}

conf.o1ax6nl = {
	name = "OpenSSL1.1.1h-AndroidAPI21-x86_64",
	opensslVersion = "1.1.1h",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21d-x86_64",
	useClang = true,
}

conf.o1aalnl = {
	name = "OpenSSL1.1.1h-AndroidAPI21-ALL",
	opensslVersion = "1.1.1h",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21d-all",
	useClang = true,
}

--------------------------------------------------------------------

local MsvcVer = {
	["MSVC2017"] = "15.9.29",
	["MSVC2019"] = "16.8.2",
}

for name, value in pairs(conf) do
	-- sanity check
	if value.name == nil then
		io.stderr:write("no name for config " .. name .. "\n")
		io.stderr:flush()
		os.exit(1)
	end

	if value.opensslVersion == nil then
		io.stderr:write("no opensslVersion for config " .. name .. "\n")
		io.stderr:flush()
		os.exit(1)
	end

	if value.host == nil then
		io.stderr:write("no host for config " .. name .. "\n")
		io.stderr:flush()
		os.exit(1)
	end

	if not value.toolchain then
		value.toolchain = "PATH"
	end

	-- hack MSVCVER into name
	if string.sub(value.toolchain, 1, 8) == "MSVC2017" then
		value.name = string.gsub(value.name, "%&MSVCVER%&", MsvcVer.MSVC2017)
	elseif string.sub(value.toolchain, 1, 8) == "MSVC2019" then
		value.name = string.gsub(value.name, "%&MSVCVER%&", MsvcVer.MSVC2019)
	end

	if value.target and (value.target ~= value.host) then
		value.crossCompile = true
	else
		value.crossCompile = false
	end

	if not value.variant then
		value.variant = {}
	end

	-- temporary path
	value.binaryPackageUrlunix = "http://172.24.13.2:8080/job/OpenSSL/job/" .. name .. "/lastSuccessfulBuild/artifact/buildDir/" .. value.name .. ".tar.xz"
	value.sourcePackageUrlunix = "http://172.24.13.2/webdav/sources/openssl-" .. value.opensslVersion .. ".tar.gz"
	value.sourcePackageBaseName = "openssl-" .. value.opensslVersion
	value.binaryPackageUrlwin = "http://172.24.13.2:8080/job/OpenSSL/job/" .. name .. "/lastSuccessfulBuild/artifact/buildDir/" .. value.name .. ".7z"
	value.sourcePackageUrlwin = "http://172.24.13.2/webdav/sources/openssl-" .. value.opensslVersion .. ".zip"

	-- add dump function
	value.dump = function(self)
		local ret = name .. " - " .. self.name .. ":\n"
		ret = ret .. "\tOpenSSL Version: " .. self.opensslVersion .. "\n"
		ret = ret .. "\tHost: " .. self.host .. "\n"
		ret = ret .. "\tToolchain: " .. self.toolchain .. "\n"
		ret = ret .. "\tCross Compile: " .. (self.crossCompile and "true" or "false") .. "\n"
		if self.crossCompile then
			ret = ret .. "\tTarget: " .. self.target .. "\n"
			ret = ret .. "\tTarget Toolchain: " .. self.toolchainT .. "\n"
		end

		return ret
	end
end

local mo = {
	__call = function(self, para)
		return self[para]
	end,
}

setmetatable(conf, mo)

return conf
