@echo off
REM Set Default Sound Device. Pass in Device Friendly Name as it Appears in Windows.
cd "%~dp0"
.\Nircmd\nircmd.exe setdefaultsounddevice %1 1