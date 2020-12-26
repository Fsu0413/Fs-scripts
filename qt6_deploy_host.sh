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

if [ ! -e "${PATH_TO_HOST}/bin/qt_cmake" ]; then
	echo "Host path $1 does not contain bin/qt_cmake." >&2
	exit 1
fi

mkdir $PATH_TO_TARGET/host
cp -R $PATH_TO_HOST/bin $PATH_TO_TARGET/host/
mkdir $PATH_TO_TARGET/host/lib
cp -R $PATH_TO_HOST/lib/cmake $PATH_TO_TARGET/host/lib/
cp -R $PATH_TO_HOST/lib/metatypes $PATH_TO_TARGET/host/lib/
find $PATH_TO_HOST/lib/ -name \*.prl -maxdepth 1 -exec cp '{}' $PATH_TO_TARGET/host/lib ';'

(
	echo '#!/bin/sh'
	echo
	echo "script_dir_path=\`dirname \$0\`"
	echo "script_dir_path=\`(cd \"\$script_dir_path\"; /bin/pwd)\`"
	echo
	echo "\$script_dir_path/../host/bin/qmake -qtconf \"\$script_dir_path/target_qt.conf\" \$*"
) > $PATH_TO_TARGET/bin/qmake

chmod +x $PATH_TO_TARGET/bin/qmake

sed -i -e 's,^HostPrefix=.*$,HostPrefix=../host,g' $PATH_TO_TARGET/bin/target_qt.conf
sed -i -e 's,^HostData=.*$,HostData=..,g' $PATH_TO_TARGET/bin/target_qt.conf

# CMake is broken even if we have tried to tweak it
# Temporarily put these things off until we found a solution

