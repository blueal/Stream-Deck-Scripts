# Stream-Deck-Scripts
My collection of scripts and commands running on my personal Elgato Stream Deck

Compaitability is only certain at the time of publishing. As programs are updated scripts may break. Add an issue on github to track broken scripts.

## Setup
Setup is very simple. FORK this repository and download programs as they become neccesary into there corresponding folders

1. Nircmd
2. MultiMonitorTool
3. HarmonyHubCli.js & Node.js modules

## Usage
Scripts are written in a modular fashion with relative paths. Most scripts require parameters passed into them. Read the script files for more information.

### Calling PowerShell Scripts
The only way to call a `.ps1` script silently without popups is through another layer of scripts. Every `.ps1` file has a companion `.bat` file that is custom created to call that PowerShell Script with the neccesary paramters. Set your Stream Deck to open that `.bat` file to run the corresponding PowerShell Script.

### Some information is needed to be gathered by you, such as:
* Zoom Meeting IDs
* Harmony Hub IP Address
* Process names

This information must either be stored in a file, or passed into the script at runtime.

Store your personal information and API Keys in the `Keys` folder for safe keeping
