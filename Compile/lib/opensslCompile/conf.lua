
local conf = {}

--[[
abbrs:
	OpenSSL Versions:
		o1: OpenSSL 1.1.1t-2
		o3: OpenSSL 3.0.8-2

	Platforms:
		w: Windows
		m: macOS
		a: Android
	Other platforms will be added when supported.
	Crossed built versions does not marked using underscore because there is no need for distinguishing it from another version.

	Supported Architectures:
		x3: x86
		x6: x86_64
		a3: arm(eabi)_v7
		a6: arm64
		al: All architectures
	Other architectures will be added when supported.

	Toolchains: (especially, not in system PATH by default)
		v5: VS2015
		v7: VS2017
		v9: VS2019
		v2: VS2022
		m7: MinGW-w64, with GCC 7.3.0 (no new builds)
		m8: MinGW-w64, with GCC 8.1.0 (no new builds)
		g1: MinGW-w64, with GCC 11.2.0
		g2: MinGW-w64, with GCC 12.1.0
		s5: LLVM/Clang based MinGW-w64, msvcrt, with LLVM 15
		u5: LLVM/Clang based MinGW-w64, ucrt, with LLVM 15
		s6: LLVM/Clang based MinGW-w64, msvcrt, with LLVM 16
		u6: LLVM/Clang based MinGW-w64, ucrt, with LLVM 16
		nl: Android NDK r21e/Previous LTS
		n3: Android NDK r23c/Previous LTS
		n5: Android NDK r25c/Latest LTS
	If omitted, it use a toolchain in default PATH, which should be AppleClang in macOS, or GCC in Linux.

	Variants:
		st: Static
]]

--------------------------------------------------------------------

-- OpenSSL 1.1.1t-2

conf.o1_1wx3v5 = {
	name = "OpenSSL1.1.1t-2-Windows-x86-VS2015",
	opensslVersion = "1.1.1t-2",
	host = "Win8",
	toolchain = "MSVC2015-32",
	libPath = { "bin\\libssl-1_1.dll", "bin\\libcrypto-1_1.dll" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN32
		-FS
	]],
}

conf.o1_1wx3v5st = {
	name = "OpenSSL1.1.1t-2-Windows-x86-VS2015-static",
	opensslVersion = "1.1.1t-2",
	host = "Win8",
	toolchain = "MSVC2015-32",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.lib", "lib\\libcrypto.lib" },
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN32
		-FS
	]],
}

conf.o1_1wx6v5 = {
	name = "OpenSSL1.1.1t-2-Windows-x86_64-VS2015",
	opensslVersion = "1.1.1t-2",
	host = "Win8",
	toolchain = "MSVC2015-64",
	libPath = { "bin\\libssl-1_1-x64.dll", "bin\\libcrypto-1_1-x64.dll" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN64A
		-FS
	]],
}

--------------------------------------------------------------------

conf.o1_1wx3g7 = {
	name = "OpenSSL1.1.1t-2-Windows-x86-MinGW-GCC&TARGETTOOLVERSION&",
	opensslVersion = "1.1.1t-2",
	host = "Win8SH",
	toolchain = "MinGW730-32",
	libPath = { "bin\\libssl-1_1.dll", "bin\\libcrypto-1_1.dll" },
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&/ssl
		mingw
	]],
}

conf.o1_1wx6g7 = {
	name = "OpenSSL1.1.1t-2-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&",
	opensslVersion = "1.1.1t-2",
	host = "Win8SH",
	toolchain = "MinGW730-64",
	libPath = { "bin\\libssl-1_1-x64.dll", "bin\\libcrypto-1_1-x64.dll" },
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&/ssl
		mingw64
	]],
}

--------------------------------------------------------------------

conf.o1_1wx3v7 = {
	name = "OpenSSL1.1.1t-2-Windows-x86-VS2017-&TARGETTOOLVERSION&",
	opensslVersion = "1.1.1t-2",
	host = "Win10",
	toolchain = "MSVC2017-32",
	libPath = { "bin\\libssl-1_1.dll", "bin\\libcrypto-1_1.dll" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN32
		-FS
	]],
}

conf.o1_1wx3v7st = {
	name = "OpenSSL1.1.1t-2-Windows-x86-VS2017-&TARGETTOOLVERSION&-static",
	opensslVersion = "1.1.1t-2",
	host = "Win10",
	toolchain = "MSVC2017-32",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.lib", "lib\\libcrypto.lib" },
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN32
		-FS
	]],
}

conf.o1_1wx6v7 = {
	name = "OpenSSL1.1.1t-2-Windows-x86_64-VS2017-&TARGETTOOLVERSION&",
	opensslVersion = "1.1.1t-2",
	host = "Win10",
	toolchain = "MSVC2017-64",
	libPath = { "bin\\libssl-1_1-x64.dll", "bin\\libcrypto-1_1-x64.dll" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN64A
		-FS
	]],
}

--------------------------------------------------------------------

conf.o1_1wx3v9 = {
	name = "OpenSSL1.1.1t-2-Windows-x86-VS2019-&TARGETTOOLVERSION&",
	opensslVersion = "1.1.1t-2",
	host = "Win10",
	toolchain = "MSVC2019-32",
	libPath = { "bin\\libssl-1_1.dll", "bin\\libcrypto-1_1.dll" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN32
		-FS
	]],
}

conf.o1_1wx6v9 = {
	name = "OpenSSL1.1.1t-2-Windows-x86_64-VS2019-&TARGETTOOLVERSION&",
	opensslVersion = "1.1.1t-2",
	host = "Win10",
	toolchain = "MSVC2019-64",
	libPath = { "bin\\libssl-1_1-x64.dll", "bin\\libcrypto-1_1-x64.dll" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN64A
		-FS
	]],
}

--------------------------------------------------------------------

conf.o1_1aa3nl = {
	name = "OpenSSL1.1.1t-2-Android-arm-NDKr21eAPI21",
	opensslVersion = "1.1.1t-2",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21e-arm",
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-arm
		-D__ANDROID_API__=21
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

conf.o1_1aa6nl = {
	name = "OpenSSL1.1.1t-2-Android-arm64-NDKr21eAPI21",
	opensslVersion = "1.1.1t-2",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21e-arm64",
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-arm64
		-D__ANDROID_API__=21
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1_1ax3nl = {
	name = "OpenSSL1.1.1t-2-Android-x86-NDKr21eAPI21",
	opensslVersion = "1.1.1t-2",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21e-x86",
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-x86
		-D__ANDROID_API__=21
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1_1ax6nl = {
	name = "OpenSSL1.1.1t-2-Android-x86_64-NDKr21eAPI21",
	opensslVersion = "1.1.1t-2",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21e-x86_64",
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-x86_64
		-D__ANDROID_API__=21
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1_1aalnl = {
	name = "OpenSSL1.1.1t-2-Android-ALL-NDKr21eAPI21",
	opensslVersion = "1.1.1t-2",
	host = "CentOS8",
	opensslUnifyType = "Android",
	opensslUnifyArch = {
		["armeabi-v7a"] = "o1_1aa3nl",
		["arm64-v8a"] = "o1_1aa6nl",
		["x86"] = "o1_1ax3nl",
		["x86_64"] = "o1_1ax6nl",
	},
}

--------------------------------------------------------------------

conf.o1_1aa3n321 = {
	name = "OpenSSL1.1.1t-2-Android-arm-NDKr23cAPI21",
	opensslVersion = "1.1.1t-2",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r23c-arm",
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-arm
		-D__ANDROID_API__=21
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

conf.o1_1aa6n321 = {
	name = "OpenSSL1.1.1t-2-Android-arm64-NDKr23cAPI21",
	opensslVersion = "1.1.1t-2",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r23c-arm64",
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-arm64
		-D__ANDROID_API__=21
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1_1ax3n321 = {
	name = "OpenSSL1.1.1t-2-Android-x86-NDKr23cAPI21",
	opensslVersion = "1.1.1t-2",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r23c-x86",
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-x86
		-D__ANDROID_API__=21
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1_1ax6n321 = {
	name = "OpenSSL1.1.1t-2-Android-x86_64-NDKr23cAPI21",
	opensslVersion = "1.1.1t-2",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r23c-x86_64",
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-x86_64
		-D__ANDROID_API__=21
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o1_1aaln321 = {
	name = "OpenSSL1.1.1t-2-Android-ALL-NDKr23cAPI21",
	opensslVersion = "1.1.1t-2",
	host = "CentOS8",
	opensslUnifyType = "Android",
	opensslUnifyArch = {
		["armeabi-v7a"] = "o1_1aa3n321",
		["arm64-v8a"] = "o1_1aa6n321",
		["x86"] = "o1_1ax3n321",
		["x86_64"] = "o1_1ax6n321",
	},
}

--------------------------------------------------------------------

-- OpenSSL 3.0.8-2

conf.o3_0wx6v9 = {
	name = "OpenSSL3.0.8-2-Windows-x86_64-VS2019-&TARGETTOOLVERSION&",
	opensslVersion = "3.0.8-2",
	host = "Win10",
	toolchain = "MSVC2019-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN64A
		-FS
	]],
}

conf.o3_0wx6v9st = {
	name = "OpenSSL3.0.8-2-Windows-x86_64-VS2019-&TARGETTOOLVERSION&-static",
	opensslVersion = "3.0.8-2",
	host = "Win10",
	toolchain = "MSVC2019-64",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.lib", "lib\\libcrypto.lib" },
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN64A
		-FS
	]],
}

conf.o3_0wx6v2 = {
	name = "OpenSSL3.0.8-2-Windows-x86_64-VS2022-&TARGETTOOLVERSION&",
	opensslVersion = "3.0.8-2",
	host = "Win10",
	toolchain = "MSVC2022-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN64A
		-FS
	]],
}

conf.o3_0wx6v2st = {
	name = "OpenSSL3.0.8-2-Windows-x86_64-VS2022-&TARGETTOOLVERSION&-static",
	opensslVersion = "3.0.8-2",
	host = "Win10",
	toolchain = "MSVC2022-64",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.lib", "lib\\libcrypto.lib" },
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&\ssl
		VC-WIN64A
		-FS
	]],
}

--------------------------------------------------------------------

conf.o3_0wx6g1 = {
	name = "OpenSSL3.0.8-2-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&",
	opensslVersion = "3.0.8-2",
	host = "Win10SH",
	toolchain = "MinGW1120-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&/ssl
		--libdir=&INSTALLROOT&/lib
		mingw64
	]],
}

conf.o3_0wx6g2 = {
	name = "OpenSSL3.0.8-2-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&",
	opensslVersion = "3.0.8-2",
	host = "Win10SH",
	toolchain = "MinGW1210-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&/ssl
		--libdir=&INSTALLROOT&/lib
		mingw64
	]],
}

conf.o3_0wx6u5 = {
	name = "OpenSSL3.0.8-2-Windows-x86_64-llvm-mingw-&TARGETTOOLVERSION&-ucrt",
	opensslVersion = "3.0.8-2",
	host = "Win10SH",
	toolchain = "MinGWLLVM-ucrt15-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
	clangTriplet = "x86_64-w64-mingw32",
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&/ssl
		--libdir=&INSTALLROOT&/lib
		mingw64
	]],
}

conf.o3_0wx6s5 = {
	name = "OpenSSL3.0.8-2-Windows-x86_64-llvm-mingw-&TARGETTOOLVERSION&-msvcrt",
	opensslVersion = "3.0.8-2",
	host = "Win10SH",
	toolchain = "MinGWLLVM-msvcrt15-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
	clangTriplet = "x86_64-w64-mingw32",
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&/ssl
		--libdir=&INSTALLROOT&/lib
		mingw64
	]],
}

conf.o3_0wx6u6 = {
	name = "OpenSSL3.0.8-2-Windows-x86_64-llvm-mingw-&TARGETTOOLVERSION&-ucrt",
	opensslVersion = "3.0.8-2",
	host = "Win10SH",
	toolchain = "MinGWLLVM-ucrt16-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
	clangTriplet = "x86_64-w64-mingw32",
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&/ssl
		--libdir=&INSTALLROOT&/lib
		mingw64
	]],
}

conf.o3_0wx6s6 = {
	name = "OpenSSL3.0.8-2-Windows-x86_64-llvm-mingw-&TARGETTOOLVERSION&-msvcrt",
	opensslVersion = "3.0.8-2",
	host = "Win10SH",
	toolchain = "MinGWLLVM-msvcrt16-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
	clangTriplet = "x86_64-w64-mingw32",
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&/ssl
		--libdir=&INSTALLROOT&/lib
		mingw64
	]],
}

--------------------------------------------------------------------

-- cross build this configuration for easy unify
conf.o3_0mx6 = {
	name = "OpenSSL3.0.8-2-macOS-x86_64-AppleClang&TARGETTOOLVERSION&",
	opensslVersion = "3.0.8-2",
	host = "macOSM1",
	libPath = { "lib/libssl.3.dylib", "lib/libcrypto.3.dylib" },
	staticlibPath = { "lib/libssl.a", "lib/libcrypto.a" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&/ssl
		darwin64-x86_64
		-mmacosx-version-min=10.14
	]],
}

conf.o3_0ma6 = {
	name = "OpenSSL3.0.8-2-macOS-arm64_v8a-AppleClang&TARGETTOOLVERSION&",
	opensslVersion = "3.0.8-2",
	host = "macOSM1",
	libPath = { "lib/libssl.3.dylib", "lib/libcrypto.3.dylib" },
	staticlibPath = { "lib/libssl.a", "lib/libcrypto.a" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix=&INSTALLROOT&
		--openssldir=&INSTALLROOT&/ssl
		darwin64-arm64
		-mmacosx-version-min=10.14
	]],
}

conf.o3_0mal = {
	name = "OpenSSL3.0.8-2-macOS-ALL-AppleClang&TARGETTOOLVERSION&",
	opensslVersion = "3.0.8-2",
	host = "macOSM1",
	libPath = { "lib/libssl.3.dylib", "lib/libcrypto.3.dylib" },
	staticlibPath = { "lib/libssl.a", "lib/libcrypto.a" },
	opensslUnifyType = "macOS",
	opensslUnifyArch = {
		["arm64"] = "o3_0ma6",
		["x86_64"] = "o3_0mx6",
	},
}

--------------------------------------------------------------------

conf.o3_0aa3n324 = {
	name = "OpenSSL3.0.8-2-Android-arm-NDKr23cAPI24",
	opensslVersion = "3.0.8-2",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23c-arm",
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-arm
		-D__ANDROID_API__=24
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

conf.o3_0aa6n324 = {
	name = "OpenSSL3.0.8-2-Android-arm64-NDKr23cAPI24",
	opensslVersion = "3.0.8-2",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23c-arm64",
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-arm64
		-D__ANDROID_API__=24
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o3_0ax3n324 = {
	name = "OpenSSL3.0.8-2-Android-x86-NDKr23cAPI24",
	opensslVersion = "3.0.8-2",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23c-x86",
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-x86
		-D__ANDROID_API__=24
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o3_0ax6n324 = {
	name = "OpenSSL3.0.8-2-Android-x86_64-NDKr23cAPI24",
	opensslVersion = "3.0.8-2",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23c-x86_64",
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-x86_64
		-D__ANDROID_API__=24
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o3_0aaln324 = {
	name = "OpenSSL3.0.8-2-Android-ALL-NDKr23cAPI24",
	opensslVersion = "3.0.8-2",
	host = "CentOS8",
	opensslUnifyType = "Android",
	opensslUnifyArch = {
		["armeabi-v7a"] = "o3_0aa3n324",
		["arm64-v8a"] = "o3_0aa6n324",
		["x86"] = "o3_0ax3n324",
		["x86_64"] = "o3_0ax6n324",
	},
}
--------------------------------------------------------------------

conf.o3_0aa3n527 = {
	name = "OpenSSL3.0.8-2-Android-arm-NDKr25API27",
	opensslVersion = "3.0.8-2",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r25c-arm",
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-arm
		-D__ANDROID_API__=27
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

conf.o3_0aa6n527 = {
	name = "OpenSSL3.0.8-2-Android-arm64-NDKr25API27",
	opensslVersion = "3.0.8-2",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r25c-arm64",
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-arm64
		-D__ANDROID_API__=27
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o3_0ax3n527 = {
	name = "OpenSSL3.0.8-2-Android-x86-NDKr25API27",
	opensslVersion = "3.0.8-2",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r25c-x86",
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-x86
		-D__ANDROID_API__=27
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o3_0ax6n527 = {
	name = "OpenSSL3.0.8-2-Android-x86_64-NDKr25API27",
	opensslVersion = "3.0.8-2",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r25c-x86_64",
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-x86_64
		-D__ANDROID_API__=27
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o3_0aaln527 = {
	name = "OpenSSL3.0.8-2-Android-ALL-NDKr25API27",
	opensslVersion = "3.0.8-2",
	host = "Rocky9",
	opensslUnifyType = "Android",
	opensslUnifyArch = {
		["armeabi-v7a"] = "o3_0aa3n527",
		["arm64-v8a"] = "o3_0aa6n527",
		["x86"] = "o3_0ax3n527",
		["x86_64"] = "o3_0ax6n527",
	},
}

--------------------------------------------------------------------

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
end

local valueMo = {
	__tostring = function(v)
		return v:dump()
	end
}

for name, value in pairs(conf) do
	if value.target and (value.target ~= value.host) then
		value.crossCompile = true
	else
		value.crossCompile = false
	end

	if not value.variant then
		value.variant = {}
	end

	value.binaryPackageUrlunix = "http://172.24.13.6:8080/job/OpenSSL/job/" .. name .. "/lastSuccessfulBuild/artifact/buildDir/" .. value.name .. ".tar.xz"
	value.sourcePackageUrlunix = "http://172.24.13.6/webdav/sources/openssl-" .. value.opensslVersion .. ".tar.gz"
	value.sourcePackageBaseName = "openssl-" .. value.opensslVersion
	value.binaryPackageUrlwin = "http://172.24.13.6:8080/job/OpenSSL/job/" .. name .. "/lastSuccessfulBuild/artifact/buildDir/" .. value.name .. ".7z"
	value.sourcePackageUrlwin = "http://172.24.13.6/webdav/sources/openssl-" .. value.opensslVersion .. ".7z"

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

	setmetatable(value, valueMo)
end

local mo = {
	__call = function(self, para)
		return self[para]
	end,
}

setmetatable(conf, mo)

return conf
