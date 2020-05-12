'NOTE: NO MATTER WHAT I DID, SPACES IN FILE NAME OR FOLDER WILL BREAK THIS. NOTHING WILL FIX IT. AHHHHHH

'Use Powershell SendKey presses, google it.

key = "%q"

command = "powershell.exe -nologo -command ""PATH\SendZoomKeyPress.ps1 """ & key

set shell = CreateObject("WScript.Shell")

shell.Run command,0,TRUE
