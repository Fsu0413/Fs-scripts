
local conf = {}

--[[
abbrs:
	Qt Versions:
		q5_15: Qt 5.15.14/Previous Qt 5 LTS w/ latest QtWebEngine and latest QtScript
		q6_2: Qt 6.2.9/Previous Qt 6 LTS w/o QtWebEngine
		q6_5: Qt 6.5.3/Latest Qt 6 LTS
		q6_7: Qt 6.7.2
	If prefixed with a lower-case "m", it is a modified Qt version

	Platforms:
		w: Windows
		l: Linux
		m: macOS
		a: Android
		W: WebAssembly (w/o Architecture)
	Other platforms will be added when supported.
	Some platforms needs cross build, especially Android, WebAssembly and Windows on ARM64, we use an underscore to mark a cross built version.

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
		g8: MinGW-w64, with GCC 8.1.0
		g1: MinGW-w64, with GCC 11.2.0
		g2: MinGW-w64, msvcrt, with GCC 12.2.0
		p2: MinGW-w64, ucrt, with GCC 12.2.0
		g3: MinGW-w64, msvcrt, with GCC 13.2.0
		p3: MinGW-w64, ucrt, with GCC 13.2.0
		s6: LLVM/Clang based MinGW-w64, msvcrt, with LLVM 16
		u6: LLVM/Clang based MinGW-w64, ucrt, with LLVM 16
		s7: LLVM/Clang based MinGW-w64, msvcrt, with LLVM 17
		u7: LLVM/Clang based MinGW-w64, ucrt, with LLVM 17
		s8: LLVM/Clang based MinGW-w64, msvcrt, with LLVM 18
		u8: LLVM/Clang based MinGW-w64, ucrt, with LLVM 18
		nV21: Android NDK r21e/Previous LTS
		nV23: Android NDK r23c/Previous LTS
		nV25: Android NDK r25c/Previous LTS
		nV26: Android NDK r26d/Latest LTS
	If omitted, it use a toolchain in default PATH, which should be AppleClang in macOS, or GCC in Linux.

	Variants:
		st: Static
		sf: Static(full)
		nf: No-Framework(for macOS)
]]

--------------------------------------------------------------------

-- Qt 5.15.14

conf.q5_15wx3v5 = {
	name = "Qt5.15.14-Windows-x86-VS2015",
	qtVersion = "5.15.14",
	host = "Win8",
	toolchain = "MSVC2015-32",
	mysqlConf = "m3_1wx3v5",
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-make-tool
		jom
	]],
}

conf.q5_15wx3v5sf = {
	name = "Qt5.15.14-Windows-x86-VS2015-staticFull",
	qtVersion = "5.15.14",
	host = "Win8",
	toolchain = "MSVC2015-32",
	variant = {"-static(Full)"},
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

conf.q5_15wx6v5 = {
	name = "Qt5.15.14-Windows-x86_64-VS2015",
	qtVersion = "5.15.14",
	host = "Win8",
	toolchain = "MSVC2015-64",
	mysqlConf = "m3_1wx6v5",
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-make-tool
		jom
	]],
}

conf.q5_15wx6v5sf = {
	name = "Qt5.15.14-Windows-x86_64-VS2015-staticFull",
	qtVersion = "5.15.14",
	host = "Win8",
	toolchain = "MSVC2015-64",
	variant = {"-static(Full)"},
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

conf.q5_15wx3v7 = {
	name = "Qt5.15.14-Windows-x86-VS2017-&HOSTTOOLVERSION&",
	qtVersion = "5.15.14-3",
	host = "Win10",
	toolchain = "MSVC2017-32",
	mysqlConf = "m3_1wx3v7",
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-make-tool
		jom
		-skip
		qtwebengine
	]],
}

conf.q5_15wx3v7sf = {
	name = "Qt5.15.14-Windows-x86-VS2017-&HOSTTOOLVERSION&-staticFull",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MSVC2017-32",
	variant = {"-static(Full)"},
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

conf.q5_15wx6v7 = {
	name = "Qt5.15.14-Windows-x86_64-VS2017-&HOSTTOOLVERSION&",
	qtVersion = "5.15.14-3",
	host = "Win10",
	toolchain = "MSVC2017-64",
	mysqlConf = "m3_1wx6v7",
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-make-tool
		jom
		-skip
		qtwebengine
	]],
}

conf.q5_15wx6v7sf = {
	name = "Qt5.15.14-Windows-x86_64-VS2017-&HOSTTOOLVERSION&-staticFull",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MSVC2017-64",
	variant = {"-static(Full)"},
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

conf.q5_15wx3v9 = {
	name = "Qt5.15.14-Windows-x86-VS2019-&HOSTTOOLVERSION&",
	qtVersion = "5.15.14-3",
	host = "Win10",
	toolchain = "MSVC2019-32",
	mysqlConf = "m3_1wx3v9",
	useNode = "14",
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-make-tool
		jom
		-webengine-proprietary-codecs
	]],
}

conf.q5_15wx3v9sf = {
	name = "Qt5.15.14-Windows-x86-VS2019-&HOSTTOOLVERSION&-staticFull",
	qtVersion = "5.15.14-3",
	host = "Win10",
	toolchain = "MSVC2019-32",
	variant = {"-static(Full)"},
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

conf.q5_15wx6v9 = {
	name = "Qt5.15.14-Windows-x86_64-VS2019-&HOSTTOOLVERSION&",
	qtVersion = "5.15.14-3",
	host = "Win10",
	toolchain = "MSVC2019-64",
	mysqlConf = "m3_1wx6v9",
	useNode = "14",
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-make-tool
		jom
		-webengine-proprietary-codecs
	]],
}

conf.q5_15wx6v9sf = {
	name = "Qt5.15.14-Windows-x86_64-VS2019-&HOSTTOOLVERSION&-staticFull",
	qtVersion = "5.15.14-3",
	host = "Win10",
	toolchain = "MSVC2019-64",
	variant = {"-static(Full)"},
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

conf.q5_15wx6v2 = {
	name = "Qt5.15.14-Windows-x86_64-VS2022-&HOSTTOOLVERSION&",
	qtVersion = "5.15.14-3",
	host = "Win10",
	toolchain = "MSVC2022-64",
	mysqlConf = "m3_1wx6v2",
	useNode = "14",
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-make-tool
		jom
		-webengine-proprietary-codecs
	]],
}

conf.q5_15wa6v2 = {
	name = "Qt5.15.14-Windows-arm64-VS2022-&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MSVC2022-arm64",
	-- mysqlConf = "m3_1wa6v2",
	useNode = "14",
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
		-skip
		qtxmlpatterns
	]],
}

conf.q5_15wx3g8 = {
	name = "Qt5.15.14-Windows-x86-MinGW&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGW810-32",
	-- mysqlConf = "m3_1wx3g8",
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

conf.q5_15wx3g8sf = {
	name = "Qt5.15.14-Windows-x86-MinGW&HOSTTOOLVERSION&-staticFull",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGW810-32",
	variant = {"-static(Full)"},
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

conf.q5_15wx6g8 = {
	name = "Qt5.15.14-Windows-x86_64-MinGW&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGW810-64",
	mysqlConf = "m3_1wx6g8",
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-make-tool
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.q5_15wx6g8sf = {
	name = "Qt5.15.14-Windows-x86_64-MinGW&HOSTTOOLVERSION&-staticFull",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGW810-64",
	variant = {"-static(Full)"},
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

conf.q5_15wx6g1 = {
	name = "Qt5.15.14-Windows-x86_64-MinGW&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGW1120-64",
	mysqlConf = "m3_1wx6g1",
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-no-wmf
		-make-tool
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.q5_15wx6p2 = {
	name = "Qt5.15.14-Windows-x86_64-MinGW&HOSTTOOLVERSION&-ucrt",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGW122u-64",
	mysqlConf = "m3_1wx6p2",
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-no-wmf
		-make-tool
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.q5_15wx6g2 = {
	name = "Qt5.15.14-Windows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGW1220-64",
	mysqlConf = "m3_1wx6g2",
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-no-wmf
		-make-tool
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.q5_15wx6p3 = {
	name = "Qt5.15.14-Windows-x86_64-MinGW&HOSTTOOLVERSION&-ucrt",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGW132u-64",
	mysqlConf = "m3_1wx6p3",
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
		desktop
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-no-wmf
		-make-tool
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.q5_15wx6g3 = {
	name = "Qt5.15.14-Windows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGW1320-64",
	mysqlConf = "m3_1wx6g3",
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
		desktop
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-no-wmf
		-make-tool
		"mingw32-make -j%PARALLELNUM%"
	]],
}

conf.q5_15wx6p4 = {
	name = "Qt5.15.14-Windows-x86_64-MinGW&HOSTTOOLVERSION&-ucrt",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGW141u-64",
	mysqlConf = "m3_1wx6p4",
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
		desktop
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-no-wmf
		-make-tool
		"mingw32-make -j%PARALLELNUM%"
		QMAKE_CFLAGS="-Wno-incompatible-pointer-types"
	]],
}

conf.q5_15wx6g4 = {
	name = "Qt5.15.14-Windows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGW1410-64",
	mysqlConf = "m3_1wx6g4",
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
		desktop
		-ssl
		-schannel
		-sql-sqlite
		-sql-odbc
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-no-wmf
		-make-tool
		"mingw32-make -j%PARALLELNUM%"
		QMAKE_CFLAGS="-Wno-incompatible-pointer-types"
	]],
}

conf.q5_15wx6u6 = {
	name = "Qt5.15.14-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-ucrt",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGWLLVM-ucrt16-64",
	mysqlConf = "m3_1wx6u6",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-clang-g++
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-no-wmf
		-make-tool
		"mingw32-make -j%PARALLELNUM%"
		QMAKE_CXXFLAGS="-Wno-enum-constexpr-conversion"
	]],
}

conf.q5_15wx6s6 = {
	name = "Qt5.15.14-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGWLLVM-msvcrt16-64",
	mysqlConf = "m3_1wx6s6",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-clang-g++
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-no-wmf
		-make-tool
		"mingw32-make -j%PARALLELNUM%"
		QMAKE_CXXFLAGS="-Wno-enum-constexpr-conversion"
	]],
}

conf.q5_15wx6u7 = {
	name = "Qt5.15.14-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-ucrt",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGWLLVM-ucrt17-64",
	mysqlConf = "m3_1wx6u7",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-clang-g++
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-no-wmf
		-make-tool
		"mingw32-make -j%PARALLELNUM%"
		QMAKE_CXXFLAGS="-Wno-enum-constexpr-conversion"
	]],
}

conf.q5_15wx6s7 = {
	name = "Qt5.15.14-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGWLLVM-msvcrt17-64",
	mysqlConf = "m3_1wx6s7",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-clang-g++
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-no-wmf
		-make-tool
		"mingw32-make -j%PARALLELNUM%"
		QMAKE_CXXFLAGS="-Wno-enum-constexpr-conversion"
	]],
}

conf.q5_15wx6u8 = {
	name = "Qt5.15.14-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-ucrt",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGWLLVM-ucrt18-64",
	mysqlConf = "m3_1wx6u8",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-clang-g++
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-no-wmf
		-make-tool
		"mingw32-make -j%PARALLELNUM%"
		QMAKE_CXXFLAGS="-Wno-enum-constexpr-conversion -Wno-c++11-narrowing-const-reference"
	]],
}

conf.q5_15wx6s8 = {
	name = "Qt5.15.14-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGWLLVM-msvcrt18-64",
	mysqlConf = "m3_1wx6s8",
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-shared
		-release
		-confirm-license
		-platform
		win32-clang-g++
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
		-sql-mysql
		"MYSQL_INCDIR=&MYSQLPREFIX&\include\mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&\lib\mariadb"
		-no-wmf
		-make-tool
		"mingw32-make -j%PARALLELNUM%"
		QMAKE_CXXFLAGS="-Wno-enum-constexpr-conversion -Wno-c++11-narrowing-const-reference"
	]],
}

conf.q5_15mal = {
	name = "Qt5.15.14-macOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "5.15.14-3",
	host = "macOSM1",
	mysqlConf = "m3_1mal",
	includeDeprecatedOdbcHeader = true,
	useNode = "14",
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
		-sql-odbc
		-sql-mysql
		"ODBC_PREFIX=&ODBCPREFIX&"
		"MYSQL_INCDIR=&MYSQLPREFIX&/include/mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&/lib/mariadb"
		-make-tool
		"make -j$PARALLELNUM"
		-webengine-proprietary-codecs
		QMAKE_APPLE_DEVICE_ARCHS="arm64 x86_64"
	]],
	NINJAFLAGS = "-v -j4"
}

conf.q5_15malnf = {
	name = "Qt5.15.14-macOS-Universal-AppleClang&HOSTTOOLVERSION&-noFramework",
	qtVersion = "5.15.14-3",
	host = "macOSM1",
	variant = {"-no-framework"},
	mysqlConf = "m3_1mal",
	includeDeprecatedOdbcHeader = true,
	useNode = "14",
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
		-sql-odbc
		-sql-mysql
		"ODBC_PREFIX=&ODBCPREFIX&"
		"MYSQL_INCDIR=&MYSQLPREFIX&/include/mariadb"
		"MYSQL_LIBDIR=&MYSQLPREFIX&/lib/mariadb"
		-make-tool
		"make -j$PARALLELNUM"
		-rpath
		-webengine-proprietary-codecs
		-no-framework
		QMAKE_APPLE_DEVICE_ARCHS="arm64 x86_64"
	]],
	NINJAFLAGS = "-v -j4"
}

conf.q5_15malsf = {
	name = "Qt5.15.14-macOS-Universal-AppleClang&HOSTTOOLVERSION&-staticFull",
	qtVersion = "5.15.14-3",
	host = "macOSM1",
	variant = {"-static(Full)"},
	configureParameter = [[
		-prefix
		&INSTALLROOT&
		-opensource
		-static
		-feature-relocatable
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
		qtwebengine
		QMAKE_APPLE_DEVICE_ARCHS="arm64 x86_64"
	]],
}

conf.q5_15wx6g8_aalnV21 = {
	name = "Qt5.15.14-Android-ALL-Clang-NDKr21e-xWindows-x86_64-MinGW&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGW810-64",
	target = "Android-23",
	toolchainT = "Android-23-r21e-ALL",
	opensslConf = "o3_0aalnV21L23",
	androidSdkVersion = "20240204",
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
		android-23
		-android-ndk-host
		windows-x86_64
		-skip
		qtscript
	]],
}

conf.q5_15lx6_aalnV21 = {
	name = "Qt5.15.14-Android-ALL-Clang-NDKr21e-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "CentOS8",
	target = "Android-23",
	toolchainT = "Android-23-r21e-ALL",
	opensslConf = "o3_0aalnV21L23",
	androidSdkVersion = "20240204",
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
		android-23
		-android-ndk-host
		linux-x86_64
		-skip
		qtscript
	]],
}

conf.q5_15mx6_aalnV21 = {
	name = "Qt5.15.14-Android-ALL-Clang-NDKr21e-xmacOS-x86_64-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "macOS1015",
	target = "Android-23",
	toolchainT = "Android-23-r21e-ALL",
	opensslConf = "o3_0aalnV21L23",
	androidSdkVersion = "20240204",
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
		android-23
		-android-ndk-host
		darwin-x86_64
		-skip
		qtscript
	]],
}

conf.q5_15ma6_aalnV21 = {
	name = "Qt5.15.14-Android-ALL-Clang-NDKr21e-xmacOS-arm64-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "macOSM1",
	target = "Android-23",
	toolchainT = "Android-23-r21e-ALL",
	opensslConf = "o3_0aalnV21L23",
	androidSdkVersion = "20240204",
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
		android-23
		-android-ndk-host
		darwin-x86_64
		-skip
		qtscript
	]],
}

conf.q5_15wx6g8_aalnV23 = {
	name = "Qt5.15.14-Android-ALL-Clang-NDKr23c-xWindows-x86_64-MinGW&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGW810-64",
	target = "Android-23",
	toolchainT = "Android-23-r23c-ALL",
	opensslConf = "o3_0aalnV23L23",
	androidSdkVersion = "20240204",
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
		android-23
		-android-ndk-host
		windows-x86_64
		-skip
		qtscript
	]],
}

conf.q5_15lx6_aalnV23 = {
	name = "Qt5.15.14-Android-ALL-Clang-NDKr23c-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "CentOS8",
	target = "Android-23",
	toolchainT = "Android-23-r23c-ALL",
	opensslConf = "o3_0aalnV23L23",
	androidSdkVersion = "20240204",
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
		android-23
		-android-ndk-host
		linux-x86_64
		-skip
		qtscript
	]],
}

conf.q5_15mx6_aalnV23 = {
	name = "Qt5.15.14-Android-ALL-Clang-NDKr23c-xmacOS-x86_64-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "macOS1015",
	target = "Android-23",
	toolchainT = "Android-23-r23c-ALL",
	opensslConf = "o3_0aalnV23L23",
	androidSdkVersion = "20240204",
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
		android-23
		-android-ndk-host
		darwin-x86_64
		-skip
		qtscript
	]],
}

conf.q5_15ma6_aalnV23 = {
	name = "Qt5.15.14-Android-ALL-Clang-NDKr23c-xmacOS-arm64-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "macOSM1",
	target = "Android-23",
	toolchainT = "Android-23-r23c-ALL",
	opensslConf = "o3_0aalnV23L23",
	androidSdkVersion = "20240204",
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
		android-23
		-android-ndk-host
		darwin-x86_64
		-skip
		qtscript
	]],
}

conf.q5_15wx6g8_aalnV25 = {
	name = "Qt5.15.14-Android-ALL-Clang-NDKr25c-xWindows-x86_64-MinGW&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "Win10",
	toolchain = "MinGW810-64",
	target = "Android-23",
	toolchainT = "Android-23-r25c-ALL",
	opensslConf = "o3_0aalnV25L23",
	androidSdkVersion = "20240204",
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
		android-23
		-android-ndk-host
		windows-x86_64
		-skip
		qtscript
	]],
}

conf.q5_15lx6_aalnV25 = {
	name = "Qt5.15.14-Android-ALL-Clang-NDKr25c-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "CentOS8",
	target = "Android-23",
	toolchainT = "Android-23-r25c-ALL",
	opensslConf = "o3_0aalnV25L23",
	androidSdkVersion = "20240204",
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
		android-23
		-android-ndk-host
		linux-x86_64
		-skip
		qtscript
	]],
}

conf.q5_15mx6_aalnV25 = {
	name = "Qt5.15.14-Android-ALL-Clang-NDKr25c-xmacOS-x86_64-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "macOS1015",
	target = "Android-23",
	toolchainT = "Android-23-r25c-ALL",
	opensslConf = "o3_0aalnV25L23",
	androidSdkVersion = "20240204",
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
		android-23
		-android-ndk-host
		darwin-x86_64
		-skip
		qtscript
	]],
}

conf.q5_15ma6_aalnV25 = {
	name = "Qt5.15.14-Android-ALL-Clang-NDKr25c-xmacOS-arm64-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "macOSM1",
	target = "Android-23",
	toolchainT = "Android-23-r25c-ALL",
	opensslConf = "o3_0aalnV25L23",
	androidSdkVersion = "20240204",
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
		android-23
		-android-ndk-host
		darwin-x86_64
		-skip
		qtscript
	]],
}

conf.q5_15wx6g8_W = {
	name = "Qt5.15.14-WebAssembly-emscripten&TARGETTOOLVERSION&-xWindows-x86_64-MinGW&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
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

conf.q5_15lx6_W = {
	name = "Qt5.15.14-WebAssembly-emscripten&TARGETTOOLVERSION&-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
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

conf.q5_15mx6_W = {
	name = "Qt5.15.14-WebAssembly-emscripten&TARGETTOOLVERSION&-xmacOS-x86_64-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "macOS1015",
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

conf.q5_15ma6_W = {
	name = "Qt5.15.14-WebAssembly-emscripten&TARGETTOOLVERSION&-xmacOS-arm64-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "5.15.14",
	host = "macOSM1",
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

conf.q6_2wx6v9 = {
	name = "Qt6.2.9-Windows-x86_64-VS2019-&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MSVC2019-64",
	opensslConf = "o3_0wx6v9",
	mysqlConf = "m3_3wx6v9",
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\libmariadb.lib"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6v9sf = {
	name = "Qt6.2.9-Windows-x86_64-VS2019-&HOSTTOOLVERSION&-staticFull",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MSVC2019-64",
	variant = {"-static(Full)"},
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DFEATURE_static_runtime=ON
		-DCMAKE_BUILD_TYPE=Release
		-DQT_QMAKE_TARGET_MKSPEC=win32-msvc
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
		-DFEATURE_openssl=OFF
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6v2 = {
	name = "Qt6.2.9-Windows-x86_64-VS2022-&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MSVC2022-64",
	opensslConf = "o3_0wx6v2",
	mysqlConf = "m3_3wx6v2",
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\libmariadb.lib"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wa6v2 = {
	name = "Qt6.2.9-Windows-arm64-VS2022-&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "Win10Arm",
	toolchain = "MSVC2022-arm64",
	opensslConf = "o3_0wa6v2",
	mysqlConf = "m3_3wa6v2",
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\libmariadb.lib"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6g1 = {
	name = "Qt6.2.9-Windows-x86_64-MinGW&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MinGW1120-64",
	opensslConf = "o3_0wx6g1",
	mysqlConf = "m3_3wx6g1",
	useCMake = "20",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6g1st = {
	name = "Qt6.2.9-Windows-x86_64-MinGW&HOSTTOOLVERSION&-static",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MinGW1120-64",
	variant = {"-static(Lite)"},
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DFEATURE_static_runtime=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DFEATURE_openssl=OFF
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
		-DCMAKE_EXE_LINKER_FLAGS="--static -static-libgcc -static-libstdc++"
	]],
}

conf.q6_2wx6g1sf = {
	name = "Qt6.2.9-Windows-x86_64-MinGW&HOSTTOOLVERSION&-staticFull",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MinGW1120-64",
	variant = {"-static(Full)"},
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DFEATURE_static_runtime=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DFEATURE_openssl=OFF
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtopcua=OFF
		-DCMAKE_EXE_LINKER_FLAGS="--static -static-libgcc -static-libstdc++"
	]],
}

conf.q6_2wx6p2 = {
	name = "Qt6.2.9-Windows-x86_64-MinGW&HOSTTOOLVERSION&-ucrt",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MinGW122u-64",
	opensslConf = "o3_0wx6p2",
	mysqlConf = "m3_3wx6p2",
	useCMake = "20",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6g2 = {
	name = "Qt6.2.9-Windows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MinGW1220-64",
	opensslConf = "o3_0wx6g2",
	mysqlConf = "m3_3wx6g2",
	useCMake = "20",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6p3 = {
	name = "Qt6.2.9-Windows-x86_64-MinGW&HOSTTOOLVERSION&-ucrt",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MinGW132u-64",
	opensslConf = "o3_0wx6p3",
	mysqlConf = "m3_3wx6p3",
	useCMake = "20",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6g3 = {
	name = "Qt6.2.9-Windows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MinGW1320-64",
	opensslConf = "o3_0wx6g3",
	mysqlConf = "m3_3wx6g3",
	useCMake = "20",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6p4 = {
	name = "Qt6.2.9-Windows-x86_64-MinGW&HOSTTOOLVERSION&-ucrt",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MinGW141u-64",
	opensslConf = "o3_0wx6p4",
	mysqlConf = "m3_3wx6p4",
	useCMake = "20",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6g4 = {
	name = "Qt6.2.9-Windows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MinGW1410-64",
	opensslConf = "o3_0wx6g4",
	mysqlConf = "m3_3wx6g4",
	useCMake = "20",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6u6 = {
	name = "Qt6.2.9-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-ucrt",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MinGWLLVM-ucrt16-64",
	opensslConf = "o3_0wx6u6",
	mysqlConf = "m3_3wx6u6",
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtopcua=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_2wx6s6 = {
	name = "Qt6.2.9-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MinGWLLVM-msvcrt16-64",
	opensslConf = "o3_0wx6s6",
	mysqlConf = "m3_3wx6s6",
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtopcua=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_2wx6u7 = {
	name = "Qt6.2.9-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-ucrt",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MinGWLLVM-ucrt17-64",
	opensslConf = "o3_0wx6u7",
	mysqlConf = "m3_3wx6u7",
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtopcua=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_2wx6s7 = {
	name = "Qt6.2.9-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MinGWLLVM-msvcrt17-64",
	opensslConf = "o3_0wx6s7",
	mysqlConf = "m3_3wx6s7",
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtopcua=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_2wx6u8 = {
	name = "Qt6.2.9-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-ucrt",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MinGWLLVM-ucrt18-64",
	opensslConf = "o3_0wx6u8",
	mysqlConf = "m3_3wx6u8",
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtopcua=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_2wx6s8 = {
	name = "Qt6.2.9-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MinGWLLVM-msvcrt18-64",
	opensslConf = "o3_0wx6s8",
	mysqlConf = "m3_3wx6s8",
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtopcua=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_2lx6st = {
	name = "Qt6.2.9-Linux-x86_64-gcc&HOSTTOOLVERSION&-static",
	qtVersion = "6.2.9",
	host = "CentOS8",
	variant = {"-static(Lite)"},
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DFEATURE_static_runtime=ON
		-DCMAKE_BUILD_TYPE=Release
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

conf.q6_2mal = {
	name = "Qt6.2.9-macOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "macOSM1",
	opensslConf = "o3_0mal",
	mysqlConf = "m3_3mal",
	useCMake = "27",
	includeDeprecatedOdbcHeader = true,
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_OSX_ARCHITECTURES="x86_64;arm64"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DODBC_INCLUDE_DIR="&ODBCPREFIX&/include"
		-DODBC_LIBRARY=iodbc
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&/include/mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&/lib/mariadb/libmariadb.3.dylib"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtwebengine=OFF
		-DCMAKE_SKIP_BUILD_RPATH=OFF
		-DCMAKE_SKIP_INSTALL_RPATH=OFF
		-DFEATURE_framework=ON
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2malnf = {
	name = "Qt6.2.9-macOS-Universal-AppleClang&HOSTTOOLVERSION&-noFramework",
	qtVersion = "6.2.9",
	host = "macOSM1",
	variant = {"-no-framework"},
	opensslConf = "o3_0mal",
	mysqlConf = "m3_3mal",
	useCMake = "27",
	includeDeprecatedOdbcHeader = true,
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_OSX_ARCHITECTURES="x86_64;arm64"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DODBC_INCLUDE_DIR="&ODBCPREFIX&/include"
		-DODBC_LIBRARY=iodbc
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&/include/mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&/lib/mariadb/libmariadb.3.dylib"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtwebengine=OFF
		-DCMAKE_SKIP_BUILD_RPATH=OFF
		-DCMAKE_SKIP_INSTALL_RPATH=OFF
		-DFEATURE_framework=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2malst = {
	name = "Qt6.2.9-macOS-Universal-AppleClang&HOSTTOOLVERSION&-static",
	qtVersion = "6.2.9",
	host = "macOSM1",
	variant = {"-static(Lite)"},
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_OSX_ARCHITECTURES="x86_64;arm64"
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
		-DFEATURE_openssl=OFF
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

conf.q6_2malsf = {
	name = "Qt6.2.9-macOS-Universal-AppleClang&HOSTTOOLVERSION&-staticFull",
	qtVersion = "6.2.9",
	host = "macOSM1",
	variant = {"-static(Full)"},
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_OSX_ARCHITECTURES="x86_64;arm64"
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
		-DFEATURE_openssl=OFF
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtopcua=OFF
	]],
}

conf.q6_2wx6g1_aa3nV23 = {
	name = "Qt6.2.9-Android-arm-Clang-NDKr23c-xWindows-x86_64-MinGW&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "Win10",
	target = "Android-24",
	toolchain = "MinGW1120-64",
	toolchainT = "Android-24-r23c-arm",
	opensslConf = "o3_0aa3nV23L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=armeabi-v7a
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_2wx6g1_aa6nV23 = {
	name = "Qt6.2.9-Android-arm64-Clang-NDKr23c-xWindows-x86_64-MinGW&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "Win10",
	target = "Android-24",
	toolchain = "MinGW1120-64",
	toolchainT = "Android-24-r23c-arm64",
	opensslConf = "o3_0aa6nV23L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=arm64-v8a
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_2wx6g1_ax3nV23 = {
	name = "Qt6.2.9-Android-x86-Clang-NDKr23c-xWindows-x86_64-MinGW&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "Win10",
	target = "Android-24",
	toolchain = "MinGW1120-64",
	toolchainT = "Android-24-r23c-x86",
	opensslConf = "o3_0ax3nV23L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_2wx6g1_ax6nV23 = {
	name = "Qt6.2.9-Android-x86_64-Clang-NDKr23c-xWindows-x86_64-MinGW&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "Win10",
	target = "Android-24",
	toolchain = "MinGW1120-64",
	toolchainT = "Android-24-r23c-x86_64",
	opensslConf = "o3_0ax6nV23L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86_64
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_2lx6_aa3nV23 = {
	name = "Qt6.2.9-Android-arm-Clang-NDKr23c-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23c-arm",
	opensslConf = "o3_0aa3nV23L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=armeabi-v7a
	]],
}

conf.q6_2lx6_aa6nV23 = {
	name = "Qt6.2.9-Android-arm64-Clang-NDKr23c-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23c-arm64",
	opensslConf = "o3_0aa6nV23L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=arm64-v8a
	]],
}

conf.q6_2lx6_ax3nV23 = {
	name = "Qt6.2.9-Android-x86-Clang-NDKr23c-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23c-x86",
	opensslConf = "o3_0ax3nV23L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86
	]],
}

conf.q6_2lx6_ax6nV23 = {
	name = "Qt6.2.9-Android-x86_64-Clang-NDKr23c-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r23c-x86_64",
	opensslConf = "o3_0ax6nV23L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86_64
	]],
}

conf.q6_2mal_aa3nV23 = {
	name = "Qt6.2.9-Android-arm-Clang-NDKr23c-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "macOSM1",
	target = "Android-24",
	toolchainT = "Android-24-r23c-arm",
	opensslConf = "o3_0aa3nV23L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=armeabi-v7a
	]],
}

conf.q6_2mal_aa6nV23 = {
	name = "Qt6.2.9-Android-arm64-Clang-NDKr23c-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "macOSM1",
	target = "Android-24",
	toolchainT = "Android-24-r23c-arm64",
	opensslConf = "o3_0aa6nV23L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=arm64-v8a
	]],
}

conf.q6_2mal_ax3nV23 = {
	name = "Qt6.2.9-Android-x86-Clang-NDKr23c-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "macOSM1",
	target = "Android-24",
	toolchainT = "Android-24-r23c-x86",
	opensslConf = "o3_0ax3nV23L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86
	]],
}

conf.q6_2mal_ax6nV23 = {
	name = "Qt6.2.9-Android-x86_64-Clang-NDKr23c-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "macOSM1",
	target = "Android-24",
	toolchainT = "Android-24-r23c-x86_64",
	opensslConf = "o3_0ax6nV23L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86_64
	]],
}

conf.q6_2wx6g1_aa3nV25 = {
	name = "Qt6.2.9-Android-arm-Clang-NDKr25c-xWindows-x86_64-MinGW&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "Win10",
	target = "Android-24",
	toolchain = "MinGW1120-64",
	toolchainT = "Android-24-r25c-arm",
	opensslConf = "o3_0aa3nV25L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=armeabi-v7a
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_2wx6g1_aa6nV25 = {
	name = "Qt6.2.9-Android-arm64-Clang-NDKr25c-xWindows-x86_64-MinGW&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "Win10",
	target = "Android-24",
	toolchain = "MinGW1120-64",
	toolchainT = "Android-24-r25c-arm64",
	opensslConf = "o3_0aa6nV25L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=arm64-v8a
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_2wx6g1_ax3nV25 = {
	name = "Qt6.2.9-Android-x86-Clang-NDKr25c-xWindows-x86_64-MinGW&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "Win10",
	target = "Android-24",
	toolchain = "MinGW1120-64",
	toolchainT = "Android-24-r25c-x86",
	opensslConf = "o3_0ax3nV25L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_2wx6g1_ax6nV25 = {
	name = "Qt6.2.9-Android-x86_64-Clang-NDKr25c-xWindows-x86_64-MinGW&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "Win10",
	target = "Android-24",
	toolchain = "MinGW1120-64",
	toolchainT = "Android-24-r25c-x86_64",
	opensslConf = "o3_0ax6nV25L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86_64
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_2lx6_aa3nV25 = {
	name = "Qt6.2.9-Android-arm-Clang-NDKr25c-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r25c-arm",
	opensslConf = "o3_0aa3nV25L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=armeabi-v7a
	]],
}

conf.q6_2lx6_aa6nV25 = {
	name = "Qt6.2.9-Android-arm64-Clang-NDKr25c-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r25c-arm64",
	opensslConf = "o3_0aa6nV25L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=arm64-v8a
	]],
}

conf.q6_2lx6_ax3nV25 = {
	name = "Qt6.2.9-Android-x86-Clang-NDKr25c-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r25c-x86",
	opensslConf = "o3_0ax3nV25L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86
	]],
}

conf.q6_2lx6_ax6nV25 = {
	name = "Qt6.2.9-Android-x86_64-Clang-NDKr25c-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "CentOS8",
	target = "Android-24",
	toolchainT = "Android-24-r25c-x86_64",
	opensslConf = "o3_0ax6nV25L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86_64
	]],
}

conf.q6_2mal_aa3nV25 = {
	name = "Qt6.2.9-Android-arm-Clang-NDKr25c-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "macOSM1",
	target = "Android-24",
	toolchainT = "Android-24-r25c-arm",
	opensslConf = "o3_0aa3nV25L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=armeabi-v7a
	]],
}

conf.q6_2mal_aa6nV25 = {
	name = "Qt6.2.9-Android-arm64-Clang-NDKr25c-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "macOSM1",
	target = "Android-24",
	toolchainT = "Android-24-r25c-arm64",
	opensslConf = "o3_0aa6nV25L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=arm64-v8a
	]],
}

conf.q6_2mal_ax3nV25 = {
	name = "Qt6.2.9-Android-x86-Clang-NDKr25c-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "macOSM1",
	target = "Android-24",
	toolchainT = "Android-24-r25c-x86",
	opensslConf = "o3_0ax3nV25L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86
	]],
}

conf.q6_2mal_ax6nV25 = {
	name = "Qt6.2.9-Android-x86_64-Clang-NDKr25c-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "macOSM1",
	target = "Android-24",
	toolchainT = "Android-24-r25c-x86_64",
	opensslConf = "o3_0ax6nV25L24",
	useCMake = "27",
	androidSdkVersion = "20240204",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtopcua=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=24
		-DANDROID_PLATFORM=24
		-DANDROID_ABI=x86_64
	]],
}

-- WebAssembly uses emcmake which don't need a toolchain file
conf.q6_2wx6g1_W = {
	name = "Qt6.2.9-WebAssembly-emscripten&TARGETTOOLVERSION&-xWindows-x86_64-MinGW&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "Win10",
	toolchain = "MinGW1120-64",
	target = "WebAssembly",
	toolchainT = "emscripten-2.0.14",
	useCMake = "27",
	-- workaround https://github.com/emscripten-core/emscripten/issues/15163
	configureParameter = [[
		-G
		Ninja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DQT_QMAKE_TARGET_MKSPEC=wasm-emscripten
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DBUILD_WITH_PCH=ON
		-DFEATURE_thread=ON
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
	name = "Qt6.2.9-WebAssembly-emscripten&TARGETTOOLVERSION&-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "CentOS8",
	target = "WebAssembly",
	toolchainT = "emscripten-2.0.14",
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DQT_QMAKE_TARGET_MKSPEC=wasm-emscripten
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DBUILD_WITH_PCH=ON
		-DFEATURE_thread=ON
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

conf.q6_2mal_W = {
	name = "Qt6.2.9-WebAssembly-emscripten&TARGETTOOLVERSION&-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.2.9",
	host = "macOSM1",
	target = "WebAssembly",
	toolchainT = "emscripten-2.0.14",
	useCMake = "27",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DQT_QMAKE_TARGET_MKSPEC=wasm-emscripten
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DBUILD_WITH_PCH=ON
		-DFEATURE_thread=ON
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

conf.q6_5wx6v9 = {
	name = "Qt6.5.3-Windows-x86_64-VS2019-&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MSVC2019-64",
	opensslConf = "o3_0wx6v9",
	mysqlConf = "m3_3wx6v9",
	useCMake = "Latest",
	useNode = "18",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\libmariadb.lib"
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_webengine_proprietary_codecs=ON
		-DFEATURE_qtpdf_build=ON
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_5wx6v2 = {
	name = "Qt6.5.3-Windows-x86_64-VS2022-&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MSVC2022-64",
	opensslConf = "o3_0wx6v2",
	mysqlConf = "m3_3wx6v2",
	useCMake = "Latest",
	useNode = "18",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\libmariadb.lib"
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_webengine_proprietary_codecs=ON
		-DFEATURE_qtpdf_build=ON
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_5wx6v2sf = {
	name = "Qt6.5.3-Windows-x86_64-VS2022-&HOSTTOOLVERSION&-staticFull",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MSVC2022-64",
	variant = {"-static(Full)"},
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DFEATURE_static_runtime=ON
		-DCMAKE_BUILD_TYPE=Release
		-DQT_QMAKE_TARGET_MKSPEC=win32-msvc
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
		-DFEATURE_openssl=OFF
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
	]],
}

conf.q6_5wa6v2 = {
	name = "Qt6.5.3-Windows-arm64-VS2022-&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "Win10Arm",
	toolchain = "MSVC2022-arm64",
	opensslConf = "o3_0wa6v2",
	mysqlConf = "m3_3wa6v2",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\libmariadb.lib"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
	]],
}

conf.q6_5wx6p2 = {
	name = "Qt6.5.3-Windows-x86_64-MinGW&HOSTTOOLVERSION&-ucrt",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGW122u-64",
	opensslConf = "o3_0wx6p2",
	mysqlConf = "m3_3wx6p2",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_5wx6p2sf = {
	name = "Qt6.5.3-Windows-x86_64-MinGW&HOSTTOOLVERSION&-ucrt-staticFull",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGW122u-64",
	variant = {"-static(Full)"},
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DFEATURE_static_runtime=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DFEATURE_openssl=OFF
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DCMAKE_EXE_LINKER_FLAGS="--static -static-libgcc -static-libstdc++"
	]],
}

conf.q6_5wx6g2 = {
	name = "Qt6.5.3-Windows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGW1220-64",
	opensslConf = "o3_0wx6g2",
	mysqlConf = "m3_3wx6g2",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_5wx6g2st = {
	name = "Qt6.5.3-Windows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt-static",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGW1220-64",
	variant = {"-static(Lite)"},
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DFEATURE_static_runtime=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DFEATURE_openssl=OFF
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
		-DBUILD_qtgrpc=OFF
		-DBUILD_qthttpserver=OFF
		-DBUILD_qtlanguageserver=OFF
		-DBUILD_qtlocation=OFF
		-DBUILD_qtlottie=OFF
		-DBUILD_qtmqtt=OFF
		-DBUILD_qtnetworkauth=OFF
		-DBUILD_qtpositioning=OFF
		-DBUILD_qtquick3dphysics=OFF
		-DBUILD_qtquicktimeline=OFF
		-DBUILD_qtsensors=OFF
		-DBUILD_qtserialbus=OFF
		-DBUILD_qtserialport=OFF
		-DBUILD_qtspeech=OFF
		-DBUILD_qtvirtualkeyboard=OFF
		-DBUILD_qtwayland=OFF
		-DBUILD_qtwebchannel=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtwebsockets=OFF
		-DBUILD_qtwebview=OFF
		-DCMAKE_EXE_LINKER_FLAGS="--static -static-libgcc -static-libstdc++"
	]],
}

conf.q6_5wx6g2sf = {
	name = "Qt6.5.3-Windows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt-staticFull",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGW1220-64",
	variant = {"-static(Full)"},
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DFEATURE_static_runtime=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DFEATURE_openssl=OFF
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DCMAKE_EXE_LINKER_FLAGS="--static -static-libgcc -static-libstdc++"
	]],
}

conf.q6_5wx6p3 = {
	name = "Qt6.5.3-Windows-x86_64-MinGW&HOSTTOOLVERSION&-ucrt",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGW132u-64",
	opensslConf = "o3_0wx6p3",
	mysqlConf = "m3_3wx6p3",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_5wx6p3sf = {
	name = "Qt6.5.3-Windows-x86_64-MinGW&HOSTTOOLVERSION&-ucrt-staticFull",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGW132u-64",
	variant = {"-static(Full)"},
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DFEATURE_static_runtime=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DFEATURE_openssl=OFF
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DCMAKE_EXE_LINKER_FLAGS="--static -static-libgcc -static-libstdc++"
	]],
}

conf.q6_5wx6g3 = {
	name = "Qt6.5.3-Windows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGW1320-64",
	opensslConf = "o3_0wx6g3",
	mysqlConf = "m3_3wx6g3",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_5wx6g3sf = {
	name = "Qt6.5.3-Windows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt-staticFull",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGW1320-64",
	variant = {"-static(Full)"},
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DFEATURE_static_runtime=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DFEATURE_openssl=OFF
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DCMAKE_EXE_LINKER_FLAGS="--static -static-libgcc -static-libstdc++"
	]],
}

conf.q6_5wx6p4 = {
	name = "Qt6.5.3-Windows-x86_64-MinGW&HOSTTOOLVERSION&-ucrt",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGW141u-64",
	opensslConf = "o3_0wx6p4",
	mysqlConf = "m3_3wx6p4",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_5wx6g4 = {
	name = "Qt6.5.3-Windows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGW1410-64",
	opensslConf = "o3_0wx6g4",
	mysqlConf = "m3_3wx6g4",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_5wx6u6 = {
	name = "Qt6.5.3-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-ucrt",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGWLLVM-ucrt16-64",
	opensslConf = "o3_0wx6u6",
	mysqlConf = "m3_3wx6u6",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_5wx6s6 = {
	name = "Qt6.5.3-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGWLLVM-msvcrt16-64",
	opensslConf = "o3_0wx6s6",
	mysqlConf = "m3_3wx6s6",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_5wx6u7 = {
	name = "Qt6.5.3-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-ucrt",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGWLLVM-ucrt17-64",
	opensslConf = "o3_0wx6u7",
	mysqlConf = "m3_3wx6u7",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_5wx6s7 = {
	name = "Qt6.5.3-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGWLLVM-msvcrt17-64",
	opensslConf = "o3_0wx6s7",
	mysqlConf = "m3_3wx6s7",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_5wx6u8 = {
	name = "Qt6.5.3-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-ucrt",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGWLLVM-ucrt18-64",
	opensslConf = "o3_0wx6u8",
	mysqlConf = "m3_3wx6u8",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_5wx6s8 = {
	name = "Qt6.5.3-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGWLLVM-msvcrt18-64",
	opensslConf = "o3_0wx6s8",
	mysqlConf = "m3_3wx6s8",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_5lx6st = {
	name = "Qt6.5.3-Linux-x86_64-gcc&HOSTTOOLVERSION&-static",
	qtVersion = "6.5.3",
	host = "Rocky9",
	variant = {"-static(Lite)"},
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DFEATURE_static_runtime=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DBUILD_qtgrpc=OFF
		-DBUILD_qthttpserver=OFF
		-DBUILD_qtlanguageserver=OFF
		-DBUILD_qtlocation=OFF
		-DBUILD_qtlottie=OFF
		-DBUILD_qtmqtt=OFF
		-DBUILD_qtnetworkauth=OFF
		-DBUILD_qtpositioning=OFF
		-DBUILD_qtquick3dphysics=OFF
		-DBUILD_qtquicktimeline=OFF
		-DBUILD_qtsensors=OFF
		-DBUILD_qtserialbus=OFF
		-DBUILD_qtserialport=OFF
		-DBUILD_qtspeech=OFF
		-DBUILD_qtvirtualkeyboard=OFF
		-DBUILD_qtwayland=OFF
		-DBUILD_qtwebchannel=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtwebsockets=OFF
		-DBUILD_qtwebview=OFF
	]],
}

conf.q6_5mal = {
	name = "Qt6.5.3-macOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "macOSM1",
	opensslConf = "o3_0mal",
	mysqlConf = "m3_3mal",
	useCMake = "Latest",
	includeDeprecatedOdbcHeader = true,
	useNode = "18",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_OSX_ARCHITECTURES="x86_64;arm64"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DODBC_INCLUDE_DIR="&ODBCPREFIX&/include"
		-DODBC_LIBRARY=iodbc
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&/include/mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&/lib/mariadb/libmariadb.3.dylib"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtwebengine=OFF
		-DCMAKE_SKIP_BUILD_RPATH=OFF
		-DCMAKE_SKIP_INSTALL_RPATH=OFF
		-DFEATURE_framework=ON
		-DBUILD_qtgrpc=OFF
		-DCMAKE_BUILD_RPATH="&OPENSSLDIR&/lib"
	]],
}

conf.q6_5malnf = {
	name = "Qt6.5.3-macOS-Universal-AppleClang&HOSTTOOLVERSION&-noFramework",
	qtVersion = "6.5.3",
	host = "macOSM1",
	variant = {"-no-framework"},
	opensslConf = "o3_0mal",
	mysqlConf = "m3_3mal",
	useCMake = "Latest",
	includeDeprecatedOdbcHeader = true,
	useNode = "18",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_OSX_ARCHITECTURES="x86_64;arm64"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DODBC_INCLUDE_DIR="&ODBCPREFIX&/include"
		-DODBC_LIBRARY=iodbc
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&/include/mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&/lib/mariadb/libmariadb.3.dylib"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtwebengine=OFF
		-DCMAKE_SKIP_BUILD_RPATH=OFF
		-DCMAKE_SKIP_INSTALL_RPATH=OFF
		-DFEATURE_framework=OFF
		-DBUILD_qtgrpc=OFF
		-DCMAKE_BUILD_RPATH="&OPENSSLDIR&/lib"
	]],
}

conf.q6_5malst = {
	name = "Qt6.5.3-macOS-Universal-AppleClang&HOSTTOOLVERSION&-static",
	qtVersion = "6.5.3",
	host = "macOSM1",
	variant = {"-static(Lite)"},
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_OSX_ARCHITECTURES="x86_64;arm64"
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
		-DFEATURE_openssl=OFF
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
		-DBUILD_qtgrpc=OFF
		-DBUILD_qthttpserver=OFF
		-DBUILD_qtlanguageserver=OFF
		-DBUILD_qtlocation=OFF
		-DBUILD_qtlottie=OFF
		-DBUILD_qtmqtt=OFF
		-DBUILD_qtnetworkauth=OFF
		-DBUILD_qtpositioning=OFF
		-DBUILD_qtquick3dphysics=OFF
		-DBUILD_qtquicktimeline=OFF
		-DBUILD_qtsensors=OFF
		-DBUILD_qtserialbus=OFF
		-DBUILD_qtserialport=OFF
		-DBUILD_qtspeech=OFF
		-DBUILD_qtvirtualkeyboard=OFF
		-DBUILD_qtwayland=OFF
		-DBUILD_qtwebchannel=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtwebsockets=OFF
		-DBUILD_qtwebview=OFF
	]],
}

conf.q6_5malsf = {
	name = "Qt6.5.3-macOS-Universal-AppleClang&HOSTTOOLVERSION&-staticFull",
	qtVersion = "6.5.3",
	host = "macOSM1",
	variant = {"-static(Full)"},
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_OSX_ARCHITECTURES="x86_64;arm64"
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
		-DFEATURE_openssl=OFF
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
	]],
}

conf.q6_5wx6g2_aa3nV25 = {
	name = "Qt6.5.3-Android-arm-Clang-NDKr25c-xWindows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.5.3",
	host = "Win10",
	target = "Android-27",
	toolchain = "MinGW1220-64",
	toolchainT = "Android-27-r25c-arm",
	opensslConf = "o3_0aa3nV25L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=armeabi-v7a
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_5wx6g2_aa6nV25 = {
	name = "Qt6.5.3-Android-arm64-Clang-NDKr25c-xWindows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.5.3",
	host = "Win10",
	target = "Android-27",
	toolchain = "MinGW1220-64",
	toolchainT = "Android-27-r25c-arm64",
	opensslConf = "o3_0aa6nV25L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=arm64-v8a
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_5wx6g2_ax6nV25 = {
	name = "Qt6.5.3-Android-x86_64-Clang-NDKr25c-xWindows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.5.3",
	host = "Win10",
	target = "Android-27",
	toolchain = "MinGW1220-64",
	toolchainT = "Android-27-r25c-x86_64",
	opensslConf = "o3_0ax6nV25L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=x86_64
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_5lx6_aa3nV25 = {
	name = "Qt6.5.3-Android-arm-Clang-NDKr25c-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r25c-arm",
	opensslConf = "o3_0aa3nV25L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=armeabi-v7a
	]],
}

conf.q6_5lx6_aa6nV25 = {
	name = "Qt6.5.3-Android-arm64-Clang-NDKr25c-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r25c-arm64",
	opensslConf = "o3_0aa6nV25L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=arm64-v8a
	]],
}

conf.q6_5lx6_ax6nV25 = {
	name = "Qt6.5.3-Android-x86_64-Clang-NDKr25c-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r25c-x86_64",
	opensslConf = "o3_0ax6nV25L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=x86_64
	]],
}

conf.q6_5mal_aa3nV25 = {
	name = "Qt6.5.3-Android-arm-Clang-NDKr25c-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "macOSM1",
	target = "Android-27",
	toolchainT = "Android-27-r25c-arm",
	opensslConf = "o3_0aa3nV25L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=armeabi-v7a
	]],
}

conf.q6_5mal_aa6nV25 = {
	name = "Qt6.5.3-Android-arm64-Clang-NDKr25c-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "macOSM1",
	target = "Android-27",
	toolchainT = "Android-27-r25c-arm64",
	opensslConf = "o3_0aa6nV25L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=arm64-v8a
	]],
}

conf.q6_5mal_ax6nV25 = {
	name = "Qt6.5.3-Android-x86_64-Clang-NDKr25c-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "macOSM1",
	target = "Android-27",
	toolchainT = "Android-27-r25c-x86_64",
	opensslConf = "o3_0ax6nV25L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=x86_64
	]],
}

conf.q6_5wx6g2_aa3nV26 = {
	name = "Qt6.5.3-Android-arm-Clang-NDKr26d-xWindows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.5.3",
	host = "Win10",
	target = "Android-27",
	toolchain = "MinGW1220-64",
	toolchainT = "Android-27-r26d-arm",
	opensslConf = "o3_0aa3nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=armeabi-v7a
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_5wx6g2_aa6nV26 = {
	name = "Qt6.5.3-Android-arm64-Clang-NDKr26d-xWindows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.5.3",
	host = "Win10",
	target = "Android-27",
	toolchain = "MinGW1220-64",
	toolchainT = "Android-27-r26d-arm64",
	opensslConf = "o3_0aa6nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=arm64-v8a
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_5wx6g2_ax6nV26 = {
	name = "Qt6.5.3-Android-x86_64-Clang-NDKr26d-xWindows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.5.3",
	host = "Win10",
	target = "Android-27",
	toolchain = "MinGW1220-64",
	toolchainT = "Android-27-r26d-x86_64",
	opensslConf = "o3_0ax6nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=x86_64
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_5lx6_aa3nV26 = {
	name = "Qt6.5.3-Android-arm-Clang-NDKr26d-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r26d-arm",
	opensslConf = "o3_0aa3nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=armeabi-v7a
	]],
}

conf.q6_5lx6_aa6nV26 = {
	name = "Qt6.5.3-Android-arm64-Clang-NDKr26d-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r26d-arm64",
	opensslConf = "o3_0aa6nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=arm64-v8a
	]],
}

conf.q6_5lx6_ax6nV26 = {
	name = "Qt6.5.3-Android-x86_64-Clang-NDKr26d-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r26d-x86_64",
	opensslConf = "o3_0ax6nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=x86_64
	]],
}

conf.q6_5mal_aa3nV26 = {
	name = "Qt6.5.3-Android-arm-Clang-NDKr26d-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "macOSM1",
	target = "Android-27",
	toolchainT = "Android-27-r26d-arm",
	opensslConf = "o3_0aa3nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=armeabi-v7a
	]],
}

conf.q6_5mal_aa6nV26 = {
	name = "Qt6.5.3-Android-arm64-Clang-NDKr26d-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "macOSM1",
	target = "Android-27",
	toolchainT = "Android-27-r26d-arm64",
	opensslConf = "o3_0aa6nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=arm64-v8a
	]],
}

conf.q6_5mal_ax6nV26 = {
	name = "Qt6.5.3-Android-x86_64-Clang-NDKr26d-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "macOSM1",
	target = "Android-27",
	toolchainT = "Android-27-r26d-x86_64",
	opensslConf = "o3_0ax6nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=x86_64
	]],
}

-- WebAssembly uses emcmake which don't need a toolchain file
conf.q6_5wx6g2_W = {
	name = "Qt6.5.3-WebAssembly-emscripten&TARGETTOOLVERSION&-xWindows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.5.3",
	host = "Win10",
	toolchain = "MinGW1220-64",
	target = "WebAssembly",
	toolchainT = "emscripten-3.1.25",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DQT_QMAKE_TARGET_MKSPEC=wasm-emscripten
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DBUILD_WITH_PCH=ON
		-DFEATURE_thread=ON
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=OFF
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_5lx6_W = {
	name = "Qt6.5.3-WebAssembly-emscripten&TARGETTOOLVERSION&-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "Rocky9",
	target = "WebAssembly",
	toolchainT = "emscripten-3.1.25",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DQT_QMAKE_TARGET_MKSPEC=wasm-emscripten
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DBUILD_WITH_PCH=ON
		-DFEATURE_thread=ON
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=OFF
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_5mal_W = {
	name = "Qt6.5.3-WebAssembly-emscripten&TARGETTOOLVERSION&-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.5.3",
	host = "macOSM1",
	target = "WebAssembly",
	toolchainT = "emscripten-3.1.25",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DQT_QMAKE_TARGET_MKSPEC=wasm-emscripten
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DBUILD_WITH_PCH=ON
		-DFEATURE_thread=ON
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=OFF
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
	]],
}

--------------------------------------------------------------------

conf.q6_7wx6v9 = {
	name = "Qt6.7.2-Windows-x86_64-VS2019-&HOSTTOOLVERSION&",
	qtVersion = "6.7.2",
	host = "Win10",
	toolchain = "MSVC2019-64",
	opensslConf = "o3_0wx6v9",
	mysqlConf = "m3_3wx6v9",
	useCMake = "Latest",
	useNode = "18",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\libmariadb.lib"
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_webengine_proprietary_codecs=ON
		-DFEATURE_qtpdf_build=ON
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_7wx6v2 = {
	name = "Qt6.7.2-Windows-x86_64-VS2022-&HOSTTOOLVERSION&",
	qtVersion = "6.7.2",
	host = "Win10",
	toolchain = "MSVC2022-64",
	opensslConf = "o3_0wx6v2",
	mysqlConf = "m3_3wx6v2",
	useCMake = "Latest",
	useNode = "18",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\libmariadb.lib"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_7wa6v2 = {
	name = "Qt6.7.2-Windows-arm64-VS2022-&HOSTTOOLVERSION&",
	qtVersion = "6.7.2",
	host = "Win10Arm",
	toolchain = "MSVC2022-arm64",
	opensslConf = "o3_0wa6v2",
	mysqlConf = "m3_3wa6v2",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\libmariadb.lib"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
	]],
}

conf.q6_7wx6p3 = {
	name = "Qt6.7.2-Windows-x86_64-MinGW&HOSTTOOLVERSION&-ucrt",
	qtVersion = "6.7.2",
	host = "Win10",
	toolchain = "MinGW132u-64",
	opensslConf = "o3_0wx6p3",
	mysqlConf = "m3_3wx6p3",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_7wx6g3 = {
	name = "Qt6.7.2-Windows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.7.2",
	host = "Win10",
	toolchain = "MinGW1320-64",
	opensslConf = "o3_0wx6g3",
	mysqlConf = "m3_3wx6g3",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_7wx6g3st = {
	name = "Qt6.7.2-Windows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt-static",
	qtVersion = "6.7.2",
	host = "Win10",
	toolchain = "MinGW1320-64",
	variant = {"-static(Lite)"},
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DFEATURE_static_runtime=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DFEATURE_openssl=OFF
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
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtgraphs=OFF
		-DBUILD_qthttpserver=OFF
		-DBUILD_qtlanguageserver=OFF
		-DBUILD_qtlocation=OFF
		-DBUILD_qtlottie=OFF
		-DBUILD_qtmqtt=OFF
		-DBUILD_qtnetworkauth=OFF
		-DBUILD_qtpositioning=OFF
		-DBUILD_qtquick3dphysics=OFF
		-DBUILD_qtquicktimeline=OFF
		-DBUILD_qtsensors=OFF
		-DBUILD_qtserialbus=OFF
		-DBUILD_qtserialport=OFF
		-DBUILD_qtspeech=OFF
		-DBUILD_qtvirtualkeyboard=OFF
		-DBUILD_qtwayland=OFF
		-DBUILD_qtwebchannel=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtwebsockets=OFF
		-DBUILD_qtwebview=OFF
		-DCMAKE_EXE_LINKER_FLAGS="--static -static-libgcc -static-libstdc++"
	]],
}

conf.q6_7wx6p4 = {
	name = "Qt6.7.2-Windows-x86_64-MinGW&HOSTTOOLVERSION&-ucrt",
	qtVersion = "6.7.2",
	host = "Win10",
	toolchain = "MinGW141u-64",
	opensslConf = "o3_0wx6p4",
	mysqlConf = "m3_3wx6p4",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_7wx6g4 = {
	name = "Qt6.7.2-Windows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.7.2",
	host = "Win10",
	toolchain = "MinGW1410-64",
	opensslConf = "o3_0wx6g4",
	mysqlConf = "m3_3wx6g4",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_7wx6u8 = {
	name = "Qt6.7.2-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-ucrt",
	qtVersion = "6.7.2",
	host = "Win10",
	toolchain = "MinGWLLVM-ucrt18-64",
	opensslConf = "o3_0wx6u8",
	mysqlConf = "m3_3wx6u8",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_7wx6s8 = {
	name = "Qt6.7.2-Windows-x86_64-llvm-mingw-&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.7.2",
	host = "Win10",
	toolchain = "MinGWLLVM-msvcrt18-64",
	opensslConf = "o3_0wx6s8",
	mysqlConf = "m3_3wx6s8",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_schannel=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&\include\mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&\lib\mariadb\liblibmariadb.dll.a"
		-DFEATURE_system_sqlite=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_CXX_COMPILER="x86_64-w64-mingw32-clang++"
	]],
}

conf.q6_7lx6st = {
	name = "Qt6.7.2-Linux-x86_64-gcc&HOSTTOOLVERSION&-static",
	qtVersion = "6.7.2",
	host = "Rocky9",
	variant = {"-static(Lite)"},
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DFEATURE_static_runtime=ON
		-DCMAKE_BUILD_TYPE=Release
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
		-DBUILD_qtgraphs=OFF
		-DBUILD_qtgrpc=OFF
		-DBUILD_qthttpserver=OFF
		-DBUILD_qtlanguageserver=OFF
		-DBUILD_qtlocation=OFF
		-DBUILD_qtlottie=OFF
		-DBUILD_qtmqtt=OFF
		-DBUILD_qtnetworkauth=OFF
		-DBUILD_qtpositioning=OFF
		-DBUILD_qtquick3dphysics=OFF
		-DBUILD_qtquicktimeline=OFF
		-DBUILD_qtsensors=OFF
		-DBUILD_qtserialbus=OFF
		-DBUILD_qtserialport=OFF
		-DBUILD_qtspeech=OFF
		-DBUILD_qtvirtualkeyboard=OFF
		-DBUILD_qtwayland=OFF
		-DBUILD_qtwebchannel=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtwebsockets=OFF
		-DBUILD_qtwebview=OFF
	]],
}

conf.q6_7mal = {
	name = "Qt6.7.2-macOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.7.2",
	host = "macOSM1",
	opensslConf = "o3_0mal",
	mysqlConf = "m3_3mal",
	useCMake = "Latest",
	includeDeprecatedOdbcHeader = true,
	useNode = "18",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_OSX_ARCHITECTURES="x86_64;arm64"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DODBC_INCLUDE_DIR="&ODBCPREFIX&/include"
		-DODBC_LIBRARY=iodbc
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&/include/mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&/lib/mariadb/libmariadb.3.dylib"
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_webengine_proprietary_codecs=ON
		-DFEATURE_qtpdf_build=ON
		-DCMAKE_SKIP_BUILD_RPATH=OFF
		-DCMAKE_SKIP_INSTALL_RPATH=OFF
		-DFEATURE_framework=ON
		-DBUILD_qtgrpc=OFF
		-DCMAKE_BUILD_RPATH="&OPENSSLDIR&/lib"
	]],
}

conf.q6_7malnf = {
	name = "Qt6.7.2-macOS-Universal-AppleClang&HOSTTOOLVERSION&-noFramework",
	qtVersion = "6.7.2",
	host = "macOSM1",
	variant = {"-no-framework"},
	opensslConf = "o3_0mal",
	mysqlConf = "m3_3mal",
	useCMake = "Latest",
	includeDeprecatedOdbcHeader = true,
	useNode = "18",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_OSX_ARCHITECTURES="x86_64;arm64"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_securetransport=ON
		-DFEATURE_sql_sqlite=ON
		-DFEATURE_sql_odbc=ON
		-DFEATURE_sql_mysql=ON
		-DODBC_INCLUDE_DIR="&ODBCPREFIX&/include"
		-DODBC_LIBRARY=iodbc
		-DMySQL_INCLUDE_DIR="&MYSQLPREFIX&/include/mariadb"
		-DMySQL_LIBRARY="&MYSQLPREFIX&/lib/mariadb/libmariadb.3.dylib"
		-DFEATURE_system_sqlite=OFF
		-DFEATURE_webengine_proprietary_codecs=ON
		-DFEATURE_qtpdf_build=ON
		-DCMAKE_SKIP_BUILD_RPATH=OFF
		-DCMAKE_SKIP_INSTALL_RPATH=OFF
		-DFEATURE_framework=OFF
		-DBUILD_qtgrpc=OFF
		-DCMAKE_BUILD_RPATH="&OPENSSLDIR&/lib"
	]],
}

conf.q6_7malst = {
	name = "Qt6.7.2-macOS-Universal-AppleClang&HOSTTOOLVERSION&-static",
	qtVersion = "6.7.2",
	host = "macOSM1",
	variant = {"-static(Lite)"},
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_OSX_ARCHITECTURES="x86_64;arm64"
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
		-DFEATURE_openssl=OFF
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
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtgraphs=OFF
		-DBUILD_qthttpserver=OFF
		-DBUILD_qtlanguageserver=OFF
		-DBUILD_qtlocation=OFF
		-DBUILD_qtlottie=OFF
		-DBUILD_qtmqtt=OFF
		-DBUILD_qtnetworkauth=OFF
		-DBUILD_qtpositioning=OFF
		-DBUILD_qtquick3dphysics=OFF
		-DBUILD_qtquicktimeline=OFF
		-DBUILD_qtsensors=OFF
		-DBUILD_qtserialbus=OFF
		-DBUILD_qtserialport=OFF
		-DBUILD_qtspeech=OFF
		-DBUILD_qtvirtualkeyboard=OFF
		-DBUILD_qtwayland=OFF
		-DBUILD_qtwebchannel=OFF
		-DBUILD_qtwebengine=OFF
		-DBUILD_qtwebsockets=OFF
		-DBUILD_qtwebview=OFF
	]],
}

conf.q6_7wx6g3_aa3nV26 = {
	name = "Qt6.7.2-Android-arm-Clang-NDKr26d-xWindows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.7.2",
	host = "Win10",
	target = "Android-27",
	toolchain = "MinGW1320-64",
	toolchainT = "Android-27-r26d-arm",
	opensslConf = "o3_0aa3nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=armeabi-v7a
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_7wx6g3_aa6nV26 = {
	name = "Qt6.7.2-Android-arm64-Clang-NDKr26d-xWindows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.7.2",
	host = "Win10",
	target = "Android-27",
	toolchain = "MinGW1320-64",
	toolchainT = "Android-27-r26d-arm64",
	opensslConf = "o3_0aa6nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=arm64-v8a
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_7wx6g3_ax6nV26 = {
	name = "Qt6.7.2-Android-x86_64-Clang-NDKr26d-xWindows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.7.2",
	host = "Win10",
	target = "Android-27",
	toolchain = "MinGW1320-64",
	toolchainT = "Android-27-r26d-x86_64",
	opensslConf = "o3_0ax6nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&\build\cmake\android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=x86_64
		-DCMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH=ON
	]],
}

conf.q6_7lx6_aa3nV26 = {
	name = "Qt6.7.2-Android-arm-Clang-NDKr26d-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.7.2",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r26d-arm",
	opensslConf = "o3_0aa3nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=armeabi-v7a
	]],
}

conf.q6_7lx6_aa6nV26 = {
	name = "Qt6.7.2-Android-arm64-Clang-NDKr26d-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.7.2",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r26d-arm64",
	opensslConf = "o3_0aa6nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=arm64-v8a
	]],
}

conf.q6_7lx6_ax6nV26 = {
	name = "Qt6.7.2-Android-x86_64-Clang-NDKr26d-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.7.2",
	host = "Rocky9",
	target = "Android-27",
	toolchainT = "Android-27-r26d-x86_64",
	opensslConf = "o3_0ax6nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=x86_64
	]],
}

conf.q6_7mal_aa3nV26 = {
	name = "Qt6.7.2-Android-arm-Clang-NDKr26d-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.7.2",
	host = "macOSM1",
	target = "Android-27",
	toolchainT = "Android-27-r26d-arm",
	opensslConf = "o3_0aa3nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=armeabi-v7a
	]],
}

conf.q6_7mal_aa6nV26 = {
	name = "Qt6.7.2-Android-arm64-Clang-NDKr26d-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.7.2",
	host = "macOSM1",
	target = "Android-27",
	toolchainT = "Android-27-r26d-arm64",
	opensslConf = "o3_0aa6nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=arm64-v8a
	]],
}

conf.q6_7mal_ax6nV26 = {
	name = "Qt6.7.2-Android-x86_64-Clang-NDKr26d-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.7.2",
	host = "macOSM1",
	target = "Android-27",
	toolchainT = "Android-27-r26d-x86_64",
	opensslConf = "o3_0ax6nV26L27",
	useCMake = "Latest",
	androidSdkVersion = "20240205",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
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
		-DOPENSSL_ROOT_DIR="&OPENSSLDIR&"
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
		-DBUILD_qtwebengine=OFF
		-DANDROID_SDK_ROOT="&ANDROIDSDKROOT&"
		-DCMAKE_TOOLCHAIN_FILE="&ANDROIDNDKROOT&/build/cmake/android.toolchain.cmake"
		-DANDROID_NATIVE_API_LEVEL=27
		-DANDROID_PLATFORM=27
		-DANDROID_ABI=x86_64
	]],
}

-- WebAssembly uses emcmake which don't need a toolchain file
conf.q6_7wx6g3_W = {
	name = "Qt6.7.2-WebAssembly-emscripten&TARGETTOOLVERSION&-xWindows-x86_64-MinGW&HOSTTOOLVERSION&-msvcrt",
	qtVersion = "6.7.2",
	host = "Win10",
	toolchain = "MinGW1320-64",
	target = "WebAssembly",
	toolchainT = "emscripten-3.1.50",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DQT_QMAKE_TARGET_MKSPEC=wasm-emscripten
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DBUILD_WITH_PCH=ON
		-DFEATURE_thread=ON
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=OFF
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_7lx6_W = {
	name = "Qt6.7.2-WebAssembly-emscripten&TARGETTOOLVERSION&-xLinux-x86_64-gcc&HOSTTOOLVERSION&",
	qtVersion = "6.7.2",
	host = "Rocky9",
	target = "WebAssembly",
	toolchainT = "emscripten-3.1.50",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DQT_QMAKE_TARGET_MKSPEC=wasm-emscripten
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DBUILD_WITH_PCH=ON
		-DFEATURE_thread=ON
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=OFF
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
	]],
}

conf.q6_7mal_W = {
	name = "Qt6.7.2-WebAssembly-emscripten&TARGETTOOLVERSION&-xmacOS-Universal-AppleClang&HOSTTOOLVERSION&",
	qtVersion = "6.7.2",
	host = "macOSM1",
	target = "WebAssembly",
	toolchainT = "emscripten-3.1.50",
	useCMake = "Latest",
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX="&INSTALLROOT&"
		-DQT_HOST_PATH="&HOSTQTDIR&"
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS=OFF
		-DQT_QMAKE_TARGET_MKSPEC=wasm-emscripten
		-DQT_BUILD_EXAMPLES=OFF
		-DQT_BUILD_TESTS=OFF
		-DBUILD_WITH_PCH=ON
		-DFEATURE_thread=ON
		-DFEATURE_doubleconversion=ON
		-DFEATURE_system_doubleconversion=OFF
		-DFEATURE_system_zlib=OFF
		-DFEATURE_system_pcre2=OFF
		-DFEATURE_icu=OFF
		-DFEATURE_opengles2=ON
		-DFEATURE_ssl=OFF
		-DFEATURE_sql_sqlite=ON
		-DBUILD_qtgrpc=OFF
	]],
}

local Qt6StaticConf = {
	Win10 = {
		["6.2.9"] = "q6_2wx6g1st",
		["6.5.3"] = "q6_5wx6g2st",
		["6.7.2"] = "q6_7wx6g3st",
	},
	CentOS8 = {
		["6.2.9"] = "q6_2lx6st",
	},
	Rocky9 = {
		["6.5.3"] = "q6_5lx6st",
		["6.7.2"] = "q6_7lx6st",
	},
	macOSM1 = {
		["6.2.9"] = "q6_2malst",
		["6.5.3"] = "q6_5malst",
		["6.7.2"] = "q6_7malst",
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
	if not value.name then
		io.stderr:write("no name for config " .. name .. "\n")
		io.stderr:flush()
		os.exit(1)
	end

	if not value.qtVersion then
		io.stderr:write("no qtVersion for config " .. name .. "\n")
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

local Win10SrcPackagePrefixWorkaroundVersions = {
	"5.15.14-3",
	"6.2.9",
	"6.5.3",
	"6.7.2",
}

for name, value in pairs(conf) do
	if value.target and (value.target ~= value.host) then
		value.crossCompile = true
	else
		value.crossCompile = false
	end

	value.variant = value.variant or {}

	local qtVersionSplit = split(value.qtVersion, ".")
	local qtSourcePackagePrefix = "qt-everywhere-src-"
	if value.host == "Win10" then
		for _, waVersion in ipairs(Win10SrcPackagePrefixWorkaroundVersions) do
			if value.qtVersion == waVersion then
				qtSourcePackagePrefix = "qt-src-"
				break
			end
		end
	end

	value.sourcePackageBaseName = qtSourcePackagePrefix .. value.qtVersion

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

	if tonumber(qtVersionSplit[1]) == 6 and value.crossCompile then
		-- cross build of MSVC target needs same version of MSVC host
		local valuehost = value.host
		if string.sub(value.toolchain, 1, 4) == "MSVC" then
			valuehost = value.host .. string.sub(value.toolchain, 1, 8)
		end
		local staticConfVersion = string.gsub(value.qtVersion, [[^(%d+%.%d+%.%d+)(%-?%d*)$]], "%1")
		value.hostToolsConf = Qt6StaticConf[valuehost][staticConfVersion]
		value.hostToolsUrlwin = "http://10.31.42.6:8080/job/Qt/job/" .. value.hostToolsConf .. "/lastSuccessfulBuild/artifact/buildDir/" .. conf[value.hostToolsConf].name .. ".7z"
		value.hostToolsUrlunix = "http://10.31.42.6:8080/job/Qt/job/" .. value.hostToolsConf .. "/lastSuccessfulBuild/artifact/buildDir/" .. conf[value.hostToolsConf].name .. ".tar.xz"
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
