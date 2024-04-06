
local compare = {}

local compareVersion = function(a, b)
	-- all of Qt, OpenSSL and MariaDB uses a format similar to semver
	-- so there are major.minor.patch version format

	local parseVersionNum = function(str)
		return string.match(str, "(%d+)%.(%d+)%.(%d+)")
	end

	local a1, a2, a3 = parseVersionNum(a)
	local b1, b2, b3 = parseVersionNum(b)

	if a1 ~= b1 then
		return a1 < b1
	end

	if a2 ~= b2 then
		return a2 < b2
	end

	return a3 < b3
end

local unknownMetaTable = {
	__index = function(table, key)
		table.max = table.max + 1
		table[key] = table.max
		return table.max
	end
}

local toolchainArchitecturePlatformSequence = setmetatable({
	-- unspecified
	[""] = 0,

	-- Windows - MSVC
	wx3v5 = 112014,
	wx6v5 = 112015,
	wx3v7 = 112016,
	wx6v7 = 112017,
	wx3v9 = 112018,
	wx6v9 = 112019,
	wx6v2 = 112022,
	wa6v2 = 112023,

	-- Windows - MinGW w/ GCC
	wx3g8 = 120815,
	wx6g8 = 120816,
	wx6g1 = 121126,
	wx6p2 = 121221,
	wx6g2 = 121226,
	wx6p3 = 121321,
	wx6g3 = 121326,

	-- Windows - MinGW w/ LLVM
	wx6u6 = 131601,
	wx6s6 = 131606,
	wx6u7 = 131701,
	wx6s7 = 131706,
	wx6u8 = 131811,
	wx6s8 = 131816,

	lx6 = 200000,

	ma6 = 300000,
	mx6 = 310000,

	-- Android NDK
	-- 400??2 is reserved for RISC-V
	aalnV21 = 400210,
	aa6nV21 = 400211,
	aa3nV21 = 400213,
	ax6nV21 = 400214,
	ax3nV21 = 400215,
	aalnV23 = 400230,
	aa6nV23 = 400231,
	aa3nV23 = 400233,
	ax6nV23 = 400234,
	ax3nV23 = 400235,
	aalnV25 = 400250,
	aa6nV25 = 400251,
	aa3nV25 = 400253,
	ax6nV25 = 400254,
	ax3nV25 = 400255,
	aalnV26 = 400260,
	aa6nV26 = 400261,
	aa3nV26 = 400263,
	ax6nV26 = 400264,
	ax3nV26 = 400265,
	-- ar6nV27 = 400272,

	W = 500000,

	max = 100000,
}, unknownMetaTable)

local extractToolchainPlatformArchitecture = function(buildInfo)
	local prefixToolchainMap = {
		-- MSVC
		MSVC2015 = "v5",
		MSVC2017 = "v7",
		MSVC2019 = "v9",
		MSVC2022 = "v2",

		MinGW810 = "g8",
		MinGW1120 = "g1",
		MinGW122u = "p2",
		MinGW1220 = "g2",
		MinGW132u = "p3",
		MinGW1320 = "g3",

		["MinGWLLVM-ucrt16"] = "u6",
		["MinGWLLVM-msvcrt16"] = "s6",
		["MinGWLLVM-ucrt17"] = "u7",
		["MinGWLLVM-msvcrt17"] = "s7",
		["MinGWLLVM-ucrt18"] = "u8",
		["MinGWLLVM-msvcrt18"] = "s8",

		["Android-r21"] = "nV21",
		["Android-r23"] = "nV23",
		["Android-r25"] = "nV25",
		["Android-r26"] = "nV26",
	}

	local toolchainPlatformMap = {
		["MSVC"] = "Windows",
		["MinGW"] = "Windows",
		["Android"] = "Android",
		["emscripten"] = "WebAssembly",
	}
	local platformSequenceMap = {
		Windows = "w",
		Linux = "l",
		macOS = "m",
		Android = "a",
		WebAssembly = "W",
	}

	local archPlatformMap = {
		["ALL"] = "al",
		["x86"] = "x3",
		["x86_64"] = "x6",
		["arm"] = "a3",
		["arm64"] = "a6", -- aarch64 or arm64?
		["riscv64"] = "r6",
	}

	local platform = buildInfo.buildTarget
	local toolchain = buildInfo.buildTargetToolchain
	local arch = buildInfo.buildTargetArch
	if string.sub(buildInfo.buildTargetToolchain, 1, 7) == "Android" then
		toolchain = "Android-" .. string.sub(buildInfo.buildTargetToolchainVersion, 1, 3)
		platform = "Android"
	end

	local extractedToolchain
	for k, v in pairs(prefixToolchainMap) do
		if string.sub(toolchain, 1, string.len(k)) == k then
			extractedToolchain = v
			break
		end
	end
	extractedToolchain = extractedToolchain or ""

	if not platform then
		for k, v in pairs(toolchainPlatformMap) do
			if string.sub(buildInfo.buildTargetToolchain, 1, string.len(k)) == k then
				platform = v
				break
			end
		end
	end
	platform = platform or ""
	local extractedPlatform = platformSequenceMap[platform] or ""

	if string.sub(arch, 1, 9) == "Universal" then
		arch = "ALL"
	end
	
	local extractedArch = archPlatformMap[arch] or ""

	return extractedPlatform .. extractedArch .. extractedToolchain
end

-- This compare method is for generating the "sort" field of each item
compare.byConfiguration = function(a, b)
	-- in fact buildContent is not needed here
	-- provided for strong sequence guarantee
	if a.buildContent ~= b.buildContent then
		return a.buildContent < b.buildContent
	end

	if a.buildContentVersion ~= b.buildContentVersion then
		return compareVersion(a.buildContentVersion, b.buildContentVersion)
	end

	-- The sequence is: Windows < Linux < macOS < Android < WebAssembly
	-- see above platfromSequence
	if string.sub(a.buildTarget, 1, 2) ~= string.sub(b.buildTarget, 1, 2) then
		return platformSequence[string.sub(a.buildTarget, 1, 2)] ~= platformSequence[string.sub(b.buildTarget, 1, 2)]
	end

	local aNdk, bNdk = 0, 0
	if string.sub(a.buildTarget, 1, 8) == "Android-" then
		aNdk = tonumber(string.sub(a.buildTarget, 9))
	end
	if string.sub(b.buildTarget, 1, 8) == "Android-" then
		bNdk = tonumber(string.sub(b.buildTarget, 9))
	end
	if aNdk ~= bNdk then
		return aNdk < bNdk
	end

	local atpa, btpa = extractToolchainPlatformArchitecture(a), extractToolchainPlatformArchitecture(b)
	if atpa ~= btpa then
		return toolchainArchitecturePlatformSequence[atpa] < toolchainArchitecturePlatformSequence[btpa]
	end

	if a.buildVariant ~= b.buildVariant then
		return variantSequence[matchA.variant] < variantSequence[matchB.variant]
	end

	-- All signature has been compared for now! I have no way but...
	return a.buildContentVersion < b.buildContentVersion
end

local pathPrefixForBuildTargetArchAndToolchainVersion = function(target, arch, toolchainVersion)
	if target == "Windows" then
		-- This expects change
		-- There is too many toolchain variants in current build: MSVC / MinGW-GCC / MinGW-LLVM, and there is an amazing amount of 18 builds in one single directory!
		-- So it need subdirectory (will be considered in next whole rebuild):

		-- MSVC for Visual Studio builds
		-- MinGW-GCC for MinGW w/ GCC (niXman) builds
		-- MinGW-LLVM for MinGW w/ LLVM (mstorsjo) builds

		local partA

		if arch == "x86" then
			partA = "Windows-x86/"
		elseif arch == "x86_64" then
			partA = "Windows-x86_64/"
		elseif arch == "arm64" then
			partA = "Windows-arm64/"
		else
			-- not recognized	
		end

		local partB

		if string.sub(toolchainVersion, 1, 4) == "MSVC" then
			partB = "MSVC/"
		elseif string.sub(toolchainVersion, 1, 9) == "MinGWLLVM" then
			partB = "MinGW-LLVM/"
		elseif string.sub(toolchainVersion, 1, 5) == "MinGW" then
			partB = "MinGW-GCC/"
		else
			-- not recognized
		end

		if partA and partB then
			return partA .. partB
		end
	elseif target == "Linux" then
		-- never uploaded
	elseif target == "macOS" then
		-- actually arm64 ones are only used in early days of Qt built, since after that universal binaries are built and single architecture ones are deleted.
		-- Universal builds now ships with Qt 5.15 and later, which are all versions we are currently building, so recognize only Universal here
		if arch == "Universal (x86_64, arm64)" then
			return "macOS-Universal/"
		else
			-- unrecognized
		end
	elseif string.sub(target, 1, 7) == "Android" then
		-- only layouts of Qt 5.15 onwards are honored
		-- Qt 5.12 layouts (flatten) / pre-Qt 5.9 layouts (host based directory structure) are ignored
		return "Android/" .. string.sub(toolchainVersion, 1, 3) .. "/"
	elseif target == "WebAssembly" then
		return "WebAssembly/"
	end

	return "/"
end

compare.byDirectoryHirachey = function(a, b)
	local dirA, dirB = pathPrefixForBuildTargetArchAndToolchainVersion(a), pathPrefixForBuildTargetArchAndToolchainVersion(b)
	return (dirA .. a.INSTALLPATH) < (dirB .. b.INSTALLPATH)
end

return compare
