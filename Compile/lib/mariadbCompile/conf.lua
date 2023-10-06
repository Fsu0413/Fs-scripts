
local conf = {}

--[[
abbrs:
	mariadb Versions:
		m3_1: mariadb connector C 3.1.22
		m3_3: mariadb connector C 3.3.7

	Platforms:
		w: Windows
		m: macOS
	Other platforms will be added when supported.

	Supported Architectures:
		x3: x86
		x6: x86_64
		a6: arm64
		al: All architectures
	Other architectures will be added when supported.

	Toolchains: (especially, not in system PATH by default)
		v5: VS2015
		v7: VS2017
		v9: VS2019
		v2: VS2022
		g7: MinGW-w64, with GCC 7.3.0
		g8: MinGW-w64, with GCC 8.1.0
		g1: MinGW-w64, with GCC 11.2.0
		g2: MinGW-w64, msvcrt, with GCC 12.2.0
		p2: MinGW-w64, ucrt, with GCC 12.2.0
		g3: MinGW-w64, msvcrt, with GCC 13.2.0
		p3: MinGW-w64, ucrt, with GCC 13.2.0
		s5: LLVM/Clang based MinGW-w64, msvcrt, with LLVM 15
		u5: LLVM/Clang based MinGW-w64, ucrt, with LLVM 15
		s6: LLVM/Clang based MinGW-w64, msvcrt, with LLVM 16
		u6: LLVM/Clang based MinGW-w64, ucrt, with LLVM 16
		s7: LLVM/Clang based MinGW-w64, msvcrt, with LLVM 17
		u7: LLVM/Clang based MinGW-w64, ucrt, with LLVM 17
	If omitted, it use a toolchain in default PATH, which should be AppleClang in macOS, or GCC in Linux.
]]

--------------------------------------------------------------------

-- mariadb connector 3.1.22

conf.m3_1wx3v5 = {
	name = "mariadb_connector_c3.1.22-Windows-x86-VS2015",
	mariadbVersion = "3.1.22",
	host = "Win8",
	toolchain = "MSVC2015-32",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-wd4244"
	]],
}

conf.m3_1wx6v5 = {
	name = "mariadb_connector_c3.1.22-Windows-x86_64-VS2015",
	mariadbVersion = "3.1.22",
	host = "Win8",
	toolchain = "MSVC2015-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-wd4244"
	]],
}

conf.m3_1wx3v7 = {
	name = "mariadb_connector_c3.1.22-Windows-x86-VS2017-&TARGETTOOLVERSION&",
	mariadbVersion = "3.1.22",
	host = "Win10",
	toolchain = "MSVC2017-32",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-wd4244"
	]],
}

conf.m3_1wx6v7 = {
	name = "mariadb_connector_c3.1.22-Windows-x86_64-VS2017-&TARGETTOOLVERSION&",
	mariadbVersion = "3.1.22",
	host = "Win10",
	toolchain = "MSVC2017-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-wd4244"
	]],
}

conf.m3_1wx3v9 = {
	name = "mariadb_connector_c3.1.22-Windows-x86-VS2019-&TARGETTOOLVERSION&",
	mariadbVersion = "3.1.22",
	host = "Win10",
	toolchain = "MSVC2019-32",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-wd4244"
	]],
}

conf.m3_1wx6v9 = {
	name = "mariadb_connector_c3.1.22-Windows-x86_64-VS2019-&TARGETTOOLVERSION&",
	mariadbVersion = "3.1.22",
	host = "Win10",
	toolchain = "MSVC2019-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-wd4244"
	]],
}

conf.m3_1wx6v2 = {
	name = "mariadb_connector_c3.1.22-Windows-x86_64-VS2022-&TARGETTOOLVERSION&",
	mariadbVersion = "3.1.22",
	host = "Win10",
	toolchain = "MSVC2022-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-wd4244"
	]],
}

--------------------------------------------------------------------

-- build failed due to conflicting function definition???
conf.m3_1wx3g8 = {
	name = "mariadb_connector_c3.1.22-Windows-x86-MinGW-GCC&TARGETTOOLVERSION&",
	mariadbVersion = "3.1.22",
	host = "Win10",
	toolchain = "MinGW810-32",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWITH_SSL=OFF
		-DCMAKE_C_FLAGS="-Dstrerror_r(a,b,c)=strerror_s(b,c,a)"
	]],
}

conf.m3_1wx6g8 = {
	name = "mariadb_connector_c3.1.22-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&",
	mariadbVersion = "3.1.22",
	host = "Win10",
	toolchain = "MinGW810-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWITH_SSL=OFF
		-DCMAKE_C_FLAGS="-Dstrerror_r(a,b,c)=strerror_s(b,c,a)"
	]],
}

--------------------------------------------------------------------

conf.m3_1mal = {
	name = "mariadb_connector_c3.1.22-macOS-ALL-AppleClang&TARGETTOOLVERSION&",
	mariadbVersion = "3.1.22",
	host = "macOSM1",
	libPath = { "lib/mariadb/libmariadb.3.dylib" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_REMOTE_IO=STATIC
		-DWITH_SSL=OFF
		-DCMAKE_C_FLAGS=-Wno-implicit-function-declaration
		-DCMAKE_OSX_ARCHITECTURES="x86_64;arm64"
		-DCMAKE_OSX_DEPLOYMENT_TARGET="10.13"
	]],
}

--------------------------------------------------------------------

-- mariadb connector 3.3.7

conf.m3_3wx6v9 = {
	name = "mariadb_connector_c3.3.7-Windows-x86_64-VS2019-&TARGETTOOLVERSION&",
	mariadbVersion = "3.3.7",
	host = "Win10",
	toolchain = "MSVC2019-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWITH_SSL=SCHANNEL
		-DWARNING_AS_ERROR=
		-DCMAKE_C_FLAGS="-wd4244"
	]],
}

conf.m3_3wx6v2 = {
	name = "mariadb_connector_c3.3.7-Windows-x86_64-VS2022-&TARGETTOOLVERSION&",
	mariadbVersion = "3.3.7",
	host = "Win10",
	toolchain = "MSVC2022-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWARNING_AS_ERROR=
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-wd4244"
	]],
}

--------------------------------------------------------------------

conf.m3_3wx6g1 = {
	name = "mariadb_connector_c3.3.7-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&",
	mariadbVersion = "3.3.7",
	host = "Win10",
	toolchain = "MinGW1120-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWARNING_AS_ERROR=
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-Dstrerror_r(a,b,c)=strerror_s(b,c,a)"
	]],
}

conf.m3_3wx6p2 = {
	name = "mariadb_connector_c3.3.7-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&-ucrt",
	mariadbVersion = "3.3.7",
	host = "Win10",
	toolchain = "MinGW122u-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWARNING_AS_ERROR=
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-Dstrerror_r(a,b,c)=strerror_s(b,c,a)"
	]],
}

conf.m3_3wx6g2 = {
	name = "mariadb_connector_c3.3.7-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&-msvcrt",
	mariadbVersion = "3.3.7",
	host = "Win10",
	toolchain = "MinGW1220-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWARNING_AS_ERROR=
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-Dstrerror_r(a,b,c)=strerror_s(b,c,a)"
	]],
}

conf.m3_3wx6p3 = {
	name = "mariadb_connector_c3.3.7-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&-ucrt",
	mariadbVersion = "3.3.7",
	host = "Win10",
	toolchain = "MinGW132u-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWARNING_AS_ERROR=
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-Dstrerror_r(a,b,c)=strerror_s(b,c,a)"
	]],
}

conf.m3_3wx6g3 = {
	name = "mariadb_connector_c3.3.7-Windows-x86_64-MinGW-GCC&TARGETTOOLVERSION&-msvcrt",
	mariadbVersion = "3.3.7",
	host = "Win10",
	toolchain = "MinGW1320-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWARNING_AS_ERROR=
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-Dstrerror_r(a,b,c)=strerror_s(b,c,a)"
	]],
}

--------------------------------------------------------------------

conf.m3_3wx6u5 = {
	name = "mariadb_connector_c3.3.7-Windows-x86_64-llvm-mingw-&TARGETTOOLVERSION&-ucrt",
	mariadbVersion = "3.3.7",
	host = "Win10",
	toolchain = "MinGWLLVM-ucrt15-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWARNING_AS_ERROR=
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-Dstrerror_r(a,b,c)=strerror_s(b,c,a)"
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
	]],
}

conf.m3_3wx6s5 = {
	name = "mariadb_connector_c3.3.7-Windows-x86_64-llvm-mingw-&TARGETTOOLVERSION&-msvcrt",
	mariadbVersion = "3.3.7",
	host = "Win10",
	toolchain = "MinGWLLVM-msvcrt15-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWARNING_AS_ERROR=
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-Dstrerror_r(a,b,c)=strerror_s(b,c,a)"
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
	]],
}

--------------------------------------------------------------------

conf.m3_3wx6u6 = {
	name = "mariadb_connector_c3.3.7-Windows-x86_64-llvm-mingw-&TARGETTOOLVERSION&-ucrt",
	mariadbVersion = "3.3.7",
	host = "Win10",
	toolchain = "MinGWLLVM-ucrt16-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWARNING_AS_ERROR=
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-Dstrerror_r(a,b,c)=strerror_s(b,c,a)"
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
	]],
}

conf.m3_3wx6s6 = {
	name = "mariadb_connector_c3.3.7-Windows-x86_64-llvm-mingw-&TARGETTOOLVERSION&-msvcrt",
	mariadbVersion = "3.3.7",
	host = "Win10",
	toolchain = "MinGWLLVM-msvcrt16-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWARNING_AS_ERROR=
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-Dstrerror_r(a,b,c)=strerror_s(b,c,a)"
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
	]],
}

--------------------------------------------------------------------

conf.m3_3wx6u7 = {
	name = "mariadb_connector_c3.3.7-Windows-x86_64-llvm-mingw-&TARGETTOOLVERSION&-ucrt",
	mariadbVersion = "3.3.7",
	host = "Win10",
	toolchain = "MinGWLLVM-ucrt17-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWARNING_AS_ERROR=
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-Dstrerror_r(a,b,c)=strerror_s(b,c,a)"
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
	]],
}

conf.m3_3wx6s7 = {
	name = "mariadb_connector_c3.3.7-Windows-x86_64-llvm-mingw-&TARGETTOOLVERSION&-msvcrt",
	mariadbVersion = "3.3.7",
	host = "Win10",
	toolchain = "MinGWLLVM-msvcrt17-64",
	libPath = { "lib\\mariadb\\libmariadb.dll" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_PVIO_NPIPE=STATIC
		-DCLIENT_PLUGIN_PVIO_SHMEM=STATIC
		-DWARNING_AS_ERROR=
		-DWITH_SSL=SCHANNEL
		-DCMAKE_C_FLAGS="-Dstrerror_r(a,b,c)=strerror_s(b,c,a)"
		-DCMAKE_C_COMPILER="x86_64-w64-mingw32-clang"
		-DCMAKE_ASM_COMPILER="x86_64-w64-mingw32-clang"
	]],
}

--------------------------------------------------------------------

conf.m3_3mal = {
	name = "mariadb_connector_c3.3.7-macOS-ALL-AppleClang&TARGETTOOLVERSION&",
	mariadbVersion = "3.3.7",
	host = "macOSM1",
	libPath = { "lib/mariadb/libmariadb.3.dylib" },
	configureParameter = [[
		-GNinja
		-DCMAKE_INSTALL_PREFIX=&INSTALLROOT&
		-DCMAKE_BUILD_TYPE="Release"
		-DCLIENT_PLUGIN_DIALOG=STATIC
		-DCLIENT_PLUGIN_CLIENT_ED25519=STATIC
		-DCLIENT_PLUGIN_CACHING_SHA2_PASSWORD=STATIC
		-DCLIENT_PLUGIN_SHA256_PASSWORD=STATIC
		-DCLIENT_PLUGIN_AUTH_GSSAPI_CLIENT=STATIC
		-DCLIENT_PLUGIN_MYSQL_CLEAR_PASSWORD=STATIC
		-DCLIENT_PLUGIN_REMOTE_IO=STATIC
		-DWARNING_AS_ERROR=
		-DWITH_SSL=OFF
		-DCMAKE_C_FLAGS=-Wno-implicit-function-declaration
		-DCMAKE_OSX_ARCHITECTURES="x86_64;arm64"
	]],
}

--------------------------------------------------------------------

for name, value in pairs(conf) do
	-- sanity check
	if not value.name then
		io.stderr:write("no name for config " .. name .. "\n")
		io.stderr:flush()
		os.exit(1)
	end

	if not value.mariadbVersion then
		io.stderr:write("no mariadbVersion for config " .. name .. "\n")
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

	if not value.variant then
		value.variant = {}
	end

	value.binaryPackageUrlunix = "http://172.24.13.6:8080/job/MariaDB/job/" .. name .. "/lastSuccessfulBuild/artifact/buildDir/" .. value.name .. ".tar.xz"
	value.sourcePackageUrlunix = "http://172.24.13.6/webdav/sources/mariadb-connector-c-" .. value.mariadbVersion .. "-src.tar.gz"
	value.sourcePackageBaseName = "mariadb-connector-c-" .. value.mariadbVersion .. "-src"
	value.binaryPackageUrlwin = "http://172.24.13.6:8080/job/MariaDB/job/" .. name .. "/lastSuccessfulBuild/artifact/buildDir/" .. value.name .. ".7z"
	value.sourcePackageUrlwin = "http://172.24.13.6/webdav/sources/mariadb-connector-c-" .. value.mariadbVersion .. "-src.zip"

	-- add dump function
	value.dump = function(self)
		local ret = name .. " - " .. self.name .. ":\n"
		ret = ret .. "\tMariaDB Version: " .. self.mariadbVersion .. "\n"
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
