REM Reads the IP Address of the Harmony from the file, runs the Node.js scripts, passes in the activity name.
REM MUST INPUT ACTIVITY NAME IN QUOTES TO USE THIS SCRIPT "Watch PC"
cd "%~dp0"
set /p IPAddress=<"../Keys/HarmonyIP.txt"
node ./harmonyHubCli/harmonyHubCli.js -l %IPAddress% -a %1