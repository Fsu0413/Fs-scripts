Dim WshShell
Set WshShell = WScript.CreateObject("Wscript.Shell")

Dim fso
Set fso = WScript.CreateObject("Scripting.Filesystemobject")

Sub showhelp()
	WScript.echo "OpenSSL for Windows compile helper script for Visual Studio command prompt"
	WScript.echo "Usage:"
	WScript.echo "  cscript " & WScript.ScriptName & " PATH_TO_OPENSSL [-static] [-xp] [-debug]"
	WScript.Echo ""
	WScript.echo "PATH_TO_OPENSSL points to the folder where OpenSSL is extracted."
	WScript.Echo ""
	WScript.Echo "Note: This script must be run from a Visual Studio command prompt using cscript. WScript is not supported."
	WScript.Echo ""
End Sub

Function getVsVersion()
	Dim cur
	cur = WshShell.CurrentDirectory
	WshShell.CurrentDirectory = WshShell.Environment("Process").Item("TEMP")

	Dim file
	Set file = fso.CreateTextFile("1.c", True)
	file.WriteLine "_MSC_FULL_VER"
	file.Close
	Set file = Nothing

	Dim exec
	err.clear
	On Error Resume Next
	Set exec = WshShell.Exec("cl /nologo /EP 1.c")
	If err.number = -2147024894 Then
		WScript.Echo "Please run this script in a Visual Studio command prompt"
		getVsVersion = ""
		Exit Function
	ElseIf err.number <> 0 Then
		wscript.echo "unknown error."
		getVsVersion = ""
		Exit Function
	End If

	Dim i
	i = 0
	Do While exec.Status = WshRunning
		i = i + 1
		WScript.Sleep 100
		If i = 100 Then
			WScript.Echo "cl hasn't exit in 10 seconds."
			getVsVersion = ""
			Exit Function
		End If
	Loop

	Dim maj, min, pat
	If exec.ExitCode = 0 Then
		Dim x
		x = clng(Trim(exec.StdOut.ReadAll))
		maj = x \ 10000000
		min = (x \ 100000) mod 100
		pat = x mod 100000
	End If

	WshShell.CurrentDirectory = cur

	Select Case maj
		Case 19:
			If min = 0 Then
				getVsVersion = "VS2015"
			Else
				Dim patchVersion
				patchVersion = WshShell.Environment("Process").Item("VSCMD_VER")
				If min >= 20 Then
					getVsVersion = "VS2019-" & patchVersion
				ElseIf min >= 10 Then
					getVsVersion = "VS2017-" & patchVersion
				Else
					getVsVersion = "unknown"
				End If
			End If
		Case 18:
			getVsVersion = "VS2013"
		Case 17:
			getVsVersion = "VS2012"
		Case 16:
			getVsVersion = "VS2010"
		Case 15:
			getVsVersion = "VS2008"
		Case 14:
			getVsVersion = "VS2005"
		Case 13:
			If min = 0 Then
				getVsVersion = "VS2002"
			Else
				getVsVersion = "VS2003"
			End If
		Case 12:
			getVsVersion = "VC++6.0"
		Case Else:
			getVsVersion = "unknown"
	End Select
End Function

Function patch102ForXP(vsVersion)
	Dim ret
	ret = True
	If vsVersion = "unknown" Then
		wscript.echo "unknown VS Version, ignored for patching."
	ElseIf (vsVersion = "VC++6.0") Or (vsVersion = "VS2002") Or _
			(vsVersion = "VS2003") Or (vsVersion = "VS2005") Or _
			(vsVersion = "VS2008") Or (vsVersion = "VS2010") Then
		wscript.echo "VS version is low enough, no need to patch."
	ElseIf (vsVersion = "VS2012") Or (vsVersion = "VS2013") Or _
			(vsVersion = "VS2015") Or (left(vsVersion, 6) = "VS2017") Then
		fso.MoveFile "util\pl\VC-32.pl", "util\pl\VC-32.pl.bak"
		Dim toRead, toWrite
		Set toRead = fso.OpenTextFile("util\pl\VC-32.pl.bak", 1)
		Set toWrite = fso.CreateTextFile("util\pl\VC-32.pl", True)
		Do While Not toRead.AtEndOfStream
			Dim line
			line = toRead.ReadLine
			If (Left(Trim(line), 7) = "$lflags") And (InStr(line, "/subsystem:console") <> 0) Then
				line = Replace(line, "/subsystem:console", "/subsystem:console,5.01")
			End If
			toWrite.WriteLine line
		Loop
		toWrite.close
		Set toWrite = Nothing
		toRead.close
		Set toRead = Nothing
	Else
		wscript.echo "VS version is too high, which does not support windows XP."
		ret = False
	End If
	patch102ForXP = ret
End Function

Sub debugConf()
	Set file = fso.CreateTextFile("debug.conf", True)
	file.Write "my %targets = (" & vbCrLf & _
		"    ""VC-WIN64A-debug"" => {" & vbCrLf & _
		"        inherit_from    => [ ""VC-WIN64A"" ]," & vbCrLf & _
		"       multilib => ""-x64_d""," & vbCrLf & _
		"    }," & vbCrLf & _
		"    ""VC-WIN32-debug"" => {" & vbCrLf & _
		"        inherit_from    => [ ""VC-WIN32"" ]," & vbCrLf & _
		"       multilib => ""_d""," & vbCrLf & _
		"    }," & vbCrLf & _
		");" & vbCrLf
	file.close
	Set file = Nothing
End Sub

Sub patchDebug102()
	fso.MoveFile "util\pl\VC-32.pl", "util\pl\VC-32.pl.bak"
	Dim toRead, toWrite
	Set toRead = fso.OpenTextFile("util\pl\VC-32.pl.bak", 1)
	Set toWrite = fso.CreateTextFile("util\pl\VC-32.pl", True)
	Do While Not toRead.AtEndOfStream
		Dim line
		line = toRead.ReadLine
		If (Left(Trim(line), 4) = "$ssl") And (InStr(line, "ssleay32") <> 0) Then
			line = Replace(line, "ssleay32", "ssleay32_d")
		ElseIf (Instr(Trim(line), "$crypto") <> 0) And (InStr(line, "libeay32") <> 0) Then
			line = Replace(line, "libeay32", "libeay32_d")
		End If
		toWrite.WriteLine line
	Loop
	toWrite.close
	Set toWrite = Nothing
	toRead.close
	Set toRead = Nothing
End Sub

Sub patchDebugBat102(doFile)
	fso.MoveFile doFile, doFile & ".bak"
	Dim toRead, toWrite
	Set toRead = fso.OpenTextFile(doFile & ".bak", 1)
	Set toWrite = fso.CreateTextFile(doFile, True)
	Do While Not toRead.AtEndOfStream
		Dim line
		line = toRead.ReadLine
		If InStr(line, "ssleay32.def") <> 0 Then
			line = Replace(line, "ssleay32.def", "ssleay32_d.def")
		ElseIf InStr(line, "libeay32.def") <> 0 Then
			line = Replace(line, "libeay32.def", "libeay32_d.def")
		End If
		toWrite.WriteLine line
	Loop
	toWrite.close
	Set toWrite = Nothing
	toRead.close
	Set toRead = Nothing
End Sub

sub patch102t()
	fso.MoveFile "util\libeay.num", "util\libeay.num.bak"
	dim toRead, toWrite
	set toRead = fso.OpenTextFile("util\libeay.num.bak", 1)
	set toWrite = fso.CreateTextFile("util\libeay.num", true)
	do while not toRead.AtEndOfStream
		dim line
		line = toRead.readline
		if left(line, 13) = "OPENSSL_rdtsc" then
			' do nothing
		else
			toWrite.WriteLine line
		end if
	loop
	toWrite.close
	Set toWrite = Nothing
	toRead.close
	Set toRead = Nothing
end sub

Sub patchDebugDef102(def)
	Dim filename
	filename = "ms\" & def & "_d.def"
	WScript.Echo  filename
	fso.MoveFile filename, filename & ".bak"
	Dim toRead, toWrite
	Set toRead = fso.OpenTextFile(filename & ".bak", 1)
	Set toWrite = fso.CreateTextFile(filename, True)
	Do While Not toRead.AtEndOfStream
		Dim line
		line = toRead.ReadLine
		If (Left(Trim(line), 7) = "LIBRARY") And (InStr(line, UCase(def)) <> 0) Then
			line = Replace(line, UCase(def), UCase(def) & "_D")
		End If
		toWrite.WriteLine line
	Loop
	toWrite.close
	Set toWrite = Nothing
	toRead.close
	Set toRead = Nothing
End Sub

Function getPlatform()
	Dim cur
	cur = WshShell.CurrentDirectory
	WshShell.CurrentDirectory = WshShell.Environment("Process").Item("TEMP")

	' TODO: how to detect UWP command prompt?
	' WINAPI_FAMILY is not defined without "#include <winapifamily.h>", and is defined to 100 with "#include <winapifamily.h>"
	Dim file
	Set file = fso.CreateTextFile("2.c", True)
	file.Write "#if defined(__arm__) || defined(__TARGET_ARCH_ARM) || defined(_M_ARM) || defined(_M_ARM64) || defined(__aarch64__) || defined(__ARM64__)" & vbCrLf & _
		"#if defined(__aarch64__) || defined(__ARM64__) || defined(_M_ARM64)" & vbCrLf & _
		"#define Q_PROCESSOR_ARM_64" & vbCrLf & _
		"#else" & vbCrLf & _
		"#define Q_PROCESSOR_ARM_32" & vbCrLf & _
		"#endif" & vbCrLf & _
		"#elif defined(__i386) || defined(__i386__) || defined(_M_IX86)" & vbCrLf & _
		"#define Q_PROCESSOR_X86_32" & vbCrLf & _
		"#elif defined(__x86_64) || defined(__x86_64__) || defined(__amd64) || defined(_M_X64)" & vbCrLf & _
		"#define Q_PROCESSOR_X86_64" & vbCrLf & _
		"#endif" & vbCrLf & _
		"#if defined(Q_PROCESSOR_X86_64)" & vbCrLf & _
		"x64" & vbCrLf & _
		"#elif defined(Q_PROCESSOR_X86_32)" & vbCrLf & _
		"x86" & vbCrLf & _
		"#elif defined(Q_PROCESSOR_ARM_64)" & vbCrLf & _
		"ARM64" & vbCrLf & _
		"#elif defined(Q_PROCESSOR_ARM_32)" & vbCrLf & _
		"ARM32" & vbCrLf & _
		"#else" & vbCrLf & _
		"TODO" & vbCrLf & _
		"#endif" & vbCrLf
	file.Close
	Set file = Nothing

	Dim exec
	err.clear
	On Error Resume Next
	Set exec = WshShell.Exec("cl /nologo /EP 2.c")
	If err.number = -2147024894 Then
		WScript.Echo "Please run this script in a Visual Studio command prompt"
		getPlatform = ""
		Exit Function
	ElseIf err.number <> 0 Then
		wscript.echo "unknown error."
		getPlatform = ""
		Exit Function
	End If

	Dim i
	i = 0
	Do While exec.Status = WshRunning
		i = i + 1
		WScript.Sleep 100
		If i = 100 Then
			WScript.Echo "cl hasn't exit in 10 seconds."
			getPlatform = ""
			Exit Function
		End If
	Loop

	Dim x
	x = ""
	If exec.ExitCode = 0 Then
		Do While len(x) = 0
			x = Trim(exec.StdOut.ReadLine)
		Loop
	End If

	WshShell.CurrentDirectory = cur
	getPlatform = x
End Function

Function r(command)
	Wscript.Echo "+ " & command
	Dim ret
	ret = WshShell.run(command, 1, True)
	r = ret
End Function

strEngine = LCase(Right(WScript.FullName, 12))
If strEngine <> "\cscript.exe" Then
	WshShell.Popup "Please run this script in cscript. WScript is not supported."
	WScript.Quit 1
End If

Dim makeStatic
makeStatic = False
Dim xpCompat
xpCompat = False
Dim DoubleHyphen
doublehyphen = False
Dim debugbuild
debugbuild = False

Dim PathToOpenSSL

For Each arg In WScript.Arguments
	If (Not doublehyphen) And (left(arg, 1) = "-") Then
		If arg = "-help" Or arg = "--help" Or arg = "-?" Then
			showhelp
			WScript.Quit 0
		ElseIf arg = "-xp" Then
			xpCompat = True
		ElseIf arg = "-static" Then
			makeStatic = True
		ElseIf arg = "-debug" Then
			debugbuild = True
		ElseIf arg = "--" Then
			doublehyphen = True
		Else
			WScript.Echo "unknown argument """ & arg & """"
			WScript.Quit 1
		End If
	Else
		If len(PathToOpenSSL) = 0 Then
			PathToOpenSSL = arg
		Else
			WScript.Echo "unknown argument """ & arg & """"
			WScript.Quit 1
		End If
	End If
Next

If Not fso.FolderExists(PathToOpenSSL) Then
	WScript.Echo "PATH_TO_OPENSSL doesn't exist, exit."
	WScript.Quit 1
End If
Dim path
path = PathToOpenSSL
If Right(path, 1) <> "\" Then
	path = path & "\"
End If
path = path & "Configure"
If Not fso.FileExists(path) Then
	WScript.Echo "PATH_TO_OPENSSL doesn't contain a file name Configure, exit."
	WScript.Quit 1
End If

PathToOpenSSL = fso.GetFolder(PathToOpenSSL).Path
If Right(PathToOpenSSL, 1) <> "\" Then
	PathToOpenSSL = PathToOpenSSL & "\"
End If

Dim VsVersion
VsVersion = getVsVersion
If VsVersion = "" Then
	WScript.Quit 1
End If

Dim Platform
Platform = getPlatform
If Platform <> "" Then
	Platform = UCase(Platform)
Else
	WScript.Quit 1
End If

Dim Readme
Set Readme = fso.OpenTextFile(PathToOpenSSL & "README", 1)
Readme.skipline
Dim OpenSSLVersion
OpenSSLVersion = Mid(Trim(Readme.readline), 9)
OpenSSLVersion = Trim(Left(OpenSSLVersion,InStr(OpenSSLVersion," ")))
Readme.close
Set Readme = Nothing

If left(OpenSSLVersion, 3) = "1.1" And xpCompat Then
	WScript.Echo "OpenSSL 1.1 does not compatible with Windows XP, exit."
	WScript.Quit 1
End If

if (left(OpenSSLVersion, 3) <> "1.1") And left(platform, 3) = "ARM" then
	WScript.echo "OpenSSL 1.0 and older does not support Windows on Arm, exit."
	WScript.Quit 1
end if

Dim args
Dim Target
If Platform = "X86" Then
	Target = "x86"
	args = "VC-WIN32"
ElseIf Platform = "X64" Then
	Target = "x86_64"
	args = "VC-WIN64A"
ElseIf Platform = "ARM64" then
	Target = "arm64"
	args = "VC-WIN64-ARM"
Else
	WScript.Echo "Todo for platform " & Platform
	WScript.Quit 1
End If

If r("perl --version") <> 0 Then
	WScript.Echo "Perl is not detected, exit."
	WScript.Quit 1
End If

Dim origDir
origDir = WshShell.CurrentDirectory

Dim configureDir
configureDir = WshShell.CurrentDirectory
If Right(configureDir, 1) <> "\" Then
	configureDir = configureDir & "\"
End If
configureDir = configureDir & "OpenSSL" & OpenSSLVersion & "-Windows-" & Target & "-" & vsversion
If makeStatic Then
	configureDir = configureDir & "-static"
End If
If xpCompat Then
	configureDir = configureDir & "-xp"
End If
If debugbuild Then
	configureDir = configureDir & "-debug"
End If

Dim buildDir
buildDir = WshShell.CurrentDirectory
If Right(buildDir, 1) <> "\" Then
	buildDir = buildDir & "\"
End If
buildDir = buildDir & "build-openssl" & OpenSSLVersion & "-" & Target & "-" & vsversion
If makeStatic Then
	buildDir = buildDir & "-static"
End If
If xpCompat Then
	buildDir = buildDir & "-xp"
End If
If debugbuild Then
	buildDir = buildDir & "-debug"
End If

If fso.FolderExists(buildDir) Then
	fso.DeleteFolder buildDir, True
End If

fso.CreateFolder buildDir

If left(OpenSSLVersion, 3) <> "1.1" Then
	' For OpenSSL 1.0.2 series, since shadow build is not supported, we copy the full code from source to build dir
	wscript.echo "Copying files from source to build dir for OpenSSL 1.0 and before......"
	fso.CopyFolder Left(PathToOpenSSL, Len(PathToOpenSSL) - 1), buildDir
End If

WshShell.CurrentDirectory = buildDir

If (left(OpenSSLVersion, 3) <> "1.1") And xpCompat Then
	If Not patch102ForXP(VsVersion) Then
		WScript.Quit 1
	End If
End If

if OpenSSLVersion = "1.0.2t" then
	patch102t
end if

Dim configureCommand
configureCommand = "perl "
If left(OpenSSLVersion, 3) = "1.1" Then
	If Not makeStatic Then
		configureCommand = configureCommand & PathToOpenSSL & "Configure no-asm shared "
	Else
		configureCommand = configureCommand & PathToOpenSSL & "Configure no-asm no-shared "
	End If
Else
	configureCommand = configureCommand & " Configure no-asm "
End If
configureCommand = configureCommand & " --prefix=" & configureDir & " "
configureCommand = configureCommand & " --openssldir=" & configureDir & "\ssl "
If debugbuild Then
	If left(OpenSSLVersion, 3) = "1.1" Then
		debugConf
		configureCommand = configureCommand & "--config=debug.conf --debug "
	Else
		patchDebug102
		configureCommand = configureCommand & " debug-"
	End If
End If
configureCommand = configureCommand & args
If debugbuild Then
	If left(OpenSSLVersion, 3) = "1.1" Then
		configureCommand = configureCommand & "-debug"
	End If
End If

If r(configureCommand) <> 0 Then
	WScript.Quit 1
End If

Dim makecommand
If left(OpenSSLVersion, 3) = "1.1" Then
	makecommand = "nmake clean"
	r(makecommand)

	makecommand = "nmake"
	If r(makecommand) <> 0 Then
		WScript.Quit 1
	End If

'	makecommand = "nmake test"
'	If r(makecommand) <> 0 Then
'		WScript.Quit 1
'	End If

	makecommand = "nmake install_sw install_ssldirs"
	If r(makecommand) <> 0 Then
		WScript.Quit 1
	End If
Else
	If args = "VC-WIN32" Then makecommand = "ms\do_ms.bat" Else makecommand = "ms\do_win64a.bat"
	If debugbuild Then
		' patch ms\do_XX.bat since the def filename has changed
		patchDebugBat102 makecommand
	End If

	If r(makecommand) <> 0 Then
		WScript.Quit 1
	End If
	
	If debugbuild Then
		' patch ms\xxx.def since the dll filename has changed
		patchDebugDef102 "ssleay32"
		patchDebugDef102 "libeay32"
	End If

	Dim makeFile
	makeFile = "ms\ntdll.mak"
	If makeStatic Then
		makeFile = "ms\nt.mak"
	End If

	makecommand = "nmake -f " & makeFile & " clean"
	r(makecommand)

	makecommand = "nmake -f " & makeFile
	If r(makecommand) <> 0 Then
		WScript.Quit 1
	End If

'	makecommand = "nmake -f " & makeFile & " test"
'	If r(makecommand) <> 0 Then
'		WScript.Quit 1
'	End If

	makecommand = "nmake -f " & makeFile & " install"
	If r(makecommand) <> 0 Then
		WScript.Quit 1
	End If
	
	If debugbuild Then
		' copy PDB to the bin directory
		fso.CopyFile "out32dll.dbg\ssleay32_d.pdb", configureDir & "\bin\ssleay32_d.pdb", True
		fso.CopyFile "out32dll.dbg\libeay32_d.pdb", configureDir & "\bin\libeay32_d.pdb", True
		fso.CopyFile "out32dll.dbg\openssl.pdb", configureDir & "\bin\openssl.pdb", True
	End If
End If

WshShell.CurrentDirectory = origDir
fso.DeleteFolder buildDir, True
