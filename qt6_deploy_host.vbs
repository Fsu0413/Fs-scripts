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

fso.DeleteFile PATH_TO_TARGET & "\bin\qmake.bat"

Dim qmake
Set qmake = fso.OpenTextFile(PATH_TO_TARGET & "\bin\qmake.bat", 2, True)
qmake.WriteLine """%~dp0\..\host\bin\qmake"" -qtconf ""%~dp0\target_qt.conf"" %*"
qmake.Close

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

' CMake is broken even if we have tried to tweak it
' Temporarily put these things off until we found a solution

