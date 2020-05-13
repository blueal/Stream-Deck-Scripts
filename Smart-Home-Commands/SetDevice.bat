REM Reads the IP Address of the Harmony from the file, runs the Node.js scripts, passes in the device name, and the command
REM ALL NAMES MUST BE PASSED IN QUOTES "PowerToggle"
cd "%~dp0"
set /p IPAddress=<"../Keys/Harmony/HarmonyIP.txt"
node ./harmonyHubCli/harmonyHubCli.js -l %IPAddress% -d %1 -c %2