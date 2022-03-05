
local conf = {}

--[[
abbrs:
	Qt Versions:
		Q2: Qt 5.12.12/Previous Qt 5 LTS
		Q5: Qt 5.15.3/Latest Qt 5 LTS w/ latest QtWebEngine and latest QtScript
		q6_2: Qt 6.2.3/Latest Qt 6 LTS w/ latest QtWebEngine and latest QtScript
	If prefixed with a lower-case "m", it is a modified Qt version

	Platforms:
		w: Windows
		l: Linux
		m: macOS
		a: Android
		W: WebAssembly (w/o Architecture)
	Other platforms will be added when supported.
	Some platforms needs cross compiling, especially Android, WebAssembly and Windows on ARM64, we use an underscore to mark a cross compiled version.

	Supported Architectures:
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
		v2: VS2022
		m7: MinGW-w64, with GCC 7.3.0
		m8: MinGW-w64, with GCC 8.1.0
		m1: MinGW-w64, with GCC 11.2.0
		mv: LLVM/Clang based MinGW-w64, msvcrt, with LLVM 13
		mu: LLVM/Clang based MinGW-w64, ucrt, with LLVM 13
		nl: Android NDK r21e/Previous LTS
		n3: Android NDK r23b/Latest LTS
	If omitted, it use a toolchain in default PATH, which should be AppleClang in macOS, or GCC in Linux.

	Variants:
		st: Static
		sf: Static(full)
		nf: No-Framework(for macOS)
]]

--------------------------------------------------------------------

-- Qt 5.12.12

conf.Q2wx3v5 = {
	name = "Qt5.12.12-Windows-x86-VS2015",
	qtVersion = "5.12.12",
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
	name = "Qt5.12.12-Windows-x86-VS2015-static",
	qtVersion = "5.12.12",
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
	name = "Qt5.12.12-Windows-x86_64-VS2015",
	qtVersion = "5.12.12",
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
	name = "Qt5.12.12-Windows-x86-VS2017-&MSVCVER&",
	qtVersion = "5.12.12",
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
	name = "Qt5.12.12-Windows-x86-VS2017-&MSVCVER&-static",
	qtVersion = "5.12.12",
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
	name = "Qt5.12.12-Windows-x86-VS2017-&MSVCVER&-staticFull",
	qtVersion = "5.12.12",
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
	name = "Qt5.12.12-Windows-x86_64-VS2017-&MSVCVER&",
	qtVersion = "5.12.12",
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
	name = "Qt5.12.12-Windows-x86_64-VS2017-&MSVCVER&-staticFull",
	qtVersion = "5.12.12",
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

conf.Q2wx3v9 = {
	name = "Qt5.12.12-Windows-x86-VS2019-&MSVCVER&",
	qtVersion = "5.12.12",
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
	name = "Qt5.12.12-Windows-x86_64-VS2019-&MSVCVER&",
	qtVersion = "5.12.12",
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
	name = "Qt5.12.12-Windows-x86-MinGW7.3.0",
	qtVersion = "5.12.12",
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
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.Q2wx3m7sf = {
	name = "Qt5.12.12-Windows-x86-MinGW7.3.0-staticFull",
	qtVersion = "5.12.12",
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
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.Q2wx6m7 = {
	name = "Qt5.12.12-Windows-x86_64-MinGW7.3.0",
	qtVersion = "5.12.12",
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
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.Q2wx6m7sf = {
	name = "Qt5.12.12-Windows-x86_64-MinGW7.3.0-staticFull",
	qtVersion = "5.12.12",
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
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.Q2lx6st = {
	name = "Qt5.12.12-Linux-x86_64-gcc8.5.0-static",
	qtVersion = "5.12.12",
	host = "CentOS8",
	variant = {"-static"},
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
		"make -j$PARALLELNUM"
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
	name = "Qt5.12.12-macOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.12.12",
	host = "macOSLegacyLegacy",
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
		"make -j$PARALLELNUM"
		-rpath
		-webengine-proprietary-codecs
	]],
}

conf.Q2mx6nf = {
	name = "Qt5.12.12-macOS-x86_64-AppleClang&AppleClangVersion&-noFramework",
	qtVersion = "5.12.12",
	host = "macOSLegacyLegacy",
	variant = {"-noFramework"},
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
		"make -j$PARALLELNUM"
		-rpath
		-webengine-proprietary-codecs
		-no-framework
	]],
}

conf.q5_12mLx6st = {
	name = "Qt5.12.12-macOSLegacy-x86_64-AppleClang&AppleClangVersion&-static",
	qtVersion = "5.12.12",
	host = "macOSLegacy",
	variant = {"-static"},
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
		"make -j$PARALLELNUM"
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
	name = "Qt5.12.12-Android-arm-Clang-NDKr21e-XWindows-x86_64-MinGW7.3.0",
	qtVersion = "5.12.12",
	host = "Win10",
	toolchain = "MinGW730-64",
	target = "Android-21",
	toolchainT = "Android-21-r21e-arm",
	opensslConf = "o1aa3nl",
	androidSdkVersion = "29",
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
		"mingw32-make -j%PARALLELNUM%"
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
	name = "Qt5.12.12-Android-arm64-Clang-NDKr21e-XWindows-x86_64-MinGW7.3.0",
	qtVersion = "5.12.12",
	host = "Win10",
	toolchain = "MinGW730-64",
	target = "Android-21",
	toolchainT = "Android-21-r21e-arm64",
	opensslConf = "o1aa6nl",
	androidSdkVersion = "29",
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
		"mingw32-make -j%PARALLELNUM%"
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
	name = "Qt5.12.12-Android-x86-Clang-NDKr21e-XWindows-x86_64-MinGW7.3.0",
	qtVersion = "5.12.12",
	host = "Win10",
	toolchain = "MinGW730-64",
	target = "Android-21",
	toolchainT = "Android-21-r21e-x86",
	opensslConf = "o1ax3nl",
	androidSdkVersion = "29",
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
		"mingw32-make -j%PARALLELNUM%"
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
	name = "Qt5.12.12-Android-arm-Clang-NDKr21e-xLinux-x86_64-gcc8.5.0",
	qtVersion = "5.12.12",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21e-arm",
	opensslConf = "o1aa3nl",
	androidSdkVersion = "29",
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
		"make -j$PARALLELNUM"
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
	name = "Qt5.12.12-Android-arm64-Clang-NDKr21e-xLinux-x86_64-gcc8.5.0",
	qtVersion = "5.12.12",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21e-arm64",
	opensslConf = "o1aa6nl",
	androidSdkVersion = "29",
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
		"make -j$PARALLELNUM"
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
	name = "Qt5.12.12-Android-x86-Clang-NDKr21e-xLinux-x86_64-gcc8.5.0",
	qtVersion = "5.12.12",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21e-x86",
	opensslConf = "o1ax3nl",
	androidSdkVersion = "29",
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
		"make -j$PARALLELNUM"
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
	name = "Qt5.12.12-Android-arm-Clang-NDKr21e-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.12.12",
	host = "macOSLegacy",
	target = "Android-21",
	toolchainT = "Android-21-r21e-arm",
	opensslConf = "o1aa3nl",
	androidSdkVersion = "29",
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
		"make -j$PARALLELNUM"
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
	name = "Qt5.12.12-Android-arm64-Clang-NDKr21e-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.12.12",
	host = "macOSLegacy",
	target = "Android-21",
	toolchainT = "Android-21-r21e-arm64",
	opensslConf = "o1aa6nl",
	androidSdkVersion = "29",
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
		"make -j$PARALLELNUM"
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
	name = "Qt5.12.12-Android-x86-Clang-NDKr21e-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.12.12",
	host = "macOSLegacy",
	target = "Android-21",
	toolchainT = "Android-21-r21e-x86",
	opensslConf = "o1ax3nl",
	androidSdkVersion = "29",
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
		"make -j$PARALLELNUM"
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
	name = "Qt5.12.12-WebAssembly-emscripten1.38.16-xLinux-x86_64-gcc8.5.0",
	qtVersion = "5.12.12",
	host = "CentOS8",
	target = "WebAssembly",
	toolchainT = "emscripten-1.38.16",
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
		"make -j$PARALLELNUM"
	]],
}

conf.Q2mx6_W = {
	name = "Qt5.12.12-WebAssembly-emscripten1.38.16-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.12.12",
	host = "macOSLegacy",
	target = "WebAssembly",
	toolchainT = "emscripten-1.38.16",
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
		"make -j$PARALLELNUM"
	]],
}

--------------------------------------------------------------------

-- Qt 5.15.3

conf.Q5wx3v5 = {
	name = "Qt5.15.3-Windows-x86-VS2015",
	qtVersion = "5.15.3",
	host = "Win8",
	toolchain = "MSVC2015-32",
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
	name = "Qt5.15.3-Windows-x86_64-VS2015",
	qtVersion = "5.15.3",
	host = "Win8",
	toolchain = "MSVC2015-64",
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
	name = "Qt5.15.3-Windows-x86-VS2017-&MSVCVER&",
	qtVersion = "5.15.3-5",
	host = "Win10",
	toolchain = "MSVC2017-32",
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
	name = "Qt5.15.3-Windows-x86_64-VS2017-&MSVCVER&",
	qtVersion = "5.15.3-5",
	host = "Win10",
	toolchain = "MSVC2017-64",
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

conf.Q5wx3v9 = {
	name = "Qt5.15.3-Windows-x86-VS2019-&MSVCVER&",
	qtVersion = "5.15.3-5",
	host = "Win10",
	toolchain = "MSVC2019-32",
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
		-webengine-proprietary-codecs
	]],
}

conf.Q5wx3v9sf = {
	name = "Qt5.15.3-Windows-x86-VS2019-&MSVCVER&-staticFull",
	qtVersion = "5.15.3-5",
	host = "Win10",
	toolchain = "MSVC2019-32",
	variant = {"-staticFull"},
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
	name = "Qt5.15.3-Windows-x86_64-VS2019-&MSVCVER&",
	qtVersion = "5.15.3-5",
	host = "Win10",
	toolchain = "MSVC2019-64",
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
		-webengine-proprietary-codecs
	]],
}

conf.Q5wx6v9sf = {
	name = "Qt5.15.3-Windows-x86_64-VS2019-&MSVCVER&-staticFull",
	qtVersion = "5.15.3-5",
	host = "Win10",
	toolchain = "MSVC2019-64",
	variant = {"-staticFull"},
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

conf.Q5wx6v2 = {
	name = "Qt5.15.3-Windows-x86_64-VS2022-&MSVCVER&",
	qtVersion = "5.15.3-5",
	host = "Win10",
	toolchain = "MSVC2022-64",
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
		-webengine-proprietary-codecs
	]],
}

conf.Q5wx3m8 = {
	name = "Qt5.15.3-Windows-x86-MinGW8.1.0",
	qtVersion = "5.15.3",
	host = "Win10",
	toolchain = "MinGW810-32",
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
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.Q5wx3m8sf = {
	name = "Qt5.15.3-Windows-x86-MinGW8.1.0-staticFull",
	qtVersion = "5.15.3",
	host = "Win10",
	toolchain = "MinGW810-32",
	variant = {"-staticFull"},
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
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.Q5wx6m8 = {
	name = "Qt5.15.3-Windows-x86_64-MinGW8.1.0",
	qtVersion = "5.15.3",
	host = "Win10",
	toolchain = "MinGW810-64",
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
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.Q5wx6m8sf = {
	name = "Qt5.15.3-Windows-x86_64-MinGW8.1.0-staticFull",
	qtVersion = "5.15.3",
	host = "Win10",
	toolchain = "MinGW810-64",
	variant = {"-staticFull"},
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
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.Q5mx6 = {
	name = "Qt5.15.3-macOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.15.3-5",
	host = "macOSLegacy",
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
		"make -j$PARALLELNUM"
		-rpath
		-webengine-proprietary-codecs
	]],
}

conf.Q5mx6nf = {
	name = "Qt5.15.3-macOS-x86_64-AppleClang&AppleClangVersion&-noFramework",
	qtVersion = "5.15.3-5",
	host = "macOSLegacy",
	variant = {"-noFramework"},
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
		"make -j$PARALLELNUM"
		-rpath
		-webengine-proprietary-codecs
		-no-framework
	]],
}

conf.Q5wx6m8_aalnl = {
	name = "Qt5.15.3-Android-ALL-Clang-NDKr21e-XWindows-x86_64-MinGW8.1.0",
	qtVersion = "5.15.3",
	host = "Win10",
	toolchain = "MinGW810-64",
	target = "Android-21",
	toolchainT = "Android-21-r21e-all",
	opensslConf = "o1aalnl",
	androidSdkVersion = "29",
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
		"mingw32-make -j%PARALLELNUM%"
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
	name = "Qt5.15.3-Android-ALL-Clang-NDKr21e-xLinux-x86_64-gcc8.5.0",
	qtVersion = "5.15.3",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21e-all",
	opensslConf = "o1aalnl",
	androidSdkVersion = "29",
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
		"make -j$PARALLELNUM"
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
	name = "Qt5.15.3-Android-ALL-Clang-NDKr21e-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.15.3",
	host = "macOSLegacy",
	target = "Android-21",
	toolchainT = "Android-21-r21e-all",
	opensslConf = "o1aalnl",
	androidSdkVersion = "29",
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
		"make -j$PARALLELNUM"
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
	name = "Qt5.15.3-WebAssembly-emscripten1.39.8-xWindows-x86_64-MinGW8.1.0",
	qtVersion = "5.15.3",
	host = "Win10",
	toolchain = "MinGW810-64",
	target = "WebAssembly",
	toolchainT = "emscripten-1.39.8",
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
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.Q5lx6_W = {
	name = "Qt5.15.3-WebAssembly-emscripten1.39.8-xLinux-x86_64-gcc8.5.0",
	qtVersion = "5.15.3",
	host = "CentOS8",
	target = "WebAssembly",
	toolchainT = "emscripten-1.39.8",
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
		"make -j$PARALLELNUM"
	]],
}

conf.Q5mx6_W = {
	name = "Qt5.15.3-WebAssembly-emscripten1.39.8-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.15.3",
	host = "macOSLegacy",
	target = "WebAssembly",
	toolchainT = "emscripten-1.39.8",
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
		"make -j$PARALLELNUM"
	]],
}

--------------------------------------------------------------------

conf.q5_kdewx3m8 = {
	name = "Qt5.15-KDE-Windows-x86-MinGW8.1.0",
	qtVersion = "5.15.k",
	host = "Win10",
	toolchain = "MinGW810-32",
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
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.q5_kdewx6m8 = {
	name = "Qt5.15-KDE-Windows-x86_64-MinGW8.1.0",
	qtVersion = "5.15.k",
	host = "Win10",
	toolchain = "MinGW810-64",
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
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.q5_kdewx3v9 = {
	name = "Qt5.15-KDE-Windows-x86-VS2019-&MSVCVER&",
	qtVersion = "5.15.k",
	host = "Win10",
	toolchain = "MSVC2019-32",
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
		-webengine-proprietary-codecs
	]],
}

conf.q5_kdewx6v9 = {
	name = "Qt5.15-KDE-Windows-x86_64-VS2019-&MSVCVER&",
	qtVersion = "5.15.k",
	host = "Win10",
	toolchain = "MSVC2019-64",
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
		-webengine-proprietary-codecs
	]],
}

conf.q5_kdewx6v2 = {
	name = "Qt5.15-KDE-Windows-x86_64-VS2022-&MSVCVER&",
	qtVersion = "5.15.k",
	host = "Win10",
	toolchain = "MSVC2022-64",
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
		-webengine-proprietary-codecs
	]],
}

conf.q5_kdemx6 = {
	name = "Qt5.15-KDE-macOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.15.k",
	host = "macOS1015",
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
		"make -j$PARALLELNUM"
		-rpath
		-webengine-proprietary-codecs
	]],
}

conf.q5_kdemx6nf = {
	name = "Qt5.15-KDE-macOS-x86_64-AppleClang&AppleClangVersion&-noFramework",
	qtVersion = "5.15.k",
	host = "macOS1015",
	variant = {"-noFramework"},
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
		"make -j$PARALLELNUM"
		-rpath
		-webengine-proprietary-codecs
		-no-framework
	]],
}

conf.q5_kdewx6m8_aalnl = {
	name = "Qt5.15-KDE-Android-ALL-Clang-NDKr21e-XWindows-x86_64-MinGW8.1.0",
	qtVersion = "5.15.k",
	host = "Win10",
	toolchain = "MinGW810-64",
	target = "Android-21",
	toolchainT = "Android-21-r21e-all",
	opensslConf = "o1aalnl",
	androidSdkVersion = "29",
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
		"mingw32-make -j%PARALLELNUM%"
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

conf.q5_kdelx6_aalnl = {
	name = "Qt5.15-KDE-Android-ALL-Clang-NDKr21e-xLinux-x86_64-gcc8.5.0",
	qtVersion = "5.15.k",
	host = "CentOS8",
	target = "Android-21",
	toolchainT = "Android-21-r21e-all",
	opensslConf = "o1aalnl",
	androidSdkVersion = "29",
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
		"make -j$PARALLELNUM"
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

conf.q5_kdemx6_aalnl = {
	name = "Qt5.15-KDE-Android-ALL-Clang-NDKr21e-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "5.15.k",
	host = "macOS1015",
	target = "Android-21",
	toolchainT = "Android-21-r21e-all",
	opensslConf = "o1aalnl",
	androidSdkVersion = "29",
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
		"make -j$PARALLELNUM"
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

--------------------------------------------------------------------

conf.q6_2wx6v9 = {
	name = "Qt6.2.3-Windows-x86_64-VS2019-&MSVCVER&",
	qtVersion = "6.2.3",
	host = "Win10",
	toolchain = "MSVC2019-64",
	opensslConf = "o3wx6v9",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-msvc
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_webengine_proprietary_codecs=ON
		-DFEATURE_qtpdf_build=ON
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6v9st = {
	name = "Qt6.2.3-Windows-x86_64-VS2019-&MSVCVER&-static",
	qtVersion = "6.2.3",
	host = "Win10",
	toolchain = "MSVC2019-64",
	variant = {"-static"},
	opensslConf = "o3wx6v9st",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-msvc
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DOPENSSL_USE_STATIC_LIBS=TRUE
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qt3d=OFF
		-DBUILD_qt5compat=OFF
		-DBUILD_qtcharts=OFF
		-DBUILD_qtcoap=OFF
		-DBUILD_qtconnectivity=OFF
		-DBUILD_qtdatavis3d=OFF
		-DBUILD_qtdoc=OFF
		-DBUILD_qtpositioning=OFF
		-DBUILD_qtlottie=OFF
		-DBUILD_qtmqtt=OFF
		-DBUILD_qtnetworkauth=OFF
		-DBUILD_qtopcua=OFF
		-DBUILD_qtquicktimeline=OFF
		-DBUILD_qtsensors=OFF
		-DBUILD_qtserialbus=OFF
		-DBUILD_qtserialport=OFF
		-DBUILD_qtvirtualkeyboard=OFF
		-DBUILD_qtwayland=OFF
		-DBUILD_qtwebchannel=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtwebsockets=OFF
		-DBUILD_qtwebview=OFF
	]],
}

conf.q6_2wx6v9sf = {
	name = "Qt6.2.3-Windows-x86_64-VS2019-&MSVCVER&-staticFull",
	qtVersion = "6.2.3",
	host = "Win10",
	toolchain = "MSVC2019-64",
	variant = {"-staticFull"},
	opensslConf = "o3wx6v9st",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-msvc
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DOPENSSL_USE_STATIC_LIBS=TRUE
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6v9_wa6v9 = {
	name = "Qt6.2.3-Windows-arm64-VS2019-&MSVCVER&-XWindows-x86_64-VS2019-&MSVCVER&",
	qtVersion = "6.2.3",
	host = "Win10",
	target = "Win10Arm",
	toolchain = "MSVC2019-64", -- only a placeholder here, in fact it uses "toolchainT" instead of "toolchain"
	toolchainT = "MSVC2019-arm64",
	-- opensslConf = "???", -- OpenSSL do not provide a way to build for windows-arm64
	useCMake = "Latest",
	-- TODO: Toolchain file or just write the CMAKE_xxx_COMPILER here?
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-arm64-msvc
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
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
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6v2 = {
	name = "Qt6.2.3-Windows-x86_64-VS2022-&MSVCVER&",
	qtVersion = "6.2.3",
	host = "Win10",
	toolchain = "MSVC2022-64",
	opensslConf = "o3wx6v2",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-msvc
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_webengine_proprietary_codecs=ON
		-DFEATURE_qtpdf_build=ON
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6m1 = {
	name = "Qt6.2.3-Windows-x86_64-MinGW11.2.0",
	qtVersion = "6.2.3",
	host = "Win10",
	toolchain = "MinGW1120-64",
	opensslConf = "o3wx6m1",
	useCMake = "20",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-g++
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6m1st = {
	name = "Qt6.2.3-Windows-x86_64-MinGW11.2.0-static",
	qtVersion = "6.2.3",
	host = "Win10",
	toolchain = "MinGW1120-64",
	variant = {"-static"},
	opensslConf = "o3wx6m1",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-g++
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_relocatable=ON
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DOPENSSL_USE_STATIC_LIBS=TRUE
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qt3d=OFF
		-DBUILD_qt5compat=OFF
		-DBUILD_qtcharts=OFF
		-DBUILD_qtcoap=OFF
		-DBUILD_qtconnectivity=OFF
		-DBUILD_qtdatavis3d=OFF
		-DBUILD_qtdoc=OFF
		-DBUILD_qtpositioning=OFF
		-DBUILD_qtlottie=OFF
		-DBUILD_qtmqtt=OFF
		-DBUILD_qtnetworkauth=OFF
		-DBUILD_qtopcua=OFF
		-DBUILD_qtquicktimeline=OFF
		-DBUILD_qtsensors=OFF
		-DBUILD_qtserialbus=OFF
		-DBUILD_qtserialport=OFF
		-DBUILD_qtvirtualkeyboard=OFF
		-DBUILD_qtwayland=OFF
		-DBUILD_qtwebchannel=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtwebsockets=OFF
		-DBUILD_qtwebview=OFF
	]],
}

conf.q6_2wx6m1sf = {
	name = "Qt6.2.3-Windows-x86_64-MinGW11.2.0-staticFull",
	qtVersion = "6.2.3",
	host = "Win10",
	toolchain = "MinGW1120-64",
	variant = {"-staticFull"},
	opensslConf = "o3wx6m1",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-g++
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_relocatable=ON
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DOPENSSL_USE_STATIC_LIBS=TRUE
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6mu = {
	name = "Qt6.2.3-Windows-x86_64-MinGWLLVM-ucrt13",
	qtVersion = "6.2.3",
	host = "Win10",
	toolchain = "MinGWLLVM-ucrt13-64",
	opensslConf = "o3wx6mu",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-clang-g++
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_wmf=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtopcua=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_2wx6mv = {
	name = "Qt6.2.3-Windows-x86_64-MinGWLLVM-msvcrt13",
	qtVersion = "6.2.3",
	host = "Win10",
	toolchain = "MinGWLLVM-msvcrt13-64",
	opensslConf = "o3wx6mv",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-clang-g++
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_wmf=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtopcua=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_2lx6st = {
	name = "Qt6.2.3-Linux-x86_64-gcc8.5.0-static",
	qtVersion = "6.2.3",
	host = "CentOS8",
	variant = {"-static"},
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=linux-g++
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_relocatable=ON
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DINPUT_opengl=no
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qt3d=OFF
		-DBUILD_qt5compat=OFF
		-DBUILD_qtcharts=OFF
		-DBUILD_qtcoap=OFF
		-DBUILD_qtconnectivity=OFF
		-DBUILD_qtdatavis3d=OFF
		-DBUILD_qtdoc=OFF
		-DBUILD_qtpositioning=OFF
		-DBUILD_qtlottie=OFF
		-DBUILD_qtmqtt=OFF
		-DBUILD_qtnetworkauth=OFF
		-DBUILD_qtopcua=OFF
		-DBUILD_qtquicktimeline=OFF
		-DBUILD_qtsensors=OFF
		-DBUILD_qtserialbus=OFF
		-DBUILD_qtserialport=OFF
		-DBUILD_qtvirtualkeyboard=OFF
		-DBUILD_qtwayland=OFF
		-DBUILD_qtwebchannel=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtwebsockets=OFF
		-DBUILD_qtwebview=OFF
	]],
}

conf.q6_2mx6 = {
	name = "Qt6.2.3-macOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "6.2.3",
	host = "macOS1015",
	opensslConf = "o3mx6",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=macx-clang
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl=ON
		-DFEATURE_opengles2=OFF
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_webengine_proprietary_codecs=ON
		-DFEATURE_qtpdf_build=ON
		-DCMAKE_SKIP_BUILD_RPATH=OFF
		-DCMAKE_SKIP_INSTALL_RPATH=OFF
		-DFEATURE_framework=ON
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2mx6nf = {
	name = "Qt6.2.3-macOS-x86_64-AppleClang&AppleClangVersion&-noFramework",
	qtVersion = "6.2.3",
	host = "macOS1015",
	variant = {"-noFramework"},
	opensslConf = "o3mx6",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=macx-clang
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl=ON
		-DFEATURE_opengles2=OFF
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_webengine_proprietary_codecs=ON
		-DFEATURE_qtpdf_build=ON
		-DCMAKE_SKIP_BUILD_RPATH=OFF
		-DCMAKE_SKIP_INSTALL_RPATH=OFF
		-DFEATURE_framework=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2mx6st = {
	name = "Qt6.2.3-macOS-x86_64-AppleClang&AppleClangVersion&-static",
	qtVersion = "6.2.3",
	host = "macOS1015",
	variant = {"-static"},
	opensslConf = "o3mx6",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=macx-clang
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_relocatable=ON
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl=ON
		-DFEATURE_opengles2=OFF
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DOPENSSL_USE_STATIC_LIBS=TRUE
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qt3d=OFF
		-DBUILD_qt5compat=OFF
		-DBUILD_qtcharts=OFF
		-DBUILD_qtcoap=OFF
		-DBUILD_qtconnectivity=OFF
		-DBUILD_qtdatavis3d=OFF
		-DBUILD_qtdoc=OFF
		-DBUILD_qtpositioning=OFF
		-DBUILD_qtlottie=OFF
		-DBUILD_qtmqtt=OFF
		-DBUILD_qtnetworkauth=OFF
		-DBUILD_qtopcua=OFF
		-DBUILD_qtquicktimeline=OFF
		-DBUILD_qtsensors=OFF
		-DBUILD_qtserialbus=OFF
		-DBUILD_qtserialport=OFF
		-DBUILD_qtvirtualkeyboard=OFF
		-DBUILD_qtwayland=OFF
		-DBUILD_qtwebchannel=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtwebsockets=OFF
		-DBUILD_qtwebview=OFF
	]],
}

conf.q6_2mx6sf = {
	name = "Qt6.2.3-macOS-x86_64-AppleClang&AppleClangVersion&-staticFull",
	qtVersion = "6.2.3",
	host = "macOS1015",
	variant = {"-staticFull"},
	opensslConf = "o3mx6",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=macx-clang
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_relocatable=ON
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl=ON
		-DFEATURE_opengles2=OFF
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DOPENSSL_USE_STATIC_LIBS=TRUE
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2ma6 = {
	name = "Qt6.2.3-macOS-arm64_v8a-AppleClang&AppleClangVersion&",
	qtVersion = "6.2.3",
	host = "macOSM1",
	opensslConf = "o3ma6",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=macx-clang
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl=ON
		-DFEATURE_opengles2=OFF
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_webengine_proprietary_codecs=ON
		-DFEATURE_qtpdf_build=ON
		-DCMAKE_SKIP_BUILD_RPATH=OFF
		-DCMAKE_SKIP_INSTALL_RPATH=OFF
		-DFEATURE_framework=ON
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2ma6nf = {
	name = "Qt6.2.3-macOS-arm64_v8a-AppleClang&AppleClangVersion&-noFramework",
	qtVersion = "6.2.3",
	host = "macOSM1",
	variant = {"-noFramework"},
	opensslConf = "o3ma6",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=macx-clang
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl=ON
		-DFEATURE_opengles2=OFF
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_webengine_proprietary_codecs=ON
		-DFEATURE_qtpdf_build=ON
		-DCMAKE_SKIP_BUILD_RPATH=OFF
		-DCMAKE_SKIP_INSTALL_RPATH=OFF
		-DFEATURE_framework=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2ma6sf = {
	name = "Qt6.2.3-macOS-arm64_v8a-AppleClang&AppleClangVersion&-staticFull",
	qtVersion = "6.2.3",
	host = "macOSM1",
	variant = {"-staticFull"},
	opensslConf = "o3ma6",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=macx-clang
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_relocatable=ON
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl=ON
		-DFEATURE_opengles2=OFF
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DOPENSSL_USE_STATIC_LIBS=TRUE
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6m1_aa3n3 = {
	name = "Qt6.2.3-Android-arm-Clang-NDKr23b-XWindows-x86_64-MinGW11.2.0",
	qtVersion = "6.2.3",
	host = "Win10",
	target = "Android-24",
	toolchain = "MinGW1120-64",
	toolchainT = "Android-24-r23b-arm",
	opensslConf = "o3aa3n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=armeabi-v7a
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_2wx6m1_aa6n3 = {
	name = "Qt6.2.3-Android-arm64-Clang-NDKr23b-XWindows-x86_64-MinGW11.2.0",
	qtVersion = "6.2.3",
	host = "Win10",
	target = "Android-24",
	toolchain = "MinGW1120-64",
	toolchainT = "Android-24-r23b-arm64",
	opensslConf = "o3aa6n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=arm64-v8a
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_2wx6m1_ax3n3 = {
	name = "Qt6.2.3-Android-x86-Clang-NDKr23b-XWindows-x86_64-MinGW11.2.0",
	qtVersion = "6.2.3",
	host = "Win10",
	target = "Android-24",
	toolchain = "MinGW1120-64",
	toolchainT = "Android-24-r23b-x86",
	opensslConf = "o3ax3n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_2wx6m1_ax6n3 = {
	name = "Qt6.2.3-Android-x86_64-Clang-NDKr23b-XWindows-x86_64-MinGW11.2.0",
	qtVersion = "6.2.3",
	host = "Win10",
	target = "Android-24",
	toolchain = "MinGW1120-64",
	toolchainT = "Android-24-r23b-x86_64",
	opensslConf = "o3ax6n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86_64
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_2lx6_aa3n3 = {
	name = "Qt6.2.3-Android-arm-Clang-NDKr23b-xLinux-x86_64-gcc8.5.0",
	qtVersion = "6.2.3",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23b-arm",
	opensslConf = "o3aa3n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&/
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=armeabi-v7a
	]],
}

conf.q6_2lx6_aa6n3 = {
	name = "Qt6.2.3-Android-arm64-Clang-NDKr23b-xLinux-x86_64-gcc8.5.0",
	qtVersion = "6.2.3",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23b-arm64",
	opensslConf = "o3aa6n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&/
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=arm64-v8a
	]],
}

conf.q6_2lx6_ax3n3 = {
	name = "Qt6.2.3-Android-x86-Clang-NDKr23b-xLinux-x86_64-gcc8.5.0",
	qtVersion = "6.2.3",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23b-x86",
	opensslConf = "o3ax3n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&/
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86
	]],
}

conf.q6_2lx6_ax6n3 = {
	name = "Qt6.2.3-Android-x86_64-Clang-NDKr23b-xLinux-x86_64-gcc8.5.0",
	qtVersion = "6.2.3",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23b-x86_64",
	opensslConf = "o3ax6n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&/
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86_64
	]],
}

conf.q6_2mx6_aa3n3 = {
	name = "Qt6.2.3-Android-arm-Clang-NDKr23b-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "6.2.3",
	host = "macOS1015",
	target = "Android-24",
	toolchainT = "Android-24-r23b-arm",
	opensslConf = "o3aa3n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&/
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=armeabi-v7a
	]],
}

conf.q6_2mx6_aa6n3 = {
	name = "Qt6.2.3-Android-arm64-Clang-NDKr23b-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "6.2.3",
	host = "macOS1015",
	target = "Android-24",
	toolchainT = "Android-24-r23b-arm64",
	opensslConf = "o3aa6n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&/
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=arm64-v8a
	]],
}

conf.q6_2mx6_ax3n3 = {
	name = "Qt6.2.3-Android-x86-Clang-NDKr23b-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "6.2.3",
	host = "macOS1015",
	target = "Android-24",
	toolchainT = "Android-24-r23b-x86",
	opensslConf = "o3ax3n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&/
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86
	]],
}

conf.q6_2mx6_ax6n3 = {
	name = "Qt6.2.3-Android-x86_64-Clang-NDKr23b-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "6.2.3",
	host = "macOS1015",
	target = "Android-24",
	toolchainT = "Android-24-r23b-x86_64",
	opensslConf = "o3ax6n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&/
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86_64
	]],
}

-- WebAssembly uses emcmake which don't need a toolchain file
conf.q6_2wx6m1_W = {
	name = "Qt6.2.3-WebAssembly-emscripten2.0.14-xWindows-x86_64-MinGW11.2.0",
	qtVersion = "6.2.3",
	host = "Win10",
	toolchain = "MinGW1120-64",
	target = "WebAssembly",
	toolchainT = "emscripten-2.0.14",
	useCMake = "Latest",
	-- workaround https://github.com/emscripten-core/emscripten/issues/15163
	configureParameter = [[
		-G
		Ninja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DQT_QMAKE_TARGET_MKSPEC=wasm-emscripten
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DBUILD_WITH_PCH=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=OFF
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2lx6_W = {
	name = "Qt6.2.3-WebAssembly-emscripten2.0.14-xLinux-x86_64-gcc8.5.0",
	qtVersion = "6.2.3",
	host = "CentOS8",
	target = "WebAssembly",
	toolchainT = "emscripten-2.0.14",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DQT_QMAKE_TARGET_MKSPEC=wasm-emscripten
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DBUILD_WITH_PCH=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=OFF
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2mx6_W = {
	name = "Qt6.2.3-WebAssembly-emscripten2.0.14-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "6.2.3",
	host = "macOS1015",
	target = "WebAssembly",
	toolchainT = "emscripten-2.0.14",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DQT_QMAKE_TARGET_MKSPEC=wasm-emscripten
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DBUILD_WITH_PCH=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=OFF
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
	]],
}

--------------------------------------------------------------------

conf.q6_3wx6v2 = {
	name = "Qt6.3.0-beta2-Windows-x86_64-VS2022-&MSVCVER&",
	qtVersion = "6.3.0-beta2",
	host = "Win10",
	toolchain = "MSVC2022-64",
	opensslConf = "o3wx6v2",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-msvc
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_webengine_proprietary_codecs=ON
		-DFEATURE_qtpdf_build=ON
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_3wx6v2st = {
	name = "Qt6.3.0-beta2-Windows-x86_64-VS2022-&MSVCVER&-static",
	qtVersion = "6.3.0-beta2",
	host = "Win10",
	toolchain = "MSVC2022-64",
	variant = {"-static"},
	opensslConf = "o3wx6v2st",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-msvc
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DOPENSSL_USE_STATIC_LIBS=TRUE
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qt3d=OFF
		-DBUILD_qt5compat=OFF
		-DBUILD_qtcharts=OFF
		-DBUILD_qtcoap=OFF
		-DBUILD_qtconnectivity=OFF
		-DBUILD_qtdatavis3d=OFF
		-DBUILD_qtdoc=OFF
		-DBUILD_qtpositioning=OFF
		-DBUILD_qtlottie=OFF
		-DBUILD_qtmqtt=OFF
		-DBUILD_qtnetworkauth=OFF
		-DBUILD_qtopcua=OFF
		-DBUILD_qtquicktimeline=OFF
		-DBUILD_qtsensors=OFF
		-DBUILD_qtserialbus=OFF
		-DBUILD_qtserialport=OFF
		-DBUILD_qtvirtualkeyboard=OFF
		-DBUILD_qtwayland=OFF
		-DBUILD_qtwebchannel=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtwebsockets=OFF
		-DBUILD_qtwebview=OFF
	]],
}

conf.q6_3wx6v2_wa6v2 = {
	name = "Qt6.3.0-beta2-Windows-arm64-VS2022-&MSVCVER&-XWindows-x86_64-VS2022-&MSVCVER&",
	qtVersion = "6.3.0-beta2",
	host = "Win10",
	target = "Win10Arm",
	toolchain = "MSVC2022-64", -- only a placeholder here, in fact it uses "toolchainT" instead of "toolchain"
	toolchainT = "MSVC2022-arm64",
	-- opensslConf = "???", -- OpenSSL do not provide a way to build for windows-arm64
	useCMake = "Latest",
	-- TODO: Toolchain file or just write the CMAKE_xxx_COMPILER here?
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-arm64-msvc
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
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
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_3wx6m1 = {
	name = "Qt6.3.0-beta2-Windows-x86_64-MinGW11.2.0",
	qtVersion = "6.3.0-beta2",
	host = "Win10",
	toolchain = "MinGW1120-64",
	opensslConf = "o3wx6m1",
	useCMake = "20",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-g++
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_3wx6m1st = {
	name = "Qt6.3.0-beta2-Windows-x86_64-MinGW11.2.0-static",
	qtVersion = "6.3.0-beta2",
	host = "Win10",
	toolchain = "MinGW1120-64",
	variant = {"-static"},
	opensslConf = "o3wx6m1",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-g++
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_relocatable=ON
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DOPENSSL_USE_STATIC_LIBS=TRUE
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qt3d=OFF
		-DBUILD_qt5compat=OFF
		-DBUILD_qtcharts=OFF
		-DBUILD_qtcoap=OFF
		-DBUILD_qtconnectivity=OFF
		-DBUILD_qtdatavis3d=OFF
		-DBUILD_qtdoc=OFF
		-DBUILD_qtpositioning=OFF
		-DBUILD_qtlottie=OFF
		-DBUILD_qtmqtt=OFF
		-DBUILD_qtnetworkauth=OFF
		-DBUILD_qtopcua=OFF
		-DBUILD_qtquicktimeline=OFF
		-DBUILD_qtsensors=OFF
		-DBUILD_qtserialbus=OFF
		-DBUILD_qtserialport=OFF
		-DBUILD_qtvirtualkeyboard=OFF
		-DBUILD_qtwayland=OFF
		-DBUILD_qtwebchannel=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtwebsockets=OFF
		-DBUILD_qtwebview=OFF
	]],
}

conf.q6_3wx6mu = {
	name = "Qt6.3.0-beta2-Windows-x86_64-MinGWLLVM-ucrt13",
	qtVersion = "6.3.0-beta2",
	host = "Win10",
	toolchain = "MinGWLLVM-ucrt13-64",
	opensslConf = "o3wx6mu",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-clang-g++
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_wmf=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtopcua=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_3wx6mv = {
	name = "Qt6.3.0-beta2-Windows-x86_64-MinGWLLVM-msvcrt13",
	qtVersion = "6.3.0-beta2",
	host = "Win10",
	toolchain = "MinGWLLVM-msvcrt13-64",
	opensslConf = "o3wx6mv",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=win32-clang-g++
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl_dynamic=ON
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_wmf=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtopcua=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_3lx6st = {
	name = "Qt6.3.0-beta2-Linux-x86_64-gcc8.5.0-static",
	qtVersion = "6.3.0-beta2",
	host = "CentOS8",
	variant = {"-static"},
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=linux-g++
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_relocatable=ON
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DINPUT_opengl=no
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qt3d=OFF
		-DBUILD_qt5compat=OFF
		-DBUILD_qtcharts=OFF
		-DBUILD_qtcoap=OFF
		-DBUILD_qtconnectivity=OFF
		-DBUILD_qtdatavis3d=OFF
		-DBUILD_qtdoc=OFF
		-DBUILD_qtpositioning=OFF
		-DBUILD_qtlottie=OFF
		-DBUILD_qtmqtt=OFF
		-DBUILD_qtnetworkauth=OFF
		-DBUILD_qtopcua=OFF
		-DBUILD_qtquicktimeline=OFF
		-DBUILD_qtsensors=OFF
		-DBUILD_qtserialbus=OFF
		-DBUILD_qtserialport=OFF
		-DBUILD_qtvirtualkeyboard=OFF
		-DBUILD_qtwayland=OFF
		-DBUILD_qtwebchannel=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtwebsockets=OFF
		-DBUILD_qtwebview=OFF
	]],
}

conf.q6_3mx6 = {
	name = "Qt6.3.0-beta2-macOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "6.3.0-beta2",
	host = "macOS1015",
	opensslConf = "o3mx6",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=macx-clang
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl=ON
		-DFEATURE_opengles2=OFF
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_webengine_proprietary_codecs=ON
		-DFEATURE_qtpdf_build=ON
		-DCMAKE_SKIP_BUILD_RPATH=OFF
		-DCMAKE_SKIP_INSTALL_RPATH=OFF
		-DFEATURE_framework=ON
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_3mx6nf = {
	name = "Qt6.3.0-beta2-macOS-x86_64-AppleClang&AppleClangVersion&-noFramework",
	qtVersion = "6.3.0-beta2",
	host = "macOS1015",
	variant = {"-noFramework"},
	opensslConf = "o3mx6",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=macx-clang
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl=ON
		-DFEATURE_opengles2=OFF
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_webengine_proprietary_codecs=ON
		-DFEATURE_qtpdf_build=ON
		-DCMAKE_SKIP_BUILD_RPATH=OFF
		-DCMAKE_SKIP_INSTALL_RPATH=OFF
		-DFEATURE_framework=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_3mx6st = {
	name = "Qt6.3.0-beta2-macOS-x86_64-AppleClang&AppleClangVersion&-static",
	qtVersion = "6.3.0-beta2",
	host = "macOS1015",
	variant = {"-static"},
	opensslConf = "o3mx6",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=macx-clang
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_relocatable=ON
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl=ON
		-DFEATURE_opengles2=OFF
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DOPENSSL_USE_STATIC_LIBS=TRUE
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qt3d=OFF
		-DBUILD_qt5compat=OFF
		-DBUILD_qtcharts=OFF
		-DBUILD_qtcoap=OFF
		-DBUILD_qtconnectivity=OFF
		-DBUILD_qtdatavis3d=OFF
		-DBUILD_qtdoc=OFF
		-DBUILD_qtpositioning=OFF
		-DBUILD_qtlottie=OFF
		-DBUILD_qtmqtt=OFF
		-DBUILD_qtnetworkauth=OFF
		-DBUILD_qtopcua=OFF
		-DBUILD_qtquicktimeline=OFF
		-DBUILD_qtsensors=OFF
		-DBUILD_qtserialbus=OFF
		-DBUILD_qtserialport=OFF
		-DBUILD_qtvirtualkeyboard=OFF
		-DBUILD_qtwayland=OFF
		-DBUILD_qtwebchannel=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtwebsockets=OFF
		-DBUILD_qtwebview=OFF
	]],
}

conf.q6_3ma6 = {
	name = "Qt6.3.0-beta2-macOS-arm64_v8a-AppleClang&AppleClangVersion&",
	qtVersion = "6.3.0-beta2",
	host = "macOSM1",
	opensslConf = "o3ma6",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=macx-clang
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl=ON
		-DFEATURE_opengles2=OFF
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_webengine_proprietary_codecs=ON
		-DFEATURE_qtpdf_build=ON
		-DCMAKE_SKIP_BUILD_RPATH=OFF
		-DCMAKE_SKIP_INSTALL_RPATH=OFF
		-DFEATURE_framework=ON
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_3ma6nf = {
	name = "Qt6.3.0-beta2-macOS-arm64_v8a-AppleClang&AppleClangVersion&-noFramework",
	qtVersion = "6.3.0-beta2",
	host = "macOSM1",
	variant = {"-noFramework"},
	opensslConf = "o3ma6",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=macx-clang
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl=ON
		-DFEATURE_opengles2=OFF
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_webengine_proprietary_codecs=ON
		-DFEATURE_qtpdf_build=ON
		-DCMAKE_SKIP_BUILD_RPATH=OFF
		-DCMAKE_SKIP_INSTALL_RPATH=OFF
		-DFEATURE_framework=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_3ma6st = {
	name = "Qt6.3.0-beta2-macOS-arm64_v8a-AppleClang&AppleClangVersion&-static",
	qtVersion = "6.3.0-beta2",
	host = "macOSM1",
	variant = {"-static"},
	opensslConf = "o3ma6",
	useCMake = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE="Release"
		-DQT_QMAKE_TARGET_MKSPEC=macx-clang
		-DBUILD_WITH_PCH=ON
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_relocatable=ON
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengl=ON
		-DFEATURE_opengles2=OFF
		-DFEATURE_ssl=ON
		-DFEATURE_openssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DOPENSSL_USE_STATIC_LIBS=TRUE
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qt3d=OFF
		-DBUILD_qt5compat=OFF
		-DBUILD_qtcharts=OFF
		-DBUILD_qtcoap=OFF
		-DBUILD_qtconnectivity=OFF
		-DBUILD_qtdatavis3d=OFF
		-DBUILD_qtdoc=OFF
		-DBUILD_qtpositioning=OFF
		-DBUILD_qtlottie=OFF
		-DBUILD_qtmqtt=OFF
		-DBUILD_qtnetworkauth=OFF
		-DBUILD_qtopcua=OFF
		-DBUILD_qtquicktimeline=OFF
		-DBUILD_qtsensors=OFF
		-DBUILD_qtserialbus=OFF
		-DBUILD_qtserialport=OFF
		-DBUILD_qtvirtualkeyboard=OFF
		-DBUILD_qtwayland=OFF
		-DBUILD_qtwebchannel=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtwebsockets=OFF
		-DBUILD_qtwebview=OFF
	]],
}

conf.q6_3wx6m1_aa6n3 = {
	name = "Qt6.3.0-beta2-Android-arm64-Clang-NDKr23b-XWindows-x86_64-MinGW11.2.0",
	qtVersion = "6.3.0-beta2",
	host = "Win10",
	target = "Android-24",
	toolchain = "MinGW1120-64",
	toolchainT = "Android-24-r23b-arm64",
	opensslConf = "o3aa6n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=arm64-v8a
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_3wx6m1_ax6n3 = {
	name = "Qt6.3.0-beta2-Android-x86_64-Clang-NDKr23b-XWindows-x86_64-MinGW11.2.0",
	qtVersion = "6.3.0-beta2",
	host = "Win10",
	target = "Android-24",
	toolchain = "MinGW1120-64",
	toolchainT = "Android-24-r23b-x86_64",
	opensslConf = "o3ax6n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86_64
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_3lx6_aa6n3 = {
	name = "Qt6.3.0-beta2-Android-arm64-Clang-NDKr23b-xLinux-x86_64-gcc8.5.0",
	qtVersion = "6.3.0-beta2",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23b-arm64",
	opensslConf = "o3aa6n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&/
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=arm64-v8a
	]],
}

conf.q6_3lx6_ax6n3 = {
	name = "Qt6.3.0-beta2-Android-x86_64-Clang-NDKr23b-xLinux-x86_64-gcc8.5.0",
	qtVersion = "6.3.0-beta2",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23b-x86_64",
	opensslConf = "o3ax6n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&/
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86_64
	]],
}

conf.q6_3mx6_aa6n3 = {
	name = "Qt6.3.0-beta2-Android-arm64-Clang-NDKr23b-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "6.3.0-beta2",
	host = "macOS1015",
	target = "Android-24",
	toolchainT = "Android-24-r23b-arm64",
	opensslConf = "o3aa6n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&/
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=arm64-v8a
	]],
}

conf.q6_3mx6_ax6n3 = {
	name = "Qt6.3.0-beta2-Android-x86_64-Clang-NDKr23b-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "6.3.0-beta2",
	host = "macOS1015",
	target = "Android-24",
	toolchainT = "Android-24-r23b-x86_64",
	opensslConf = "o3ax6n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&/
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86_64
	]],
}

conf.q6_3ma6_aa6n3 = {
	name = "Qt6.3.0-beta2-Android-arm64-Clang-NDKr23b-xmacOS-arm64_v8a-AppleClang&AppleClangVersion&",
	qtVersion = "6.3.0-beta2",
	host = "macOSM1",
	target = "Android-24",
	toolchainT = "Android-24-r23b-arm64",
	opensslConf = "o3aa6n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&/
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=arm64-v8a
	]],
}

conf.q6_3ma6_ax6n3 = {
	name = "Qt6.3.0-beta2-Android-x86_64-Clang-NDKr23b-xmacOS-arm64_v8a-AppleClang&AppleClangVersion&",
	qtVersion = "6.3.0-beta2",
	host = "macOSM1",
	target = "Android-24",
	toolchainT = "Android-24-r23b-x86_64",
	opensslConf = "o3ax6n324",
	useCMake = "Latest",
	androidSdkVersion = "Latest",
	configureParameter = [[
		-G"Ninja"
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=ON
		-DQT_QMAKE_TARGET_MKSPEC=android-clang
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=ON
		-DINPUT_openssl=linked
		-DOPENSSL_ROOT_DIR=&OPENSSLDIR&/
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT=&ANDROIDSDKROOT&
		-DCMAKE_TOOLCHAIN_FILE=&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86_64
	]],
}

-- WebAssembly uses emcmake which don't need a toolchain file
conf.q6_3wx6m1_W = {
	name = "Qt6.3.0-beta2-WebAssembly-emscripten3.0.0-xWindows-x86_64-MinGW11.2.0",
	qtVersion = "6.3.0-beta2",
	host = "Win10",
	toolchain = "MinGW1120-64",
	target = "WebAssembly",
	toolchainT = "emscripten-3.0.0",
	useCMake = "Latest",
	-- workaround https://github.com/emscripten-core/emscripten/issues/15163
	configureParameter = [[
		-G
		Ninja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DQT_QMAKE_TARGET_MKSPEC=wasm-emscripten
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DBUILD_WITH_PCH=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=OFF
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_3lx6_W = {
	name = "Qt6.3.0-beta2-WebAssembly-emscripten3.0.0-xLinux-x86_64-gcc8.5.0",
	qtVersion = "6.3.0-beta2",
	host = "CentOS8",
	target = "WebAssembly",
	toolchainT = "emscripten-3.0.0",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DQT_QMAKE_TARGET_MKSPEC=wasm-emscripten
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DBUILD_WITH_PCH=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=OFF
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_3mx6_W = {
	name = "Qt6.3.0-beta2-WebAssembly-emscripten3.0.0-xmacOS-x86_64-AppleClang&AppleClangVersion&",
	qtVersion = "6.3.0-beta2",
	host = "macOS1015",
	target = "WebAssembly",
	toolchainT = "emscripten-3.0.0",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DQT_QMAKE_TARGET_MKSPEC=wasm-emscripten
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DBUILD_WITH_PCH=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=OFF
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_3ma6_W = {
	name = "Qt6.3.0-beta2-WebAssembly-emscripten3.0.0-xmacOS-arm64_v8a-AppleClang&AppleClangVersion&",
	qtVersion = "6.3.0-beta2",
	host = "macOS1015",
	target = "WebAssembly",
	toolchainT = "emscripten-3.0.0",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DQT_HOST_PATH=&HOSTQTDIR&
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DQT_QMAKE_TARGET_MKSPEC=wasm-emscripten
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DBUILD_WITH_PCH=OFF
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=OFF
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
	]],
}

local versionMo = {
	__index = function(t, k)
		return t.default
	end
}

local QQtPatcherConf = {
	["Win10"] = "Q2wx3v7st",
	["Win8"] = "Q2wx3v5st",
	["CentOS8"] = "Q2lx6st",
	["macOSLegacy"] = "q5_12mLx6st",
}

local QQtPatcherVersion = {
	["default"] = "0.8.1"
}

setmetatable(QQtPatcherVersion, versionMo)

local MsvcVer = {
	["MSVC2015"] = "14",
	["MSVC2017"] = "15.9.44",
	["MSVC2019"] = "16.11.10",
	["MSVC2022"] = "17.1.0",
}

local AppleClangVersion = {
	["macOS1015"] = "13.0.0",
	["macOSM1"] = "13.0.0",
	["macOSLegacy"] = "12.0.5",
	["macOSLegacyLegacy"] = "12.0.0",
}

local Qt6StaticConf = {
	Win10 = {
		["6.2.3"] = "q6_2wx6m1st",
		["6.3.0-beta2"] = "q6_3wx6m1st",
	},
	Win10MSVC2019 = {
		["6.2.3"] = "q6_2wx6v9st",
	},
	Win10MSVC2022 = {
		["6.3.0-beta2"] = "q6_3wx6v2st",
	},
	CentOS8 = {
		["6.2.3"] = "q6_2lx6st",
		["6.3.0-beta2"] = "q6_3lx6st",
	},
	macOS1015 = {
		["6.2.3"] = "q6_2mx6st",
		["6.3.0-beta2"] = "q6_3mx6st",
	},
	macOSM1 = {
		["6.3.0-beta2"] = "q6_3ma6st",
	},
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

	if not value.toolchain then
		value.toolchain = "PATH"
	end

	-- hack MSVCVER into name
	if string.sub(value.toolchain, 1, 4) == "MSVC" then
		value.name = string.gsub(value.name, "%&MSVCVER%&", MsvcVer[string.sub(value.toolchain, 1, 8)])
	end
	if string.find(value.name, "AppleClang") then
		value.name = string.gsub(value.name, "%&AppleClangVersion%&", AppleClangVersion[value.host])
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

	local qtVersionSplit = split(value.qtVersion, ".")
	if value.qtVersion == "5.15.k" then
		value.sourcePackageBaseName = "qt5-kde"
	else
		local qtSourcePackagePrefix = "qt-everywhere-src-"
		if ((value.qtVersion == "5.15.3-5") or (value.qtVersion == "6.2.3") or (value.qtVersion == "6.3.0-beta2")) and (value.host == "Win10") then
			qtSourcePackagePrefix = "qt-src-"
		elseif (tonumber(qtVersionSplit[1]) == 5) and (tonumber(qtVersionSplit[2]) == 15) and (tonumber(qtVersionSplit[3]) >= 3) then
			qtSourcePackagePrefix = "qt-everywhere-opensource-src-"
		end
		value.sourcePackageBaseName = qtSourcePackagePrefix .. value.qtVersion
	end
	-- config file
	if tonumber(qtVersionSplit[1]) == 5 then
		value.configFile = { "config.log", "config.opt", "config.summary" }
		if string.sub(value.host, 1, 3) == "Win" then
			table.insert(value.configFile, "config.status.bat")
		else
			table.insert(value.configFile, "config.status")
		end
	elseif value.useCMake then
		value.configFile = { "CMakeCache.txt", "config.summary" }
	end

	if tonumber(qtVersionSplit[1]) > 5 or (tonumber(qtVersionSplit[1]) == 5 and tonumber(qtVersionSplit[2]) >= 14) then
		value.qQtPatcher = "no"
	else
		-- QQtPatcher
		local usingQQtPatcher = QQtPatcherConf[value.host]
		if usingQQtPatcher == name then
			value.qQtPatcher = "build"
			value.qQtPatcherSourceUrlwin = "http://172.24.13.6/webdav/sources/QQtPatcher-" .. QQtPatcherVersion[value.host] .. ".zip"
			value.qQtPatcherSourceUrlunix = "http://172.24.13.6/webdav/sources/QQtPatcher-" .. QQtPatcherVersion[value.host] .. ".tar.gz"
		else
			value.qQtPatcher = usingQQtPatcher
			value.qQtPatcherUrlwin = "http://172.24.13.6:8080/job/Qt/job/" .. value.qQtPatcher .. "/lastSuccessfulBuild/artifact/buildDir/QQtPatcher.exe"
			value.qQtPatcherUrlunix = "http://172.24.13.6:8080/job/Qt/job/" .. value.qQtPatcher .. "/lastSuccessfulBuild/artifact/buildDir/QQtPatcher"
		end
		value.qQtPatcherVersion = QQtPatcherVersion[value.host]
	end

	if tonumber(qtVersionSplit[1]) == 6 and value.crossCompile then
		-- cross build of MSVC target needs same version of MSVC host
		local valuehost = value.host
		if string.sub(value.toolchain, 1, 4) == "MSVC" then
			valuehost = value.host .. string.sub(value.toolchain, 1, 8)
		end
		value.hostToolsConf = Qt6StaticConf[valuehost][value.qtVersion]
		value.hostToolsUrlwin = "http://172.24.13.6:8080/job/Qt/job/" .. Qt6StaticConf[valuehost][value.qtVersion] .. "/lastSuccessfulBuild/artifact/buildDir/" .. conf[Qt6StaticConf[valuehost][value.qtVersion]].name .. ".7z"
		value.hostToolsUrlunix = "http://172.24.13.6:8080/job/Qt/job/" .. Qt6StaticConf[valuehost][value.qtVersion] .. "/lastSuccessfulBuild/artifact/buildDir/" .. conf[Qt6StaticConf[valuehost][value.qtVersion]].name .. ".tar.xz"
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
		if self.opensslConf then
			ret = ret .. "\tOpenSSL Configuration: " .. self.opensslConf .. "\n"
		end
		if self.qQtPatcher ~= "no" then
			ret = ret .. "\tUsing QQtPatcher config: " .. self.qQtPatcher .. ", version: " .. self.qQtPatcherVersion .. "\n"
		end
		if self.crossCompile and self.hostToolsConf then
			ret = ret .. "\tUsing Host Qt tools: " .. value.hostToolsConf .. "\n"
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
