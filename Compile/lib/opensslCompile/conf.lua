
local conf = {}

--[[
abbrs:
	OpenSSL Versions:
		o1: OpenSSL 1.1.1j
		o3: OpenSSL 3.0.0 (Not released yet)
	Most of OpenSSL builds has its makefiles changed for our use. No "m" will be prefixed.

	Platforms:
		w: Windows
		a: Android
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
		nl: Android NDK r21e/Latest LTS
		n2: Android NDK r22/Latest
	If suffixed with a lower-case "c", it is clang compiler, with the original one as base.
	If omitted, it use a toolchain in default PATH, which should be AppleClang in macOS, or GCC in Linux.

	Variants:
		st: Static
]]

--------------------------------------------------------------------

-- OpenSSL 1.1.1j

conf.o1wx3v5 = {
	name = "OpenSSL1.1.1j-Windows-x86-VS2015",
	opensslVersion = "1.1.1j",
	host = "Win8",
	toolchain = "MSVC2015-32",
	libPath = { "bin\\libssl-1_1.dll", "bin\\libcrypto-1_1.dll" },
	configureParameter = [[
		no-asm
		shared
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN32
	]],
}

conf.o1wx3v5st = {
	name = "OpenSSL1.1.1j-Windows-x86-VS2015-static",
	opensslVersion = "1.1.1j",
	host = "Win8",
	toolchain = "MSVC2015-32",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.lib", "lib\\libcrypto.lib" },
	configureParameter = [[
		no-asm
		no-shared
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN32
	]],
}

conf.o1wx6v5 = {
	name = "OpenSSL1.1.1j-Windows-x86_64-VS2015",
	opensslVersion = "1.1.1j",
	host = "Win8",
	toolchain = "MSVC2015-64",
	libPath = { "bin\\libssl-1_1-x64.dll", "bin\\libcrypto-1_1-x64.dll" },
	configureParameter = [[
		no-asm
		shared
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN64A
	]],
}

--------------------------------------------------------------------

conf.o1wx3m7 = {
	name = "OpenSSL1.1.1j-Windows-x86-MinGW-GCC7.3.0",
	opensslVersion = "1.1.1j",
	host = "Win8SH",
	toolchain = "MinGW730-32",
	libPath = { "bin\\libssl-1_1.dll", "bin\\libcrypto-1_1.dll" },
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
	configureParameter = [[
		no-asm
		shared
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&/ssl
		mingw
	]],
}

conf.o1wx6m7 = {
	name = "OpenSSL1.1.1j-Windows-x86_64-MinGW-GCC7.3.0",
	opensslVersion = "1.1.1j",
	host = "Win8SH",
	toolchain = "MinGW730-64",
	libPath = { "bin\\libssl-1_1-x64.dll", "bin\\libcrypto-1_1-x64.dll" },
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
	configureParameter = [[
		no-asm
		shared
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&/ssl
		mingw64
	]],
}

--------------------------------------------------------------------

conf.o1wx3v7 = {
	name = "OpenSSL1.1.1j-Windows-x86-VS2017-&MSVCVER&",
	opensslVersion = "1.1.1j",
	host = "Win10",
	toolchain = "MSVC2017-32",
	libPath = { "bin\\libssl-1_1.dll", "bin\\libcrypto-1_1.dll" },
	configureParameter = [[
		no-asm
		shared
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN32
	]],
}

conf.o1wx3v7st = {
	name = "OpenSSL1.1.1j-Windows-x86-VS2017-&MSVCVER&-static",
	opensslVersion = "1.1.1j",
	host = "Win10",
	toolchain = "MSVC2017-32",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.lib", "lib\\libcrypto.lib" },
	configureParameter = [[
		no-asm
		no-shared
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN32
	]],
}

conf.o1wx6v7 = {
	name = "OpenSSL1.1.1j-Windows-x86_64-VS2017-&MSVCVER&",
	opensslVersion = "1.1.1j",
	host = "Win10",
	toolchain = "MSVC2017-64",
	libPath = { "bin\\libssl-1_1-x64.dll", "bin\\libcrypto-1_1-x64.dll" },
	configureParameter = [[
		no-asm
		shared
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN64A
	]],
}

conf.o1wx6v7st = {
	name = "OpenSSL1.1.1j-Windows-x86_64-VS2017-&MSVCVER&-static",
	opensslVersion = "1.1.1j",
	host = "Win10",
	toolchain = "MSVC2017-64",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.lib", "lib\\libcrypto.lib" },
	configureParameter = [[
		no-asm
		no-shared
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN64A
	]],
}

conf.o1wa6v7 = {
	name = "OpenSSL1.1.1j-Windows-arm64-VS2017-&MSVCVER&",
	opensslVersion = "1.1.1j",
	host = "Win10",
	target = "Win10Arm",
	toolchain = "MSVC2017-64", -- only a placeholder here, in fact it only uses "toolchainT"
	toolchainT = "MSVC2017-arm64",
	libPath = { "bin\\libssl-1_1-arm64.dll", "bin\\libcrypto-1_1-arm64.dll" },
	configureParameter = [[
		no-asm
		no-shared
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN64-ARM
	]],
}

--------------------------------------------------------------------

conf.o1wx3v9 = {
	name = "OpenSSL1.1.1j-Windows-x86-VS2019-&MSVCVER&",
	opensslVersion = "1.1.1j",
	host = "Win10",
	toolchain = "MSVC2019-32",
	libPath = { "bin\\libssl-1_1.dll", "bin\\libcrypto-1_1.dll" },
	configureParameter = [[
		no-asm
		shared
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN32
	]],
}

conf.o1wx6v9 = {
	name = "OpenSSL1.1.1j-Windows-x86_64-VS2019-&MSVCVER&",
	opensslVersion = "1.1.1j",
	host = "Win10",
	toolchain = "MSVC2019-64",
	libPath = { "bin\\libssl-1_1-x64.dll", "bin\\libcrypto-1_1-x64.dll" },
	configureParameter = [[
		no-asm
		shared
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN64A
	]],
}

--------------------------------------------------------------------

conf.o1aa3nl = {
	name = "OpenSSL1.1.1j-Android-arm-NDKr21eAPI21",
	opensslVersion = "1.1.1j",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21e-arm",
	configureParameter = [[
		no-asm
		no-shared
		--prefix=//
		--openssldir=//ssl
		android-arm
		-D__ANDROID_ABI__=21
		-march=armv7-a
		-mfloat-abi=softfp
		-mfpu=vfp
		-fno-builtin-memmove
		-mthumb
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1aa6nl = {
	name = "OpenSSL1.1.1j-Android-arm64-NDKr21eAPI21",
	opensslVersion = "1.1.1j",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21e-arm64",
	configureParameter = [[
		no-asm
		no-shared
		--prefix=//
		--openssldir=//ssl
		android-arm64
		-D__ANDROID_ABI__=21
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1ax3nl = {
	name = "OpenSSL1.1.1j-Android-x86-NDKr21eAPI21",
	opensslVersion = "1.1.1j",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21e-x86",
	configureParameter = [[
		no-asm
		no-shared
		--prefix=//
		--openssldir=//ssl
		android-x86
		-D__ANDROID_ABI__=21
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1ax6nl = {
	name = "OpenSSL1.1.1j-Android-x86_64-NDKr21eAPI21",
	opensslVersion = "1.1.1j",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21e-x86_64",
	configureParameter = [[
		no-asm
		no-shared
		--prefix=//
		--openssldir=//ssl
		android-x86_64
		-D__ANDROID_ABI__=21
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1aalnl = {
	name = "OpenSSL1.1.1j-Android-ALL-NDKr21eAPI21",
	opensslVersion = "1.1.1j",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21e-all",
	useClang = true,
}

--------------------------------------------------------------------

conf.o1aa3nl24 = {
	name = "OpenSSL1.1.1j-Android-arm-NDKr21eAPI24",
	opensslVersion = "1.1.1j",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r21e-arm",
	configureParameter = [[
		no-asm
		no-shared
		--prefix=//
		--openssldir=//ssl
		android-arm
		-D__ANDROID_ABI__=24
		-march=armv7-a
		-mfloat-abi=softfp
		-mfpu=vfp
		-fno-builtin-memmove
		-mthumb
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1aa6nl24 = {
	name = "OpenSSL1.1.1j-Android-arm64-NDKr21eAPI24",
	opensslVersion = "1.1.1j",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r21e-arm64",
	configureParameter = [[
		no-asm
		no-shared
		--prefix=//
		--openssldir=//ssl
		android-arm64
		-D__ANDROID_ABI__=24
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1ax3nl24 = {
	name = "OpenSSL1.1.1j-Android-x86-NDKr21eAPI24",
	opensslVersion = "1.1.1j",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r21e-x86",
	configureParameter = [[
		no-asm
		no-shared
		--prefix=//
		--openssldir=//ssl
		android-x86
		-D__ANDROID_ABI__=24
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1ax6nl24 = {
	name = "OpenSSL1.1.1j-Android-x86_64-NDKr21eAPI24",
	opensslVersion = "1.1.1j",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r21e-x86_64",
	configureParameter = [[
		no-asm
		no-shared
		--prefix=//
		--openssldir=//ssl
		android-x86_64
		-D__ANDROID_ABI__=24
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1aalnl24 = {
	name = "OpenSSL1.1.1j-Android-ALL-NDKr21eAPI24",
	opensslVersion = "1.1.1j",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r21e-all",
	useClang = true,
}

--------------------------------------------------------------------

conf.o1aa3n224 = {
	name = "OpenSSL1.1.1j-Android-arm-NDKr22API24",
	opensslVersion = "1.1.1j",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r22-arm",
	configureParameter = [[
		no-asm
		no-shared
		--prefix=//
		--openssldir=//ssl
		android-arm
		-D__ANDROID_ABI__=24
		-march=armv7-a
		-mfloat-abi=softfp
		-mfpu=vfp
		-fno-builtin-memmove
		-mthumb
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1aa6n224 = {
	name = "OpenSSL1.1.1j-Android-arm64-NDKr22API24",
	opensslVersion = "1.1.1j",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r22-arm64",
	configureParameter = [[
		no-asm
		no-shared
		--prefix=//
		--openssldir=//ssl
		android-arm64
		-D__ANDROID_ABI__=24
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1ax3n224 = {
	name = "OpenSSL1.1.1j-Android-x86-NDKr22API24",
	opensslVersion = "1.1.1j",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r22-x86",
	configureParameter = [[
		no-asm
		no-shared
		--prefix=//
		--openssldir=//ssl
		android-x86
		-D__ANDROID_ABI__=24
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1ax6n224 = {
	name = "OpenSSL1.1.1j-Android-x86_64-NDKr22API24",
	opensslVersion = "1.1.1j",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r22-x86_64",
	configureParameter = [[
		no-asm
		no-shared
		--prefix=//
		--openssldir=//ssl
		android-x86_64
		-D__ANDROID_ABI__=24
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1aaln224 = {
	name = "OpenSSL1.1.1j-Android-ALL-NDKr22API24",
	opensslVersion = "1.1.1j",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r22-all",
	useClang = true,
}

--------------------------------------------------------------------

local MsvcVer = {
	["MSVC2017"] = "15.9.33",
	["MSVC2019"] = "16.8.6",
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
