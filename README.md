# Windows Time Server Checker Script

This PowerShell script checks the time from `time.windows.com` NTP server and displays it in the console.

## Features

* Continuously displays the current time from `time.windows.com`.
* Updates the time every second.
* Displays only the hour and minute.

## Requirements

* PowerShell
* Access to `time.windows.com` NTP server
* Appropriate permissions to execute PowerShell scripts

## Usage

1. **Run the script directly from GitHub:**

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/dddevid/WindowsTimeServerCheckerScript/refs/heads/main/get-time.ps1" | Invoke-Expression
