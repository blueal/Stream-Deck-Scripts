cd "%~dp0"
set /p IPAddress=<"../Keys/Harmony//HarmonyIP.txt"
node ./harmonyHubCli/harmonyHubCli.js -l %IPAddress% -a "Watch PC"