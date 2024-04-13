
local conf = {}

--[[
abbrs:
	OpenSSL Versions:
		o3_0: OpenSSL 3.0.13

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
		v9: VS2019
		v2: VS2022
		g1: MinGW-w64, with GCC 11.2.0
		g2: MinGW-w64, msvcrt, with GCC 12.2.0
		p2: MinGW-w64, ucrt, with GCC 12.2.0
		g3: MinGW-w64, msvcrt, with GCC 13.2.0
		p3: MinGW-w64, ucrt, with GCC 13.2.0
		s6: LLVM/Clang based MinGW-w64, msvcrt, with LLVM 16
		u6: LLVM/Clang based MinGW-w64, ucrt, with LLVM 16
		s7: LLVM/Clang based MinGW-w64, msvcrt, with LLVM 17
		u7: LLVM/Clang based MinGW-w64, ucrt, with LLVM 17
		nV21: Android NDK r21e/Previous LTS
		nV23: Android NDK r23c/Previous LTS
		nV25: Android NDK r25c/Previous LTS
		nV26: Android NDK r26d/Latest LTS
	If omitted, it use a toolchain in default PATH, which should be AppleClang in macOS, or GCC in Linux.

	Variants:
		st: Static
]]

--------------------------------------------------------------------

-- OpenSSL 3.0.13

conf.o3_0wx6v9 = {
	name = "OpenSSL3.0.13-Windows-x86_64-VS2019-&TARGETTOOLVERSION&",
	opensslVersion = "3.0.13",
	host = "Win10",
	toolchain = "MSVC2019-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&\ssl"
		VC-WIN64A
		-FS
	]],
}

conf.o3_0wx6v9st = {
	name = "OpenSSL3.0.13-Windows-x86_64-VS2019-&TARGETTOOLVERSION&-static",
	opensslVersion = "3.0.13",
	host = "Win10",
	toolchain = "MSVC2019-64",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.lib", "lib\\libcrypto.lib" },
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&\ssl"
		VC-WIN64A
		-FS
		-MT
	]],
}

conf.o3_0wx6v2 = {
	name = "OpenSSL3.0.13-Windows-x86_64-VS2022-&TARGETTOOLVERSION&",
	opensslVersion = "3.0.13",
	host = "Win10",
	toolchain = "MSVC2022-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&\ssl"
		VC-WIN64A
		-FS
	]],
}

conf.o3_0wa6v2 = {
	name = "OpenSSL3.0.13-Windows-arm64-VS2022-&TARGETTOOLVERSION&",
	opensslVersion = "3.0.13",
	host = "Win10Arm",
	toolchain = "MSVC2022-arm64",
	libPath = { "bin\\libssl-3-arm64.dll", "bin\\libcrypto-3-arm64.dll" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&\ssl"
		VC-WIN64-ARM
		-FS
	]],
}

conf.o3_0wx6v2st = {
	name = "OpenSSL3.0.13-Windows-x86_64-VS2022-&TARGETTOOLVERSION&-static",
	opensslVersion = "3.0.13",
	host = "Win10",
	toolchain = "MSVC2022-64",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.lib", "lib\\libcrypto.lib" },
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&\ssl"
		VC-WIN64A
		-FS
		-MT
	]],
}

--------------------------------------------------------------------

conf.o3_0wx6g1 = {
	name = "OpenSSL3.0.13-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&",
	opensslVersion = "3.0.13",
	host = "Win10SH",
	toolchain = "MinGW1120-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		--libdir="&INSTALLROOT&/lib"
		mingw64
	]],
}

conf.o3_0wx6p2 = {
	name = "OpenSSL3.0.13-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&-ucrt",
	opensslVersion = "3.0.13",
	host = "Win10SH",
	toolchain = "MinGW122u-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		--libdir="&INSTALLROOT&/lib"
		mingw64
	]],
}

conf.o3_0wx6g2 = {
	name = "OpenSSL3.0.13-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&-msvcrt",
	opensslVersion = "3.0.13",
	host = "Win10SH",
	toolchain = "MinGW1220-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		--libdir="&INSTALLROOT&/lib"
		mingw64
	]],
}

conf.o3_0wx6p3 = {
	name = "OpenSSL3.0.13-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&-ucrt",
	opensslVersion = "3.0.13",
	host = "Win10SH",
	toolchain = "MinGW132u-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		--libdir="&INSTALLROOT&/lib"
		mingw64
	]],
}

conf.o3_0wx6g3 = {
	name = "OpenSSL3.0.13-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&-msvcrt",
	opensslVersion = "3.0.13",
	host = "Win10SH",
	toolchain = "MinGW1320-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		--libdir="&INSTALLROOT&/lib"
		mingw64
	]],
}

conf.o3_0wx6u6 = {
	name = "OpenSSL3.0.13-Windows-x86_64-llvm-mingw-&TARGETTOOLVERSION&-ucrt",
	opensslVersion = "3.0.13",
	host = "Win10SH",
	toolchain = "MinGWLLVM-ucrt16-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	clangTriplet = "x86_64-w64-mingw32",
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		--libdir="&INSTALLROOT&/lib"
		mingw64
	]],
}

conf.o3_0wx6s6 = {
	name = "OpenSSL3.0.13-Windows-x86_64-llvm-mingw-&TARGETTOOLVERSION&-msvcrt",
	opensslVersion = "3.0.13",
	host = "Win10SH",
	toolchain = "MinGWLLVM-msvcrt16-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	clangTriplet = "x86_64-w64-mingw32",
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		--libdir="&INSTALLROOT&/lib"
		mingw64
	]],
}

conf.o3_0wx6u7 = {
	name = "OpenSSL3.0.13-Windows-x86_64-llvm-mingw-&TARGETTOOLVERSION&-ucrt",
	opensslVersion = "3.0.13",
	host = "Win10SH",
	toolchain = "MinGWLLVM-ucrt17-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	clangTriplet = "x86_64-w64-mingw32",
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		--libdir="&INSTALLROOT&/lib"
		mingw64
	]],
}

conf.o3_0wx6s7 = {
	name = "OpenSSL3.0.13-Windows-x86_64-llvm-mingw-&TARGETTOOLVERSION&-msvcrt",
	opensslVersion = "3.0.13",
	host = "Win10SH",
	toolchain = "MinGWLLVM-msvcrt17-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	clangTriplet = "x86_64-w64-mingw32",
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		--libdir="&INSTALLROOT&/lib"
		mingw64
	]],
}

conf.o3_0wx6u8 = {
	name = "OpenSSL3.0.13-Windows-x86_64-llvm-mingw-&TARGETTOOLVERSION&-ucrt",
	opensslVersion = "3.0.13",
	host = "Win10SH",
	toolchain = "MinGWLLVM-ucrt18-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	clangTriplet = "x86_64-w64-mingw32",
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		--libdir="&INSTALLROOT&/lib"
		mingw64
	]],
}

conf.o3_0wx6s8 = {
	name = "OpenSSL3.0.13-Windows-x86_64-llvm-mingw-&TARGETTOOLVERSION&-msvcrt",
	opensslVersion = "3.0.13",
	host = "Win10SH",
	toolchain = "MinGWLLVM-msvcrt18-64",
	libPath = { "bin\\libssl-3-x64.dll", "bin\\libcrypto-3-x64.dll" },
	clangTriplet = "x86_64-w64-mingw32",
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		--libdir="&INSTALLROOT&/lib"
		mingw64
	]],
}

--------------------------------------------------------------------

conf.o3_0wx6g1st = {
	name = "OpenSSL3.0.13-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&-static",
	opensslVersion = "3.0.13",
	host = "Win10SH",
	toolchain = "MinGW1120-64",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		--libdir="&INSTALLROOT&/lib"
		mingw64
		--static
		-static-libgcc
	]],
}

conf.o3_0wx6p2st = {
	name = "OpenSSL3.0.13-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&-ucrt-static",
	opensslVersion = "3.0.13",
	host = "Win10SH",
	toolchain = "MinGW122u-64",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		--libdir="&INSTALLROOT&/lib"
		mingw64
		--static
		-static-libgcc
	]],
}

conf.o3_0wx6g2st = {
	name = "OpenSSL3.0.13-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&-msvcrt-static",
	opensslVersion = "3.0.13",
	host = "Win10SH",
	toolchain = "MinGW1220-64",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		--libdir="&INSTALLROOT&/lib"
		mingw64
		--static
		-static-libgcc
	]],
}

conf.o3_0wx6p3st = {
	name = "OpenSSL3.0.13-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&-ucrt-static",
	opensslVersion = "3.0.13",
	host = "Win10SH",
	toolchain = "MinGW132u-64",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		--libdir="&INSTALLROOT&/lib"
		mingw64
		--static
		-static-libgcc
	]],
}

conf.o3_0wx6g3st = {
	name = "OpenSSL3.0.13-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&-msvcrt-static",
	opensslVersion = "3.0.13",
	host = "Win10SH",
	toolchain = "MinGW1320-64",
	variant = {"-static"},
	staticlibPath = { "lib\\libssl.a", "lib\\libcrypto.a" },
	configureParameter = [[
		no-asm
		no-shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		--libdir="&INSTALLROOT&/lib"
		mingw64
		--static
		-static-libgcc
	]],
}

--------------------------------------------------------------------

-- cross build this configuration for easy unify
conf.o3_0mx6 = {
	name = "OpenSSL3.0.13-macOS-x86_64-AppleClang&TARGETTOOLVERSION&",
	opensslVersion = "3.0.13",
	host = "macOSM1",
	libPath = { "lib/libssl.3.dylib", "lib/libcrypto.3.dylib" },
	staticlibPath = { "lib/libssl.a", "lib/libcrypto.a" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		darwin64-x86_64
		-mmacosx-version-min=10.14
	]],
}

conf.o3_0ma6 = {
	name = "OpenSSL3.0.13-macOS-arm64_v8a-AppleClang&TARGETTOOLVERSION&",
	opensslVersion = "3.0.13",
	host = "macOSM1",
	libPath = { "lib/libssl.3.dylib", "lib/libcrypto.3.dylib" },
	staticlibPath = { "lib/libssl.a", "lib/libcrypto.a" },
	configureParameter = [[
		no-asm
		shared
		enable-static-engine
		--prefix="&INSTALLROOT&"
		--openssldir="&INSTALLROOT&/ssl"
		darwin64-arm64
		-mmacosx-version-min=10.14
	]],
}

conf.o3_0mal = {
	name = "OpenSSL3.0.13-macOS-ALL-AppleClang&TARGETTOOLVERSION&",
	opensslVersion = "3.0.13",
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

conf.o3_0aa3nV21L23 = {
	name = "OpenSSL3.0.13-Android-arm-NDKr21eAPI23",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-23",
	toolchainT = "Android-23-r21e-arm",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-arm
		-D__ANDROID_API__=23
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

conf.o3_0aa6nV21L23 = {
	name = "OpenSSL3.0.13-Android-arm64-NDKr21eAPI23",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-23",
	toolchainT = "Android-23-r21e-arm64",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-arm64
		-D__ANDROID_API__=23
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o3_0ax3nV21L23 = {
	name = "OpenSSL3.0.13-Android-x86-NDKr21eAPI23",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-23",
	toolchainT = "Android-23-r21e-x86",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-x86
		-D__ANDROID_API__=23
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o3_0ax6nV21L23 = {
	name = "OpenSSL3.0.13-Android-x86_64-NDKr21eAPI23",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-23",
	toolchainT = "Android-23-r21e-x86_64",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-x86_64
		-D__ANDROID_API__=23
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o3_0aalnV21L23 = {
	name = "OpenSSL3.0.13-Android-ALL-NDKr21eAPI23",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	opensslUnifyType = "Android",
	opensslUnifyArch = {
		["armeabi-v7a"] = "o3_0aa3nV21L23",
		["arm64-v8a"] = "o3_0aa6nV21L23",
		["x86"] = "o3_0ax3nV21L23",
		["x86_64"] = "o3_0ax6nV21L23",
	},
}

--------------------------------------------------------------------

conf.o3_0aa3nV23L23 = {
	name = "OpenSSL3.0.13-Android-arm-NDKr23cAPI23",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-23",
	toolchainT = "Android-23-r23c-arm",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-arm
		-D__ANDROID_API__=23
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

conf.o3_0aa6nV23L23 = {
	name = "OpenSSL3.0.13-Android-arm64-NDKr23cAPI23",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-23",
	toolchainT = "Android-23-r23c-arm64",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-arm64
		-D__ANDROID_API__=23
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o3_0ax3nV23L23 = {
	name = "OpenSSL3.0.13-Android-x86-NDKr23cAPI23",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-23",
	toolchainT = "Android-23-r23c-x86",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-x86
		-D__ANDROID_API__=23
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o3_0ax6nV23L23 = {
	name = "OpenSSL3.0.13-Android-x86_64-NDKr23cAPI23",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-23",
	toolchainT = "Android-23-r23c-x86_64",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-x86_64
		-D__ANDROID_API__=23
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o3_0aalnV23L23 = {
	name = "OpenSSL3.0.13-Android-ALL-NDKr23cAPI23",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	opensslUnifyType = "Android",
	opensslUnifyArch = {
		["armeabi-v7a"] = "o3_0aa3nV23L23",
		["arm64-v8a"] = "o3_0aa6nV23L23",
		["x86"] = "o3_0ax3nV23L23",
		["x86_64"] = "o3_0ax6nV23L23",
	},
}

--------------------------------------------------------------------

conf.o3_0aa3nV25L23 = {
	name = "OpenSSL3.0.13-Android-arm-NDKr25cAPI23",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-23",
	toolchainT = "Android-23-r25c-arm",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-arm
		-D__ANDROID_API__=23
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

conf.o3_0aa6nV25L23 = {
	name = "OpenSSL3.0.13-Android-arm64-NDKr25cAPI23",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-23",
	toolchainT = "Android-23-r25c-arm64",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-arm64
		-D__ANDROID_API__=23
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o3_0ax3nV25L23 = {
	name = "OpenSSL3.0.13-Android-x86-NDKr25cAPI23",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-23",
	toolchainT = "Android-23-r25c-x86",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-x86
		-D__ANDROID_API__=23
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o3_0ax6nV25L23 = {
	name = "OpenSSL3.0.13-Android-x86_64-NDKr25cAPI23",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-23",
	toolchainT = "Android-23-r25c-x86_64",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
		enable-static-engine
		--prefix=//
		--openssldir=//ssl
		android-x86_64
		-D__ANDROID_API__=23
		-fstack-protector-strong
		-fPIC
		-Wl,-s
		-Wl,-z,noexecstack
	]],
}

conf.o3_0aalnV25L23 = {
	name = "OpenSSL3.0.13-Android-ALL-NDKr25cAPI23",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	opensslUnifyType = "Android",
	opensslUnifyArch = {
		["armeabi-v7a"] = "o3_0aa3nV25L23",
		["arm64-v8a"] = "o3_0aa6nV25L23",
		["x86"] = "o3_0ax3nV25L23",
		["x86_64"] = "o3_0ax6nV25L23",
	},
}

--------------------------------------------------------------------

conf.o3_0aa3nV23L24 = {
	name = "OpenSSL3.0.13-Android-arm-NDKr23cAPI24",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23c-arm",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
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

conf.o3_0aa6nV23L24 = {
	name = "OpenSSL3.0.13-Android-arm64-NDKr23cAPI24",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23c-arm64",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
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

conf.o3_0ax3nV23L24 = {
	name = "OpenSSL3.0.13-Android-x86-NDKr23cAPI24",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23c-x86",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
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

conf.o3_0ax6nV23L24 = {
	name = "OpenSSL3.0.13-Android-x86_64-NDKr23cAPI24",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23c-x86_64",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
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

conf.o3_0aalnV23L24 = {
	name = "OpenSSL3.0.13-Android-ALL-NDKr23cAPI24",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	opensslUnifyType = "Android",
	opensslUnifyArch = {
		["armeabi-v7a"] = "o3_0aa3nV23L24",
		["arm64-v8a"] = "o3_0aa6nV23L24",
		["x86"] = "o3_0ax3nV23L24",
		["x86_64"] = "o3_0ax6nV23L24",
	},
}

--------------------------------------------------------------------

conf.o3_0aa3nV25L24 = {
	name = "OpenSSL3.0.13-Android-arm-NDKr25cAPI24",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r25c-arm",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
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

conf.o3_0aa6nV25L24 = {
	name = "OpenSSL3.0.13-Android-arm64-NDKr25cAPI24",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r25c-arm64",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
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

conf.o3_0ax3nV25L24 = {
	name = "OpenSSL3.0.13-Android-x86-NDKr25cAPI24",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r25c-x86",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
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

conf.o3_0ax6nV25L24 = {
	name = "OpenSSL3.0.13-Android-x86_64-NDKr25cAPI24",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r25c-x86_64",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
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

conf.o3_0aalnV25L24 = {
	name = "OpenSSL3.0.13-Android-ALL-NDKr25cAPI24",
	opensslVersion = "3.0.13",
	host = "CentOS8",
	opensslUnifyType = "Android",
	opensslUnifyArch = {
		["armeabi-v7a"] = "o3_0aa3nV25L24",
		["arm64-v8a"] = "o3_0aa6nV25L24",
		["x86"] = "o3_0ax3nV25L24",
		["x86_64"] = "o3_0ax6nV25L24",
	},
}

--------------------------------------------------------------------

conf.o3_0aa3nV25L27 = {
	name = "OpenSSL3.0.13-Android-arm-NDKr25cAPI27",
	opensslVersion = "3.0.13",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r25c-arm",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
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

conf.o3_0aa6nV25L27 = {
	name = "OpenSSL3.0.13-Android-arm64-NDKr25cAPI27",
	opensslVersion = "3.0.13",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r25c-arm64",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
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

conf.o3_0ax3nV25L27 = {
	name = "OpenSSL3.0.13-Android-x86-NDKr25cAPI27",
	opensslVersion = "3.0.13",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r25c-x86",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
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

conf.o3_0ax6nV25L27 = {
	name = "OpenSSL3.0.13-Android-x86_64-NDKr25cAPI27",
	opensslVersion = "3.0.13",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r25c-x86_64",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
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

conf.o3_0aalnV25L27 = {
	name = "OpenSSL3.0.13-Android-ALL-NDKr25cAPI27",
	opensslVersion = "3.0.13",
	host = "Rocky9",
	opensslUnifyType = "Android",
	opensslUnifyArch = {
		["armeabi-v7a"] = "o3_0aa3nV25L27",
		["arm64-v8a"] = "o3_0aa6nV25L27",
		["x86"] = "o3_0ax3nV25L27",
		["x86_64"] = "o3_0ax6nV25L27",
	},
}

--------------------------------------------------------------------

conf.o3_0aa3nV26L27 = {
	name = "OpenSSL3.0.13-Android-arm-NDKr26dAPI27",
	opensslVersion = "3.0.13",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r26d-arm",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
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

conf.o3_0aa6nV26L27 = {
	name = "OpenSSL3.0.13-Android-arm64-NDKr26dAPI27",
	opensslVersion = "3.0.13",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r26d-arm64",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
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

conf.o3_0ax3nV26L27 = {
	name = "OpenSSL3.0.13-Android-x86-NDKr26dAPI27",
	opensslVersion = "3.0.13",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r26d-x86",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
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

conf.o3_0ax6nV26L27 = {
	name = "OpenSSL3.0.13-Android-x86_64-NDKr26dAPI27",
	opensslVersion = "3.0.13",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r26d-x86_64",
	variant = {"-static"},
	configureParameter = [[
		no-asm
		no-shared
		no-threads
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

conf.o3_0aalnV26L27 = {
	name = "OpenSSL3.0.13-Android-ALL-NDKr26dAPI27",
	opensslVersion = "3.0.13",
	host = "Rocky9",
	opensslUnifyType = "Android",
	opensslUnifyArch = {
		["armeabi-v7a"] = "o3_0aa3nV26L27",
		["arm64-v8a"] = "o3_0aa6nV26L27",
		["x86"] = "o3_0ax3nV26L27",
		["x86_64"] = "o3_0ax6nV26L27",
	},
}

--------------------------------------------------------------------

for name, value in pairs(conf) do
	-- sanity check
	if not value.name then
		io.stderr:write("no name for config " .. name .. "\n")
		io.stderr:flush()
		os.exit(1)
	end

	if not value.opensslVersion then
		io.stderr:write("no opensslVersion for config " .. name .. "\n")
		io.stderr:flush()
		os.exit(1)
	end

	if not value.host then
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

	value.variant = value.variant or {}

	value.binaryPackageUrlunix = "http://10.0.1.6:8080/job/OpenSSL/job/" .. name .. "/lastSuccessfulBuild/artifact/buildDir/" .. value.name .. ".tar.xz"
	value.sourcePackageUrlunix = "http://10.0.1.6/webdav/sources/openssl-" .. value.opensslVersion .. ".tar.gz"
	value.sourcePackageBaseName = "openssl-" .. value.opensslVersion
	value.binaryPackageUrlwin = "http://10.0.1.6:8080/job/OpenSSL/job/" .. name .. "/lastSuccessfulBuild/artifact/buildDir/" .. value.name .. ".7z"
	value.sourcePackageUrlwin = "http://10.0.1.6/webdav/sources/openssl-" .. value.opensslVersion .. ".7z"

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
