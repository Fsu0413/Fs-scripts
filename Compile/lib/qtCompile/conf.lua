
local conf = {}

--[[
abbrs:
	Qt Versions:
		Q2: Qt 5.12.10/Past Qt 5 LTS
		Q5: Qt 5.15.2/Latest Qt 5 LTS
		q0: Qt 6.0.0 (Not released)
	If prefixed with a lower-case "m", it is a modified Qt version

	Platforms:
		w: Windows
		l: Linux
		m: macOS/OS X
		a: Android
		W: WebAssembly
	Other platforms will be added when supported.
	Some platforms needs cross compiling, especially Android, WebAssembly and Windows on ARM64, we use an underscore to mark a cross compiled version.

	Architectures:
		x3: x86
		x6: x86_64
		a3: arm(eabi)_v7
		a6: arm64_v8a
		al: All
	Other architectures will be added when supported.

	Toolchains: (especially, not in system PATH by default)
		v5: VS2015
		v7: VS2017
		v9: VS2019
		m7: MinGW-w64 7.3.0
		m8: MinGW-w64 8.1.0
		ml: MinGW-w64 *.*.*/Latest Available
		n0: Android NDK r10e, GCC
		nl: Android NDK r21d, Clang/Latest Available
	If suffixed with a lower-case "c", it is clang compiler with the original one as base.
	If omitted, it use a toolchain in default PATH, which should be AppleClang in macOS, or GCC in Linux.

	Variants:
		st: Static
		sf: Static(full)
		nf: No-Framework(for macOS)
]]

--------------------------------------------------------------------

-- Qt 5.12.10

conf.Q2wx3v5 = {
	name = "Qt5.12.10-Windows-x86-VS2015",
	qtVersion = "5.12.10",
	host = "Win8",
	toolchain = "MSVC2015-32",
	opensslConf = "o1wx3v5",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		"OPENSSL_LIBS=&OPENSSLDIR&\lib\libssl.lib &OPENSSLDIR&\lib\libcrypto.lib user32.lib gdi32.lib wsock32.lib ws2_32.lib"
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
	]],
}

conf.Q2wx3v5st = {
	name = "Qt5.12.10-Windows-x86-VS2015-static",
	qtVersion = "5.12.10",
	host = "Win8",
	toolchain = "MSVC2015-32",
	variant = {"-static"},
	opensslConf = "o1wx3v5st",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-static
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-static-runtime
		-plugin-manifests
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-no-opengl
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		-L
		&OPENSSLDIR&\lib
		"OPENSSL_LIBS=libssl.lib libcrypto.lib advapi32.lib Crypt32.lib user32.lib gdi32.lib wsock32.lib ws2_32.lib"
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
		-skip
		qt3d
		-skip
		qtcanvas3d
		-skip
		qtcharts
		-skip
		qtdatavis3d
		-skip
		qtgamepad
		-skip
		qtgraphicaleffects
		-skip
		qtlocation
		-skip
		qtmultimedia
		-skip
		qtpurchasing
		-skip
		qtquickcontrols
		-skip
		qtquickcontrols2
		-skip
		qtscxml
		-skip
		qtsensors
		-skip
		qtserialbus
		-skip
		qtserialport
		-skip
		qtspeech
		-skip
		qtsvg
		-skip
		qtwayland
		-skip
		qtwebchannel
		-skip
		qtwebsockets
		-skip
		qtsensors
		-skip
		qtnetworkauth
		-skip
		qtremoteobjects
		-skip
		qtwebview
		-skip
		qtandroidextras
		-skip
		qtconnectivity
		-skip
		qtmacextras
		-skip
		qtwebengine
		-skip
		qtx11extras
		-skip
		qtscript
	]],
}

conf.Q2wx6v5 = {
	name = "Qt5.12.10-Windows-x86_64-VS2015",
	qtVersion = "5.12.10",
	host = "Win8",
	toolchain = "MSVC2015-64",
	opensslConf = "o1wx6v5",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		"OPENSSL_LIBS=&OPENSSLDIR&\lib\libssl.lib &OPENSSLDIR&\lib\libcrypto.lib user32.lib gdi32.lib wsock32.lib ws2_32.lib"
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
	]],
}

conf.Q2wx3v7 = {
	name = "Qt5.12.10-Windows-x86-VS2017-&MSVCVER&",
	qtVersion = "5.12.10",
	host = "Win10",
	toolchain = "MSVC2017-32",
	opensslConf = "o1wx3v7",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		"OPENSSL_LIBS=&OPENSSLDIR&\lib\libssl.lib &OPENSSLDIR&\lib\libcrypto.lib user32.lib gdi32.lib wsock32.lib ws2_32.lib"
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
		-webengine-proprietary-codecs
	]],
}

conf.Q2wx3v7st = {
	name = "Qt5.12.10-Windows-x86-VS2017-&MSVCVER&-static",
	qtVersion = "5.12.10",
	host = "Win10",
	toolchain = "MSVC2017-32",
	variant = {"-static"},
	opensslConf = "o1wx3v7st",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-static
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-static-runtime
		-plugin-manifests
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-no-opengl
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		-L
		&OPENSSLDIR&\lib
		"OPENSSL_LIBS=libssl.lib libcrypto.lib advapi32.lib Crypt32.lib user32.lib gdi32.lib wsock32.lib ws2_32.lib"
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
		-skip
		qt3d
		-skip
		qtcanvas3d
		-skip
		qtcharts
		-skip
		qtdatavis3d
		-skip
		qtgamepad
		-skip
		qtgraphicaleffects
		-skip
		qtlocation
		-skip
		qtmultimedia
		-skip
		qtpurchasing
		-skip
		qtquickcontrols
		-skip
		qtquickcontrols2
		-skip
		qtscxml
		-skip
		qtsensors
		-skip
		qtserialbus
		-skip
		qtserialport
		-skip
		qtspeech
		-skip
		qtsvg
		-skip
		qtwayland
		-skip
		qtwebchannel
		-skip
		qtwebsockets
		-skip
		qtsensors
		-skip
		qtnetworkauth
		-skip
		qtremoteobjects
		-skip
		qtwebview
		-skip
		qtandroidextras
		-skip
		qtconnectivity
		-skip
		qtmacextras
		-skip
		qtwebengine
		-skip
		qtx11extras
		-skip
		qtscript
	]],
}

conf.Q2wx3v7sf = {
	name = "Qt5.12.10-Windows-x86-VS2017-&MSVCVER&-staticFull",
	qtVersion = "5.12.10",
	host = "Win10",
	toolchain = "MSVC2017-32",
	variant = {"-staticFull"},
	opensslConf = "o1wx3v7st",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-static
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-static-runtime
		-plugin-manifests
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-angle
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		-L
		&OPENSSLDIR&\lib
		"OPENSSL_LIBS=libssl.lib libcrypto.lib advapi32.lib Crypt32.lib user32.lib gdi32.lib wsock32.lib ws2_32.lib"
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
	]],
}

conf.Q2wx6v7 = {
	name = "Qt5.12.10-Windows-x86_64-VS2017-&MSVCVER&",
	qtVersion = "5.12.10",
	host = "Win10",
	toolchain = "MSVC2017-64",
	opensslConf = "o1wx6v7",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		"OPENSSL_LIBS=&OPENSSLDIR&\lib\libssl.lib &OPENSSLDIR&\lib\libcrypto.lib user32.lib gdi32.lib wsock32.lib ws2_32.lib"
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
		-webengine-proprietary-codecs
	]],
}

conf.Q2wx6v7sf = {
	name = "Qt5.12.10-Windows-x86_64-VS2017-&MSVCVER&-staticFull",
	qtVersion = "5.12.10",
	host = "Win10",
	toolchain = "MSVC2017-64",
	variant = {"-staticFull"},
	opensslConf = "o1wx6v7st",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-static
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-static-runtime
		-plugin-manifests
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-angle
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		-L
		&OPENSSLDIR&\lib
		"OPENSSL_LIBS=libssl.lib libcrypto.lib advapi32.lib Crypt32.lib user32.lib gdi32.lib wsock32.lib ws2_32.lib"
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
	]],
}

conf.Q2wx6v7_wa6v7 = {
	name = "Qt5.12.10-Windows-arm64-VS2017-&MSVCVER&-XWindows-x86_64-VS2017-&MSVCVER&",
	qtVersion = "5.12.10",
	host = "Win10",
	target = "Win10Arm",
	toolchain = "MSVC2017-64",
	toolchainT = "MSVC2017-arm64", -- only a placeholder here, in fact it uses "toolchain" instead of "toolchainT"
	opensslConf = "o1wa6v7",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-xplatform
		win32-arm64-msvc2017
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-angle
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		"OPENSSL_LIBS=&OPENSSLDIR&\lib\libssl.lib &OPENSSLDIR&\lib\libcrypto.lib user32.lib gdi32.lib wsock32.lib ws2_32.lib"
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
		-skip
		qtwebengine
	]],
}

conf.Q2wx3v9 = {
	name = "Qt5.12.10-Windows-x86-VS2019-&MSVCVER&",
	qtVersion = "5.12.10",
	host = "Win10",
	toolchain = "MSVC2019-32",
	opensslConf = "o1wx3v9",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		"OPENSSL_LIBS=&OPENSSLDIR&\lib\libssl.lib &OPENSSLDIR&\lib\libcrypto.lib user32.lib gdi32.lib wsock32.lib ws2_32.lib"
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
		-skip
		qtwebengine
	]],
}

conf.Q2wx6v9 = {
	name = "Qt5.12.10-Windows-x86_64-VS2019-&MSVCVER&",
	qtVersion = "5.12.10",
	host = "Win10",
	toolchain = "MSVC2019-64",
	opensslConf = "o1wx6v9",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		"OPENSSL_LIBS=&OPENSSLDIR&\lib\libssl.lib &OPENSSLDIR&\lib\libcrypto.lib user32.lib gdi32.lib wsock32.lib ws2_32.lib"
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
		-skip
		qtwebengine
	]],
}

conf.Q2wx3m7 = {
	name = "Qt5.12.10-Windows-x86-MinGW7.3.0",
	qtVersion = "5.12.10",
	host = "Win8",
	toolchain = "MinGW730-32",
	opensslConf = "o1wx3m7",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-g++
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		"OPENSSL_LIBS=&OPENSSLDIR&\lib\libssl.dll.a &OPENSSLDIR&\lib\libcrypto.dll.a"
		-sql-sqlite
		-sql-odbc
		-make-tool
		"mingw32-make -j10"
	]],
}

conf.Q2wx3m7sf = {
	name = "Qt5.12.10-Windows-x86-MinGW7.3.0-staticFull",
	qtVersion = "5.12.10",
	host = "Win8",
	toolchain = "MinGW730-32",
	variant = {"-staticFull"},
	opensslConf = "o1wx3m7",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-static
		-release
		-confirm-license
		-platform
		win32-g++
		-pch
		-static-runtime
		-plugin-manifests
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-angle
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		-L
		&OPENSSLDIR&\lib
		"OPENSSL_LIBS=libssl libcrypto libadvapi32 libcrypt32 libuser32 libgdi32 libwsock32 libws2_32"
		-sql-sqlite
		-sql-odbc
		-make-tool
		"mingw32-make -j10"
	]],
}

conf.Q2wx6m7 = {
	name = "Qt5.12.10-Windows-x86_64-MinGW7.3.0",
	qtVersion = "5.12.10",
	host = "Win8",
	toolchain = "MinGW730-64",
	opensslConf = "o1wx6m7",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-g++
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		"OPENSSL_LIBS=&OPENSSLDIR&\lib\libssl.dll.a &OPENSSLDIR&\lib\libcrypto.dll.a"
		-sql-sqlite
		-sql-odbc
		-make-tool
		"mingw32-make -j10"
	]],
}

conf.Q2wx6m7sf = {
	name = "Qt5.12.10-Windows-x86_64-MinGW7.3.0-staticFull",
	qtVersion = "5.12.10",
	host = "Win8",
	toolchain = "MinGW730-64",
	variant = {"-staticFull"},
	opensslConf = "o1wx6m7",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-static
		-release
		-confirm-license
		-platform
		win32-g++
		-pch
		-static-runtime
		-plugin-manifests
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-angle
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		-L
		&OPENSSLDIR&\lib
		"OPENSSL_LIBS=libssl libcrypto libadvapi32 libcrypt32 libuser32 libgdi32 libwsock32 libws2_32"
		-sql-sqlite
		-sql-odbc
		-make-tool
		"mingw32-make -j10"
	]],
}

conf.Q2lx6st = {
	name = "Qt5.12.10-Linux-x86_64-gcc8.3.1",
	qtVersion = "5.12.10",
	host = "CentOS8",
	ssl = "OpenSSL from package manager",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-static
		-release
		-confirm-license
		-platform
		linux-g++
		-static-runtime
		-plugin-manifests
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-opengl
		-ssl
		-openssl-linked
		-make-tool
		"make -j8"
		-skip
		qt3d
		-skip
		qtcanvas3d
		-skip
		qtcharts
		-skip
		qtdatavis3d
		-skip
		qtgamepad
		-skip
		qtgraphicaleffects
		-skip
		qtlocation
		-skip
		qtmultimedia
		-skip
		qtpurchasing
		-skip
		qtquickcontrols
		-skip
		qtquickcontrols2
		-skip
		qtscxml
		-skip
		qtsensors
		-skip
		qtserialbus
		-skip
		qtserialport
		-skip
		qtspeech
		-skip
		qtsvg
		-skip
		qtwayland
		-skip
		qtwebchannel
		-skip
		qtwebsockets
		-skip
		qtsensors
		-skip
		qtnetworkauth
		-skip
		qtremoteobjects
		-skip
		qtwebview
		-skip
		qtandroidextras
		-skip
		qtconnectivity
		-skip
		qtmacextras
		-skip
		qtwebengine
		-skip
		qtx11extras
		-skip
		qtscript
	]],
}

conf.Q2mx6 = {
	name = "Qt5.12.10-macOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.12.10",
	host = "macOS1015",
	ssl = "SecureTransport",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		macx-clang
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		desktop
		-no-openssl
		-securetransport
		-sql-sqlite
		-make-tool
		"make -j5"
		-rpath
		-webengine-proprietary-codecs
	]],
}

conf.Q2mx6nf = {
	name = "Qt5.12.10-macOS-x86_64-AppleClang&AppleClangVersion&-noFramework",
	qtVersion = "5.12.10",
	host = "macOS1015",
	variant = {"-noFramework"},
	ssl = "SecureTransport",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		macx-clang
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		desktop
		-no-openssl
		-securetransport
		-sql-sqlite
		-make-tool
		"make -j5"
		-rpath
		-webengine-proprietary-codecs
		-no-framework
	]],
}

conf.Q2mx6st = {
	name = "Qt5.12.10-macOS-x86_64-AppleClang&AppleClangVersion&-static",
	qtVersion = "5.12.10",
	host = "macOS1015",
	variant = {"-static"},
	ssl = "SecureTransport",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-static
		-release
		-confirm-license
		-platform
		macx-clang
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		desktop
		-no-openssl
		-securetransport
		-sql-sqlite
		-make-tool
		"make -j5"
		-skip
		qt3d
		-skip
		qtcanvas3d
		-skip
		qtcharts
		-skip
		qtdatavis3d
		-skip
		qtgamepad
		-skip
		qtgraphicaleffects
		-skip
		qtlocation
		-skip
		qtmultimedia
		-skip
		qtpurchasing
		-skip
		qtquickcontrols
		-skip
		qtquickcontrols2
		-skip
		qtscxml
		-skip
		qtsensors
		-skip
		qtserialbus
		-skip
		qtserialport
		-skip
		qtspeech
		-skip
		qtsvg
		-skip
		qtwayland
		-skip
		qtwebchannel
		-skip
		qtwebsockets
		-skip
		qtsensors
		-skip
		qtnetworkauth
		-skip
		qtremoteobjects
		-skip
		qtwebview
		-skip
		qtandroidextras
		-skip
		qtconnectivity
		-skip
		qtwinextras
		-skip
		qtwebengine
		-skip
		qtx11extras
		-skip
		qtscript
		-skip
		qtactiveqt
	]],
}

conf.Q2wx6m7_aa3nl = {
	name = "Qt5.12.10-Android-arm-Clang-NDKr21d-XWindows-x86_64-MinGW7.3.0",
	qtVersion = "5.12.10",
	host = "Win10",
	toolchain = "MinGW730-64",
	target = "Android-21",
	toolchainT = "Android-21-r21d-arm",
	opensslConf = "o1aa3nl",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-g++
		-xplatform
		android-clang
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		"OPENSSL_LIBS=&OPENSSLDIR&\lib\libssl.a &OPENSSLDIR&\lib\libcrypto.a"
		-sql-sqlite
		-make-tool
		"mingw32-make -j13"
		-android-sdk
		&ANDROIDSDKROOT&
		-android-ndk
		&ANDROIDNDKROOT&
		-android-ndk-platform
		android-21
		-android-arch
		armeabi-v7a
		-android-ndk-host
		windows-x86_64
		-skip
		qtscript
	]],
}

conf.Q2wx6m7_aa6nl = {
	name = "Qt5.12.10-Android-arm64-Clang-NDKr21d-XWindows-x86_64-MinGW7.3.0",
	qtVersion = "5.12.10",
	host = "Win10",
	toolchain = "MinGW730-64",
	target = "Android-21",
	toolchainT = "Android-21-r21d-arm64",
	opensslConf = "o1aa6nl",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-g++
		-xplatform
		android-clang
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		"OPENSSL_LIBS=&OPENSSLDIR&\lib\libssl.a &OPENSSLDIR&\lib\libcrypto.a"
		-sql-sqlite
		-make-tool
		"mingw32-make -j13"
		-android-sdk
		&ANDROIDSDKROOT&
		-android-ndk
		&ANDROIDNDKROOT&
		-android-ndk-platform
		android-21
		-android-arch
		arm64-v8a
		-android-ndk-host
		windows-x86_64
		-skip
		qtscript
	]],
}

conf.Q2wx6m7_ax3nl = {
	name = "Qt5.12.10-Android-x86-Clang-NDKr21d-XWindows-x86_64-MinGW7.3.0",
	qtVersion = "5.12.10",
	host = "Win10",
	toolchain = "MinGW730-64",
	target = "Android-21",
	toolchainT = "Android-21-r21d-x86",
	opensslConf = "o1ax3nl",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-g++
		-xplatform
		android-clang
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		"OPENSSL_LIBS=&OPENSSLDIR&\lib\libssl.a &OPENSSLDIR&\lib\libcrypto.a"
		-sql-sqlite
		-make-tool
		"mingw32-make -j13"
		-android-sdk
		&ANDROIDSDKROOT&
		-android-ndk
		&ANDROIDNDKROOT&
		-android-ndk-platform
		android-21
		-android-arch
		x86
		-android-ndk-host
		windows-x86_64
		-skip
		qtscript
	]],
}

conf.Q2lx6_aa3nl = {
	name = "Qt5.12.10-Android-arm-Clang-NDKr21d-xLinux-x86_64-gcc8.3.1",
	qtVersion = "5.12.10",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21d-arm",
	opensslConf = "o1aa3nl",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		linux-g++
		-xplatform
		android-clang
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&/include/
		-sql-sqlite
		-make-tool
		"gmake -j8"
		-android-sdk
		&ANDROIDSDKROOT&
		-android-ndk
		&ANDROIDNDKROOT&
		-android-ndk-platform
		android-21
		-android-arch
		armeabi-v7a
		-android-ndk-host
		linux-x86_64
		-skip
		qtscript
	]],
	OPENSSL_LIBS="&OPENSSLDIR&/lib/libssl.a &OPENSSLDIR&/lib/libcrypto.a"
}

conf.Q2lx6_aa6nl = {
	name = "Qt5.12.10-Android-arm64-Clang-NDKr21d-xLinux-x86_64-gcc8.3.1",
	qtVersion = "5.12.10",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21d-arm64",
	opensslConf = "o1aa6nl",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		linux-g++
		-xplatform
		android-clang
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&/include/
		-sql-sqlite
		-make-tool
		"gmake -j8"
		-android-sdk
		&ANDROIDSDKROOT&
		-android-ndk
		&ANDROIDNDKROOT&
		-android-ndk-platform
		android-21
		-android-arch
		arm64-v8a
		-android-ndk-host
		linux-x86_64
		-skip
		qtscript
	]],
	OPENSSL_LIBS="&OPENSSLDIR&/lib/libssl.a &OPENSSLDIR&/lib/libcrypto.a",
}

conf.Q2lx6_ax3nl = {
	name = "Qt5.12.10-Android-x86-Clang-NDKr21d-xLinux-x86_64-gcc8.3.1",
	qtVersion = "5.12.10",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21d-x86",
	opensslConf = "o1ax3nl",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		linux-g++
		-xplatform
		android-clang
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&/include/
		-sql-sqlite
		-make-tool
		"gmake -j8"
		-android-sdk
		&ANDROIDSDKROOT&
		-android-ndk
		&ANDROIDNDKROOT&
		-android-ndk-platform
		android-21
		-android-arch
		x86
		-android-ndk-host
		linux-x86_64
		-skip
		qtscript
	]],
	OPENSSL_LIBS="&OPENSSLDIR&/lib/libssl.a &OPENSSLDIR&/lib/libcrypto.a",
}

conf.Q2mx6_aa3nl = {
	name = "Qt5.12.10-Android-arm-Clang-NDKr21d-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.12.10",
	host = "macOS1015",
	target = "Android-21",
	toolchainT = "Android-21-r21d-arm",
	opensslConf = "o1aa3nl",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		macx-clang
		-xplatform
		android-clang
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&/include/
		-sql-sqlite
		-make-tool
		"make -j8"
		-android-sdk
		&ANDROIDSDKROOT&
		-android-ndk
		&ANDROIDNDKROOT&
		-android-ndk-platform
		android-21
		-android-arch
		armeabi-v7a
		-android-ndk-host
		darwin-x86_64
		-skip
		qtscript
	]],
	OPENSSL_LIBS="&OPENSSLDIR&/lib/libssl.a &OPENSSLDIR&/lib/libcrypto.a"
}

conf.Q2mx6_aa6nl = {
	name = "Qt5.12.10-Android-arm64-Clang-NDKr21d-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.12.10",
	host = "macOS1015",
	target = "Android-21",
	toolchainT = "Android-21-r21d-arm64",
	opensslConf = "o1aa6nl",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		macx-clang
		-xplatform
		android-clang
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&/include/
		-sql-sqlite
		-make-tool
		"make -j8"
		-android-sdk
		&ANDROIDSDKROOT&
		-android-ndk
		&ANDROIDNDKROOT&
		-android-ndk-platform
		android-21
		-android-arch
		arm64-v8a
		-android-ndk-host
		darwin-x86_64
		-skip
		qtscript
	]],
	OPENSSL_LIBS="&OPENSSLDIR&/lib/libssl.a &OPENSSLDIR&/lib/libcrypto.a",
}

conf.Q2mx6_ax3nl = {
	name = "Qt5.12.10-Android-x86-Clang-NDKr21d-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.12.10",
	host = "macOS1015",
	target = "Android-21",
	toolchainT = "Android-21-r21d-x86",
	opensslConf = "o1ax3nl",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		macx-clang
		-xplatform
		android-clang
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&/include/
		-sql-sqlite
		-make-tool
		"make -j8"
		-android-sdk
		&ANDROIDSDKROOT&
		-android-ndk
		&ANDROIDNDKROOT&
		-android-ndk-platform
		android-21
		-android-arch
		x86
		-android-ndk-host
		darwin-x86_64
		-skip
		qtscript
	]],
	OPENSSL_LIBS="&OPENSSLDIR&/lib/libssl.a &OPENSSLDIR&/lib/libcrypto.a",
}

conf.Q2lx6_W = {
	name = "Qt5.12.10-WebAssembly-emscripten1.38.16-xLinux-x86_64-gcc8.3.1",
	qtVersion = "5.12.10",
	host = "CentOS8",
	target = "WebAssembly",
	toolchainT = "emscripten-1.38.16",
	ssl = "No",
	configureParameter = [[
		-prefix
		/
		-opensource
		-release
		-confirm-license
		-platform
		linux-g++
		-xplatform
		wasm-emscripten
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-no-ssl
		-sql-sqlite
		-make-tool
		"make -j8"
	]],
}

conf.Q2mx6_W = {
	name = "Qt5.12.10-WebAssembly-emscripten1.38.16-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.12.10",
	host = "macOS1015",
	target = "WebAssembly",
	toolchainT = "emscripten-1.38.16",
	ssl = "No",
	configureParameter = [[
		-prefix
		/
		-opensource
		-release
		-confirm-license
		-platform
		macx-clang
		-xplatform
		wasm-emscripten
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-no-ssl
		-sql-sqlite
		-make-tool
		"make -j8"
	]],
}


--------------------------------------------------------------------

-- Qt 5.14.2

conf.Qlwx3v5 = {
	name = "Qt5.14.2-Windows-x86-VS2015",
	qtVersion = "5.14.2",
	host = "Win8",
	toolchain = "MSVC2015-32",
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
	]],
}

conf.Qlwx6v5 = {
	name = "Qt5.14.2-Windows-x86_64-VS2015",
	qtVersion = "5.14.2",
	host = "Win8",
	toolchain = "MSVC2015-64",
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
	]],
}

conf.Qlwx3v7 = {
	name = "Qt5.14.2-Windows-x86-VS2017-&MSVCVER&",
	qtVersion = "5.14.2",
	host = "Win10",
	toolchain = "MSVC2017-32",
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
	]],
}

conf.Qlwx6v7 = {
	name = "Qt5.14.2-Windows-x86_64-VS2017-&MSVCVER&",
	qtVersion = "5.14.2",
	host = "Win10",
	toolchain = "MSVC2017-64",
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
	]],
}

conf.Qlwx6v7_wa6v7 = {
	name = "Qt5.14.2-Windows-arm64-VS2017-&MSVCVER&-XWindows-x86_64-VS2017-&MSVCVER&",
	qtVersion = "5.14.2",
	host = "Win10",
	target = "Win10Arm",
	toolchain = "MSVC2017-64",
	toolchainT = "MSVC2017-arm64", -- only a placeholder here, in fact it uses "toolchain" instead of "toolchainT"
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-xplatform
		win32-arm64-msvc2017
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-angle
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
		-skip
		qtwebengine
	]],
}

conf.Qlwx3v9 = {
	name = "Qt5.14.2-Windows-x86-VS2019-&MSVCVER&",
	qtVersion = "5.14.2",
	host = "Win10",
	toolchain = "MSVC2019-32",
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
	]],
}

conf.Qlwx6v9 = {
	name = "Qt5.14.2-Windows-x86_64-VS2019-&MSVCVER&",
	qtVersion = "5.14.2",
	host = "Win10",
	toolchain = "MSVC2019-64",
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
	]],
}

conf.Qlwx3m7 = {
	name = "Qt5.14.2-Windows-x86-MinGW7.3.0",
	qtVersion = "5.14.2",
	host = "Win8",
	toolchain = "MinGW730-32",
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-g++
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		"mingw32-make -j10"
	]],
}

conf.Qlwx6m7 = {
	name = "Qt5.14.2-Windows-x86_64-MinGW7.3.0",
	qtVersion = "5.14.2",
	host = "Win8",
	toolchain = "MinGW730-64",
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-g++
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		"mingw32-make -j10"
	]],
}

conf.Qlmx6 = {
	name = "Qt5.14.2-macOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.14.2",
	host = "macOS1015",
	ssl = "SecureTransport",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		macx-clang
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		desktop
		-no-openssl
		-securetransport
		-sql-sqlite
		-make-tool
		"make -j5"
		-rpath
	]],
}

conf.Qlmx6nf = {
	name = "Qt5.14.2-macOS-x86_64-AppleClang&AppleClangVersion&-noFramework",
	qtVersion = "5.14.2",
	host = "macOS1015",
	variant = {"-noFramework"},
	ssl = "SecureTransport",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		macx-clang
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		desktop
		-no-openssl
		-securetransport
		-sql-sqlite
		-make-tool
		"make -j5"
		-rpath
		-no-framework
	]],
}

conf.Qlwx6m7_aalnl = {
	name = "Qt5.14.2-Android-ALL-Clang-NDKr21d-XWindows-x86_64-MinGW7.3.0",
	qtVersion = "5.14.2",
	host = "Win10",
	toolchain = "MinGW730-64",
	target = "Android-21",
	toolchainT = "Android-21-r21d-all",
	opensslConf = "o1aalnl",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-g++
		-xplatform
		android-clang
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		-L
		&OPENSSLDIR&/lib/
		-sql-sqlite
		-make-tool
		"mingw32-make -j13"
		-android-sdk
		&ANDROIDSDKROOT&
		-android-ndk
		&ANDROIDNDKROOT&
		-android-ndk-platform
		android-21
		-android-ndk-host
		windows-x86_64
		-skip
		qtscript
	]],
}

conf.Qllx6_aalnl = {
	name = "Qt5.14.2-Android-ALL-Clang-NDKr21d-xLinux-x86_64-gcc8.3.1",
	qtVersion = "5.14.2",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21d-all",
	opensslConf = "o1aalnl",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		linux-g++
		-xplatform
		android-clang
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&/include/
		-L
		&OPENSSLDIR&/lib/
		-sql-sqlite
		-make-tool
		"gmake -j8"
		-android-sdk
		&ANDROIDSDKROOT&
		-android-ndk
		&ANDROIDNDKROOT&
		-android-ndk-platform
		android-21
		-android-ndk-host
		linux-x86_64
		-skip
		qtscript
	]],
}

conf.Qlmx6_aalnl = {
	name = "Qt5.14.2-Android-ALL-Clang-NDKr21d-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.14.2",
	host = "macOS1015",
	target = "Android-21",
	toolchainT = "Android-21-r21d-all",
	opensslConf = "o1aalnl",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		macx-clang
		-xplatform
		android-clang
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&/include/
		-L
		&OPENSSLDIR&/lib/
		-sql-sqlite
		-make-tool
		"make -j8"
		-android-sdk
		&ANDROIDSDKROOT&
		-android-ndk
		&ANDROIDNDKROOT&
		-android-ndk-platform
		android-21
		-android-ndk-host
		darwin-x86_64
		-skip
		qtscript
	]],
}

conf.Qlwx6m7_W = {
	name = "Qt5.14.2-WebAssembly-emscripten1.38.30-xWindows-x86_64-MinGW7.3.0",
	qtVersion = "5.14.2",
	host = "Win10",
	toolchain = "MinGW730-64",
	target = "WebAssembly",
	toolchainT = "emscripten-1.38.30",
	ssl = "No",
	configureParameter = [[
		-prefix
		/
		-opensource
		-release
		-confirm-license
		-platform
		win32-g++
		-xplatform
		wasm-emscripten
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-no-ssl
		-feature-thread
		-sql-sqlite
		-make-tool
		"mingw32-make -j13"
	]],
}

conf.Qllx6_W = {
	name = "Qt5.14.2-WebAssembly-emscripten1.38.30-xLinux-x86_64-gcc8.3.1",
	qtVersion = "5.14.2",
	host = "CentOS8",
	target = "WebAssembly",
	toolchainT = "emscripten-1.38.30",
	ssl = "No",
	configureParameter = [[
		-prefix
		/
		-opensource
		-release
		-confirm-license
		-platform
		linux-g++
		-xplatform
		wasm-emscripten
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-no-ssl
		-feature-thread
		-sql-sqlite
		-make-tool
		"make -j8"
	]],
}

conf.Qlmx6_W = {
	name = "Qt5.14.2-WebAssembly-emscripten1.38.30-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.14.2",
	host = "macOS1015",
	target = "WebAssembly",
	toolchainT = "emscripten-1.38.30",
	ssl = "No",
	configureParameter = [[
		-prefix
		/
		-opensource
		-release
		-confirm-license
		-platform
		macx-clang
		-xplatform
		wasm-emscripten
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-no-ssl
		-feature-thread
		-sql-sqlite
		-make-tool
		"make -j8"
	]],
}

--------------------------------------------------------------------

-- Qt 5.15.2

conf.Q5wx3v5 = {
	name = "Qt5.15.2-Windows-x86-VS2015",
	qtVersion = "5.15.2",
	host = "Win8",
	toolchain = "MSVC2015-32",
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
	]],
}

conf.Q5wx6v5 = {
	name = "Qt5.15.2-Windows-x86_64-VS2015",
	qtVersion = "5.15.2",
	host = "Win8",
	toolchain = "MSVC2015-64",
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
	]],
}

conf.Q5wx3v7 = {
	name = "Qt5.15.2-Windows-x86-VS2017-&MSVCVER&",
	qtVersion = "5.15.2",
	host = "Win10",
	toolchain = "MSVC2017-32",
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
		-skip
		qtwebengine
	]],
}

conf.Q5wx6v7 = {
	name = "Qt5.15.2-Windows-x86_64-VS2017-&MSVCVER&",
	qtVersion = "5.15.2",
	host = "Win10",
	toolchain = "MSVC2017-64",
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
		-skip
		qtwebengine
	]],
}

conf.Q5wx6v7_wa6v7 = {
	name = "Qt5.15.2-Windows-arm64-VS2017-&MSVCVER&-XWindows-x86_64-VS2017-&MSVCVER&",
	qtVersion = "5.15.2",
	host = "Win10",
	target = "Win10Arm",
	toolchain = "MSVC2017-64",
	toolchainT = "MSVC2017-arm64", -- only a placeholder here, in fact it uses "toolchain" instead of "toolchainT"
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-xplatform
		win32-arm64-msvc2017
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-angle
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
		-skip
		qtwebengine
	]],
}

conf.Q5wx3v9 = {
	name = "Qt5.15.2-Windows-x86-VS2019-&MSVCVER&",
	qtVersion = "5.15.2",
	host = "Win10",
	toolchain = "MSVC2019-32",
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
		-skip
		qtwebengine
	]],
}

conf.Q5wx3v9sf = {
	name = "Qt5.15.2-Windows-x86-VS2019-&MSVCVER&-staticFull",
	qtVersion = "5.15.2",
	host = "Win10",
	toolchain = "MSVC2019-32",
	variant = {"-staticFull"},
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-static
		-feature-relocatable
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-static-runtime
		-plugin-manifests
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-angle
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
		-skip
		qtwebengine
	]],
}

conf.Q5wx6v9 = {
	name = "Qt5.15.2-Windows-x86_64-VS2019-&MSVCVER&",
	qtVersion = "5.15.2",
	host = "Win10",
	toolchain = "MSVC2019-64",
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
		-skip
		qtwebengine
	]],
}

conf.Q5wx6v9sf = {
	name = "Qt5.15.2-Windows-x86_64-VS2019-&MSVCVER&-staticFull",
	qtVersion = "5.15.2",
	host = "Win10",
	toolchain = "MSVC2019-64",
	variant = {"-staticFull"},
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-static
		-feature-relocatable
		-release
		-confirm-license
		-platform
		win32-msvc
		-pch
		-static-runtime
		-plugin-manifests
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-angle
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		jom
		-skip
		qtwebengine
	]],
}

conf.Q5wx3m8 = {
	name = "Qt5.15.2-Windows-x86-MinGW8.1.0",
	qtVersion = "5.15.2",
	host = "Win10",
	toolchain = "MinGW810-32",
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-g++
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		"mingw32-make -j10"
	]],
}

conf.Q5wx3m8sf = {
	name = "Qt5.15.2-Windows-x86-MinGW8.1.0-staticFull",
	qtVersion = "5.15.2",
	host = "Win10",
	toolchain = "MinGW810-32",
	variant = {"-staticFull"},
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-static
		-feature-relocatable
		-release
		-confirm-license
		-platform
		win32-g++
		-pch
		-static-runtime
		-plugin-manifests
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-angle
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		"mingw32-make -j10"
	]],
}

conf.Q5wx6m8 = {
	name = "Qt5.15.2-Windows-x86_64-MinGW8.1.0",
	qtVersion = "5.15.2",
	host = "Win10",
	toolchain = "MinGW810-64",
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-g++
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		dynamic
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		"mingw32-make -j10"
	]],
}

conf.Q5wx6m8sf = {
	name = "Qt5.15.2-Windows-x86_64-MinGW8.1.0-staticFull",
	qtVersion = "5.15.2",
	host = "Win10",
	toolchain = "MinGW810-64",
	variant = {"-staticFull"},
	ssl = "SChannel",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-static
		-feature-relocatable
		-release
		-confirm-license
		-platform
		win32-g++
		-pch
		-static-runtime
		-plugin-manifests
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-angle
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-make-tool
		"mingw32-make -j10"
	]],
}

conf.Q5mx6 = {
	name = "Qt5.15.2-macOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.15.2",
	host = "macOS1015",
	ssl = "SecureTransport",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		macx-clang
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		desktop
		-no-openssl
		-securetransport
		-sql-sqlite
		-make-tool
		"make -j5"
		-rpath
		-skip
		qtwebengine
	]],
}

conf.Q5mx6nf = {
	name = "Qt5.15.2-macOS-x86_64-AppleClang&AppleClangVersion&-noFramework",
	qtVersion = "5.15.2",
	host = "macOS1015",
	variant = {"-noFramework"},
	ssl = "SecureTransport",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		macx-clang
		-pch
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		desktop
		-no-openssl
		-securetransport
		-sql-sqlite
		-make-tool
		"make -j5"
		-rpath
		-skip
		qtwebengine
		-no-framework
	]],
}

conf.Q5wx6m8_aalnl = {
	name = "Qt5.15.2-Android-ALL-Clang-NDKr21d-XWindows-x86_64-MinGW8.1.0",
	qtVersion = "5.15.2",
	host = "Win10",
	toolchain = "MinGW810-64",
	target = "Android-21",
	toolchainT = "Android-21-r21d-all",
	opensslConf = "o1aalnl",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-g++
		-xplatform
		android-clang
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&\include
		-L
		&OPENSSLDIR&/lib/
		-sql-sqlite
		-make-tool
		"mingw32-make -j13"
		-android-sdk
		&ANDROIDSDKROOT&
		-android-ndk
		&ANDROIDNDKROOT&
		-android-ndk-platform
		android-21
		-android-ndk-host
		windows-x86_64
		-skip
		qtscript
	]],
}

conf.Q5lx6_aalnl = {
	name = "Qt5.15.2-Android-ALL-Clang-NDKr21d-xLinux-x86_64-gcc8.3.1",
	qtVersion = "5.15.2",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21d-all",
	opensslConf = "o1aalnl",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		linux-g++
		-xplatform
		android-clang
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&/include/
		-L
		&OPENSSLDIR&/lib/
		-sql-sqlite
		-make-tool
		"gmake -j8"
		-android-sdk
		&ANDROIDSDKROOT&
		-android-ndk
		&ANDROIDNDKROOT&
		-android-ndk-platform
		android-21
		-android-ndk-host
		linux-x86_64
		-skip
		qtscript
	]],
}

conf.Q5mx6_aalnl = {
	name = "Qt5.15.2-Android-ALL-Clang-NDKr21d-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.15.2",
	host = "macOS1015",
	target = "Android-21",
	toolchainT = "Android-21-r21d-all",
	opensslConf = "o1aalnl",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-prefix
		/
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		macx-clang
		-xplatform
		android-clang
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-ssl
		-openssl-linked
		-I
		&OPENSSLDIR&/include/
		-L
		&OPENSSLDIR&/lib/
		-sql-sqlite
		-make-tool
		"make -j8"
		-android-sdk
		&ANDROIDSDKROOT&
		-android-ndk
		&ANDROIDNDKROOT&
		-android-ndk-platform
		android-21
		-android-ndk-host
		darwin-x86_64
		-skip
		qtscript
	]],
}

conf.Q5wx6m8_W = {
	name = "Qt5.15.2-WebAssembly-emscripten1.39.8-xWindows-x86_64-MinGW8.1.0",
	qtVersion = "5.15.2",
	host = "Win10",
	toolchain = "MinGW810-64",
	target = "WebAssembly",
	toolchainT = "emscripten-1.39.8",
	ssl = "No",
	configureParameter = [[
		-prefix
		/
		-opensource
		-release
		-confirm-license
		-platform
		win32-g++
		-xplatform
		wasm-emscripten
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-no-ssl
		-feature-thread
		-sql-sqlite
		-make-tool
		"mingw32-make -j13"
	]],
}

conf.Q5lx6_W = {
	name = "Qt5.15.2-WebAssembly-emscripten1.39.8-xLinux-x86_64-gcc8.3.1",
	qtVersion = "5.15.2",
	host = "CentOS8",
	target = "WebAssembly",
	toolchainT = "emscripten-1.39.8",
	ssl = "No",
	configureParameter = [[
		-prefix
		/
		-opensource
		-release
		-confirm-license
		-platform
		linux-g++
		-xplatform
		wasm-emscripten
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-no-ssl
		-feature-thread
		-sql-sqlite
		-make-tool
		"make -j8"
	]],
}

conf.Q5mx6_W = {
	name = "Qt5.15.2-WebAssembly-emscripten1.39.8-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.15.2",
	host = "macOS1015",
	target = "WebAssembly",
	toolchainT = "emscripten-1.39.8",
	ssl = "No",
	configureParameter = [[
		-prefix
		/
		-opensource
		-release
		-confirm-license
		-platform
		macx-clang
		-xplatform
		wasm-emscripten
		-nomake
		examples
		-nomake
		tests
		-no-compile-examples
		-qt-doubleconversion
		-qt-zlib
		-qt-pcre
		-no-icu
		-opengl
		es2
		-no-ssl
		-feature-thread
		-sql-sqlite
		-make-tool
		"make -j8"
	]],
}

--------------------------------------------------------------------

conf.q0wx6v9 = {
	name = "Qt6.0.0-beta3-Windows-x86_64-VS2019-&MSVCVER&",
	qtVersion = "6.0.0-beta3",
	host = "Win10",
	toolchain = "MSVC2019-64",
	ssl = "SChannel",
	useCMake = true,
	cMakeTwice = true,
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-msvc
		-DBUILD_WITH_PCH=ON
		-DBUILD_EXAMPLES=OFF
		-DBUILD_TESTING=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=OFF
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
	]],
}

conf.q0wx6m8 = {
	name = "Qt6.0.0-beta3-Windows-x86_64-MinGW8.1.0",
	qtVersion = "6.0.0-beta3",
	host = "Win10",
	toolchain = "MinGW810-64",
	ssl = "SChannel",
	useCMake = true,
	cMakeTwice = true,
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-g++
		-DBUILD_WITH_PCH=ON
		-DBUILD_EXAMPLES=OFF
		-DBUILD_TESTING=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=OFF
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
	]],
}

conf.q0wx6m8st = {
	name = "Qt6.0.0-beta3-Windows-x86_64-MinGW8.1.0-static",
	qtVersion = "6.0.0-beta3",
	host = "Win10",
	toolchain = "MinGW810-64",
	ssl = "SChannel",
	useCMake = true,
	cMakeTwice = true,
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-g++
		-DBUILD_WITH_PCH=ON
		-DBUILD_EXAMPLES=OFF
		-DBUILD_TESTING=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=OFF
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qt3d=OFF
		-DBUILD_qt5compat=OFF
		-DBUILD_qtnetworkauth=OFF
		-DBUILD_qtquick3d=OFF
		-DBUILD_qtquickcontrols2=OFF
		-DBUILD_qtquicktimeline=OFF
		-DBUILD_qtshadertools=OFF
		-DBUILD_qtsvg=OFF
		-DBUILD_qtwayland=OFF
	]],
}

local versionMo = {
	__index = function(t, k)
		return t.default
	end
}

local OpensslVersion = {
	["default"] = "1.1.1i"
}

setmetatable(OpensslVersion, versionMo)

local QQtPatcherConf = {
	["Win10"] = "Q2wx3v7st",
	["Win8"] = "Q2wx3v5st",
	["CentOS8"] = "Q2lx6st",
	["macOS1015"] = "Q2mx6st",
}

local QQtPatcherVersion = {
	["default"] = "0.7.2"
}

setmetatable(QQtPatcherVersion, versionMo)

local MsvcVer = {
	["MSVC2017"] = "15.9.30",
	["MSVC2019"] = "16.8.3",
}

local AppleClangVersion = {
	["macOS1015"] = "12.0.0",
}

local split = function(str, sep)
    local sep, fields = sep or "\t", {}
    local pattern = string.format("([^%s]+)", sep)
    string.gsub(str, pattern, function(c) fields[#fields+1] = c end)
    return fields
end

for name, value in pairs(conf) do
	-- sanity check
	if value.name == nil then
		io.stderr:write("no name for config " .. name .. "\n")
		io.stderr:flush()
		os.exit(1)
	end

	if value.qtVersion == nil then
		io.stderr:write("no qtVersion for config " .. name .. "\n")
		io.stderr:flush()
		os.exit(1)
	end

	if value.host == nil then
		io.stderr:write("no host for config " .. name .. "\n")
		io.stderr:flush()
		os.exit(1)
	end

	-- fill other info
	if not value.ssl then
		value.ssl = "OpenSSL " .. OpensslVersion[value.qtVersion]
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

	if string.find(value.name, "AppleClang") then
		value.name = string.gsub(value.name, "%&AppleClangVersion%&", AppleClangVersion[value.host])
	end

	if value.target and (value.target ~= value.host) then
		value.crossCompile = true
	else
		value.crossCompile = false
	end

	if not value.variant then
		value.variant = {}
	end

	local qtVersionSplit = split(value.qtVersion, ".")
	local qtSourcePackagePrefix = "qt-everywhere-src-"
	local qtSourcePackageSuffix = ".tar.xz"
	value.sourcePackageFileNameunix = qtSourcePackagePrefix .. value.qtVersion .. qtSourcePackageSuffix
	value.sourcePackageFileNamewin = qtSourcePackagePrefix .. value.qtVersion .. ".zip"
	value.sourcePackageBaseName = qtSourcePackagePrefix .. value.qtVersion
	value.sourcePackageUrlunix = "http://172.24.13.2/webdav/sources/" .. value.sourcePackageFileNameunix
	value.sourcePackageUrlwin = "http://172.24.13.2/webdav/sources/" .. value.sourcePackageFileNamewin

	-- config file
	if tonumber(qtVersionSplit[1]) == 5 then
		value.configFile = { "config.log", "config.opt", "config.summary" }
		if string.sub(value.host, 1, 3) == "Win" then
			table.insert(value.configFile, "config.status.bat")
		else
			table.insert(value.configFile, "config.status")
		end
	elseif value.useCMake then
		value.configFile = { "CMakeCache.txt" }
	end

	if tonumber(qtVersionSplit[1]) > 5 or (tonumber(qtVersionSplit[1]) == 5 and tonumber(qtVersionSplit[2]) >= 14) then
		value.qQtPatcher = "no"
	else
		-- QQtPatcher
		local usingQQtPatcher = QQtPatcherConf[value.host]
		if usingQQtPatcher == name then
			value.qQtPatcher = "build"
			value.qQtPatcherSourceUrlwin = "http://172.24.13.2/webdav/sources/QQtPatcher-" .. QQtPatcherVersion[value.host] .. ".zip"
			value.qQtPatcherSourceUrlunix = "http://172.24.13.2/webdav/sources/QQtPatcher-" .. QQtPatcherVersion[value.host] .. ".tar.gz"
		else
			value.qQtPatcher = usingQQtPatcher
			value.qQtPatcherUrlwin = "http://172.24.13.2:8080/job/Qt/job/" .. value.qQtPatcher .. "/lastSuccessfulBuild/artifact/buildDir/QQtPatcher.exe"
			value.qQtPatcherUrlunix = "http://172.24.13.2:8080/job/Qt/job/" .. value.qQtPatcher .. "/lastSuccessfulBuild/artifact/buildDir/QQtPatcher"
		end
		value.qQtPatcherVersion = QQtPatcherVersion[value.host]
	end

	-- add dump function
	value.dump = function(self)
		local ret = name .. " - " .. self.name .. ":\n"
		ret = ret .. "\tQt Version: " .. self.qtVersion .. "\n"
		ret = ret .. "\tHost: " .. self.host .. "\n"
		ret = ret .. "\tToolchain: " .. self.toolchain .. "\n"
		ret = ret .. "\tCross Compile: " .. (self.crossCompile and "true" or "false") .. "\n"
		if self.crossCompile then
			ret = ret .. "\tTarget: " .. self.target .. "\n"
			ret = ret .. "\tTarget Toolchain: " .. self.toolchainT .. "\n"
		end
		ret = ret .. "\tSSL Backend: " .. self.ssl .. "\n"
		if self.opensslConf then
			ret = ret .. "\tOpenSSL Configuration: " .. self.opensslConf .. "\n"
		end
		ret = ret .. "\tUsing QQtPatcher config: " .. self.qQtPatcher .. ", version: " .. self.qQtPatcherVersion .. "\n"

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
