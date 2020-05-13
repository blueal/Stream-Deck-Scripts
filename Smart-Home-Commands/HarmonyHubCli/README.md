# HarmonyHubCli
*Download information is available [here](https://github.com/sushilks/harmonyHubCLI).*

## Installation Instructions
1. Set Working Directory in Command Prompt to this folder (or whatever shell you prefer)
2. `npm install harmonyhubjs-client harmonyhubjs-discover argparse harmony-hub-util`
    * Yes, I know there are dependencies that are out of date, there's not much I can do
3. `curl https://raw.githubusercontent.com/sushilks/harmonyHubCLI/master/harmonyHubCli.js -o harmonyHubCli.js`
4. Go to Harmony HUB App, Turn on XMPP Server
    * It's disabled for a reason, huge security vulnerability, no authentication.
    * `Settings->Remote & Hub->Enable XMPP`
5. `node harmonyHubCli.js  -r activities`
    * Note the Harmony HUB IP Address, save it in a file called `HarmonyIP.txt`
    * Store it in `Keys/Harmony/HarmonyIP.txt`
    * ALWAYS use this IP Address, it will save A LOT of time when running
    * Set a static IP in your Router for the HUB so it will never change.
6. Refer to this [repo](https://github.com/sushilks/harmonyHubCLI) for information and further instructions

## Usage
The actual command line commands can be confusing at times. If the HUB refuses to respond to a command, it's probably because you mistyped it.