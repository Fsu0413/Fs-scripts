#!/bin/bash

usage() {
	echo "Qt 6 Host tool deploy tool"
	echo "Usage:"
	echo "  $0 PATH_TO_TARGET PATH_TO_HOST"
	echo
	return 0
}

if [ $# -lt 2 ]; then
	echo "PATH_TO_TARGET and PATH_TO_HOST should be both set." >&2
	exit 1
fi

set -e

PATH_TO_TARGET=`realpath "$1"`
PATH_TO_HOST=`realpath "$2"`

# sanity
if [ ! -e "${PATH_TO_TARGET}/bin/target_qt.conf" ]; then
	echo "Target path $1 does not contain bin/target_qt.conf." >&2
	exit 1
fi

if [ ! -e "${PATH_TO_HOST}/bin/qt-cmake" ]; then
	echo "Host path $1 does not contain bin/qt-cmake." >&2
	exit 1
fi

mkdir "${PATH_TO_TARGET}/host"
cp -R "${PATH_TO_HOST}/bin" "${PATH_TO_TARGET}/host/"
[ -d "${PATH_TO_HOST}/libexec" ] && cp -R "${PATH_TO_HOST}/libexec" "${PATH_TO_TARGET}/host/"
mkdir "${PATH_TO_TARGET}/host/lib"
cp -R "${PATH_TO_HOST}/lib/cmake" "${PATH_TO_TARGET}/host/lib/"
cp -R "${PATH_TO_HOST}/lib/metatypes" "${PATH_TO_TARGET}/host/lib/"
find "${PATH_TO_HOST}/lib/" -name '*.prl' -maxdepth 1 -exec cp '{}' "${PATH_TO_TARGET}/host/lib" ';'

# qmake tweak

(
	echo '#!/bin/sh'
	echo
	echo "script_dir_path=\`dirname \$0\`"
	echo "script_dir_path=\`(cd \"\$script_dir_path\"; /bin/pwd)\`"
	echo
	echo "\$script_dir_path/../host/bin/qmake -qtconf \"\$script_dir_path/target_qt.conf\" \$*"
) > "${PATH_TO_TARGET}/bin/qmake"

chmod +x "${PATH_TO_TARGET}/bin/qmake"

(
	echo '#!/bin/sh'
	echo
	echo "script_dir_path=\`dirname \$0\`"
	echo "script_dir_path=\`(cd \"\$script_dir_path\"; /bin/pwd)\`"
	echo
	echo "\$script_dir_path/../host/bin/qtpaths -qtconf \"\$script_dir_path/target_qt.conf\" \$*"
) > "${PATH_TO_TARGET}/bin/qtpaths"

# judge if sed / gsed is GNU sed
GNU_SED=

for SED_PROGRAM in gsed sed; do
	GSED_OUTPUT="`LANG=C $SED_PROGRAM --help 2> /dev/null`"
	if [ $? -eq 0 ] ; then
		if echo "$GSED_OUTPUT" | grep -q -F "GNU sed"; then
			echo "Found GNU sed: $SED_PROGRAM"
			GNU_SED=$SED_PROGRAM
			break
		fi
	fi
done

# we have no idea but use default sed program
if [ x"$GNU_SED" = x ]; then
	GNU_SED=sed
fi

chmod +x "${PATH_TO_TARGET}/bin/qtpaths"

$GNU_SED -i -e 's,^HostPrefix=.*$,HostPrefix=../host,g' "${PATH_TO_TARGET}/bin/target_qt.conf"
$GNU_SED -i -e 's,^HostData=.*$,HostData=..,g' "${PATH_TO_TARGET}/bin/target_qt.conf"

# CMake tweak / Qt 6.4.1 +

$GNU_SED -i -e 's,^set(__qt_platform_initial_qt_host_path[[:space:]].*$,set(__qt_platform_initial_qt_host_path "${Qt6_DIR}/../../../host"),' "${PATH_TO_TARGET}/lib/cmake/Qt6/Qt6Dependencies.cmake"
$GNU_SED -i -e 's,^set(__qt_platform_initial_qt_host_path_cmake_dir[[:space:]].*$,set(__qt_platform_initial_qt_host_path_cmake_dir "${Qt6_DIR}/../../../host/lib/cmake"),' "${PATH_TO_TARGET}/lib/cmake/Qt6/Qt6Dependencies.cmake"

# CMake tweak / Qt 6.2.4

$GNU_SED -i -e '/^set(__qt_toolchain_initial_qt_host_path[[:space:]]*$/{N
c\
set(__qt_toolchain_initial_qt_host_path "${CMAKE_CURRENT_LIST_DIR}/../../../host")
d
}' "${PATH_TO_TARGET}/lib/cmake/Qt6/qt.toolchain.cmake"

$GNU_SED -i -e '/^set(__qt_toolchain_initial_qt_host_path_cmake_dir[[:space:]]*$/{N
c\
set(__qt_toolchain_initial_qt_host_path_cmake_dir "${CMAKE_CURRENT_LIST_DIR}/../../../host/lib/cmake")
d
}' "${PATH_TO_TARGET}/lib/cmake/Qt6/qt.toolchain.cmake"
