'NOTE: NO MATTER WHAT I DID, SPACES IN FILE NAME OR FOLDER WILL BREAK THIS. NOTHING WILL FIX IT. AHHHHHH
'Use Powershell SendKey presses, google it.



'Sub MyFunc
	Dim key
	Set Arg = WScript.Arguments
	If Arg.Count > 0 Then
		x=msgbox(key ,0, "TRUE")
   		key = Arg(0)
	Else
		key = ""
		x=msgbox(key ,0, "FAIL")
	End If

	path = """C:\PATH\SendZoomKeyPress.ps1"""
	
	command = "powershell.exe -nologo -command" & path & key
	
	set shell = CreateObject("WScript.Shell")
	
	shell.Run command,0,TRUE
'End Sub