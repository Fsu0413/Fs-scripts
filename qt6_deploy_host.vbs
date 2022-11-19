Dim WshShell
Set WshShell = WScript.CreateObject("Wscript.Shell")

Dim fso
Set fso = WScript.CreateObject("Scripting.Filesystemobject")

If WScript.Arguments.Count < 2 Then
	WScript.StdErr.WriteLine "PATH_TO_TARGET and PATH_TO_HOST should be both set."
	WScript.Quit 1
End If

Dim PATH_TO_TARGET, PATH_TO_HOST
PATH_TO_TARGET = WScript.Arguments(0)
PATH_TO_HOST = WScript.Arguments(1)

' sanity
If Not fso.FileExists(PATH_TO_TARGET & "\bin\target_qt.conf") Then
	WScript.StdErr.WriteLine "Target path " & PATH_TO_TARGET & " does not contain bin/target_qt.conf."
	WScript.Quit 1
End If

If Not fso.FileExists(PATH_TO_HOST & "\bin\qt-cmake.bat") Then
	WScript.StdErr.WriteLine "Target path " & PATH_TO_HOST & " does not contain bin/qt-cmake.bat."
	WScript.Quit 1
End If

fso.CreateFolder PATH_TO_TARGET & "\host"
fso.CopyFolder PATH_TO_HOST & "\bin", PATH_TO_TARGET & "\host\bin"
If fso.FolderExists(PATH_TO_HOST & "\libexec") Then fso.CopyFolder PATH_TO_HOST & "\libexec", PATH_TO_TARGET & "\host\libexec"
fso.CreateFolder PATH_TO_TARGET & "\host\lib"
fso.CopyFolder PATH_TO_HOST & "\lib\cmake", PATH_TO_TARGET & "\host\lib\cmake"
fso.CopyFolder PATH_TO_HOST & "\lib\metatypes", PATH_TO_TARGET & "\host\lib\metatypes"

Dim hostlibdir, hostlibfile
Set hostlibdir = fso.GetFolder(PATH_TO_HOST & "\lib")
For Each hostlibfile In hostlibdir.Files
	If Right(hostlibfile.Name, 4) = ".prl" Then
		fso.CopyFile hostlibfile.Path, PATH_TO_TARGET & "\host\lib\" & hostlibfile.Name
	End If
Next

' qmake tweak

fso.DeleteFile PATH_TO_TARGET & "\bin\qmake.bat"

Dim qmake
Set qmake = fso.OpenTextFile(PATH_TO_TARGET & "\bin\qmake.bat", 2, True)
qmake.WriteLine """%~dp0\..\host\bin\qmake"" -qtconf ""%~dp0\target_qt.conf"" %*"
qmake.Close

fso.DeleteFile PATH_TO_TARGET & "\bin\qtpaths.bat"

Dim qtpaths
Set qtpaths = fso.OpenTextFile(PATH_TO_TARGET & "\bin\qtpaths.bat", 2, True)
qtpaths.WriteLine """%~dp0\..\host\bin\qtpaths"" -qtconf ""%~dp0\target_qt.conf"" %*"
qtpaths.Close

Dim target_qtconf
Dim target_qtconfold
Set target_qtconf = fso.OpenTextFile(PATH_TO_TARGET & "\bin\target_qt.conf.new", 2, True)
Set target_qtconfold = fso.OpenTextFile(PATH_TO_TARGET & "\bin\target_qt.conf", 1, False)

Do until target_qtconfold.AtEndOfStream 
	Dim line
	line = target_qtconfold.ReadLine
	If Left(line, 11) = "HostPrefix=" Then line = "HostPrefix=../host"
	If Left(line, 9) = "HostData=" Then line = "HostData=.."
	target_qtconf.WriteLine line
Loop

target_qtconf.Close
target_qtconfold.Close

fso.DeleteFile PATH_TO_TARGET & "\bin\target_qt.conf"
fso.MoveFile PATH_TO_TARGET & "\bin\target_qt.conf.new", PATH_TO_TARGET & "\bin\target_qt.conf"

' CMake tweak

Dim Qt6Dependencies_cmake
Dim Qt6Dependencies_cmakeold
Set Qt6Dependencies_cmake = fso.OpenTextFile(PATH_TO_TARGET & "\lib\cmake\Qt6\Qt6Dependencies.cmake.new", 2, True)
Set Qt6Dependencies_cmakeold = fso.OpenTextFile(PATH_TO_TARGET & "\lib\cmake\Qt6\Qt6Dependencies.cmake", 1, False)

Do until Qt6Dependencies_cmakeold.AtEndOfStream 
	Dim line
	line = Qt6Dependencies_cmakeold.ReadLine
	If Left(Trim(line), 38) = "set(__qt_platform_initial_qt_host_path" Then line = "set(__qt_platform_initial_qt_host_path ""${Qt6_DIR}/../../../host"")"
	If Left(Trim(line), 48) = "set(__qt_platform_initial_qt_host_path_cmake_dir" Then line = "set(__qt_platform_initial_qt_host_path_cmake_dir ""${Qt6_DIR}/../../../host/lib/cmake"")"
	Qt6Dependencies_cmake.WriteLine line
Loop

Qt6Dependencies_cmake.Close
Qt6Dependencies_cmakeold.Close

fso.DeleteFile PATH_TO_TARGET & "\lib\cmake\Qt6\Qt6Dependencies.cmake"
fso.MoveFile PATH_TO_TARGET & "\lib\cmake\Qt6\Qt6Dependencies.cmake.new", PATH_TO_TARGET & "\lib\cmake\Qt6\Qt6Dependencies.cmake"

' lib/cmake/Qt6/QtBuildInternalsExtra.cmake
' Does this need to be modified? This is the install directory!
' Our Qt builds are relocatable so it seems like there is no way that the file needs to be modified
'     set(qtbi_orig_staging_prefix "")
