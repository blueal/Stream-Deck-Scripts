REM Reads the IP Address of the Harmony from the file, runs the Node.js scripts, passes in the control name.
REM ALL NAMES MUST BE PASSED IN QUOTES "PowerToggle"
cd "%~dp0"
set /p IPAddress=<"../Keys/HarmonyIP.txt"
node ./harmonyHubCli/harmonyHubCli.js -l %IPAddress% -d "ZVOX Amp" -c %1