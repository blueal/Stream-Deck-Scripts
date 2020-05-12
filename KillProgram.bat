REM Pass in the process file name. EX: Zoom.exe or Discord.exe
REM Sends the Windows Close Message, does not actually force kill the program.
@echo off 
@taskkill /IM %1 /T