# Stream-Deck-Scripts
My collection of scripts and commands running on my personal Elgato Stream Deck

Compaitability is only certain at the time of publishing. As programs are updated scripts may break. Add an issue on github to track broken scripts.

## Setup
Setup is very simple. FORK this repository and download dependent programs as they become neccesary into there corresponding folders

1. [Nircmd](Monitor-Scripts/Nircmd/README.md)
    * `Monitor-Scripts\Nircmd`
2. [MultiMonitorTool](Monitor-Scripts/Multi-Monitor-Tool/README.md)
    * `Monitor-Scripts\Multi-Monitor-Tool`
3. [HarmonyHubCli.js & Node.js modules](Smart-Home-Commands/HarmonyHubCli/README.md)
    * `Smart-Home-Commands\HarmonyHubCli`
    * Install NPM Modules as described in Readme

### Assumptions
Using these scripts assumes you already have a developer enviornment. This can include:
1. Windows User
2. Node.js Installed
3. Git Bash installed
4. Zoom Client Installed
5. Unix Subsystem Enabled
6. Linux installed from windows store
7. PowerShell Scripts can run if signed
8. You have an Elgato Stream Deck

## Usage
Scripts are written in a modular fashion with relative paths. Most scripts require parameters passed into them. Read the script files for more information.

### Calling PowerShell Scripts
The only way to call a `.ps1` script silently without popups is through another layer of scripts. Every `.ps1` file has a companion `.bat` file that is custom created to call that PowerShell Script with the neccesary paramters. Set your Stream Deck to open that `.bat` file to run the corresponding PowerShell Script.

![Flow Chart describing calling Powershell scripts](./Assets/CallingPowerShell.drawio.svg "Call the Batch File to call the Powershell")


### Some information is needed to be gathered by you as neccesary, such as:
* Zoom Meeting IDs
    * Passed as a parameter when running
* Harmony Hub IP Address
    * Stored in a file in `Keys` folder
* Window Title names
    * Hardcoded into PowerShell Scripts
* Harmony Hub Activity Names and Devices
    * Passed as a parameter when running

This information must either be stored in a file, or passed into the script at runtime. Depending on the script.

Store your [personal information](Keys/README.md) and API Keys in the `Keys` folder for safe keeping.

### Example Scripts
The `Example-Test-Scripts` folder contains many older scripts that I used to debug, and implement other features. I only keep them around in case I want to look at old code. They are in various states of functionality and are for reference ONLY.

## Known Issues
* The MultiMonitor scripts are based on preset profiles of your monitor configuration. If restarting from a clean install these profiles may be incorrect and may need to be re-saved. No fix for this, it's just how it is.
* [#1](https://github.com/blueal/Stream-Deck-Scripts/issues/1) Zoom came out with an update that changes the behavior of joining a personal meeting. The owner of the meeting will no longer get an Invite. Current lack of API integration for meeting invites means this is impossible to fix at this time.