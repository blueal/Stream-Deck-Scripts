#####################WARNING################################
#     THE PERMISSIONS TO RUN POWERSHELLS SCRIPTS
#     MUST BE ENABLED                
#     https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7
#
#     I reccomend simply setting the current user permission to "RemoteSigned" Only. This will allow only locally made scripts to be run
#
#     Run this command to set it to allow only for current user
#     Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
#
#     To Revert to safe deafaults run this:
#     Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser
#
#########################################################################

#https://stackoverflow.com/questions/42566799/how-to-bring-focus-to-window-by-process-name
#
#This program will grab the Zoom window and give it focus.
#This programs defaults to appdata, change the $proc variable to set the .exe location
#It will then issue it a keyboard command of my choosing.

Param(
    [string] $proc = $env:APPDATA + "\Zoom\bin\Zoom.exe",
    #Change $proc variable to program path
    [string] $key = "^V",
    [string] $adm
)
Clear-Host

Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class WinAp {
      [DllImport("user32.dll")]
      [return: MarshalAs(UnmanagedType.Bool)]
      public static extern bool SetForegroundWindow(IntPtr hWnd);


      [DllImport("user32.dll")]
      [return: MarshalAs(UnmanagedType.Bool)]
      public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    }
"@
$p = Get-Process | Where {$_.mainWindowTitle} |
    Where {$_.Name -like "$proc"}
if (($p -eq $null) -and ($adm -ne "")) {
    #Start-Process "$proc" -Verb runAs
    #Runs as adminsistrator if needed
} elseif (($p -eq $null) -and ($adm -eq "")) {
    Start-Process "$proc"
    "ZOOM EXISTS"
} else {
    #I don't know what this is
    #$h = $p.MainWindowHandle
    #[void] [WinAp]::SetForegroundWindow($h)
    #[void] [WinAp]::ShowWindow($h, 3)
}

##$wshell = New-Object -ComObject wscript.shell;
#$wshell.AppActivate('Zoom Meeetings')
#Sleep 1
#$wshell.SendKeys('%v')

$program = Get-Process Zoom -ErrorAction SilentlyContinue
if ($program) {
    "IT WORK"
}
Remove-Variable program

#sleep -m 500
Add-Type @" 
  using System; 
  using System.Runtime.InteropServices; 
  public class UserWindows { 
    [DllImport("user32.dll")] 
    public static extern IntPtr GetForegroundWindow(); 
} 
"@ 
try { 
$ActiveHandle = [UserWindows]::GetForegroundWindow() 
$Process = Get-Process | ? {$_.MainWindowHandle -eq $activeHandle} 
$Process | Select ProcessName, @{Name="AppTitle";Expression= {($_.MainWindowTitle)}} 
if(($Process | Select ProcessName) -like '*power*'){
    "TEST"
    }
} catch { 
    Write-Error "Failed to get active Window details. More Info: $_" 
} 
# SIG # Begin signature block
# MIIFdgYJKoZIhvcNAQcCoIIFZzCCBWMCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUXAQr0iF6uC+QQ52VizbBg9gA
# tmagggMOMIIDCjCCAfKgAwIBAgIQF45a52Wr7YhMoaqRTJzY+zANBgkqhkiG9w0B
# AQUFADAdMRswGQYDVQQDDBJMb2NhbCBDb2RlIFNpZ25pbmcwHhcNMjAwNDI0MDY0
# MjQ4WhcNMzAwNDI0MDY1MjQ4WjAdMRswGQYDVQQDDBJMb2NhbCBDb2RlIFNpZ25p
# bmcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCzFKPnhtXbhGQg/FH3
# LODlqh1pkzQVyCZg5olEX2hgMhJ9bXqUjKcgHIaIj8rgqi9Vkk+sF+hKhPN/O9mQ
# ksTf1Rf5mZq72Gafuc4A6ifTrstDdAeDtgxZXAuoDSKABu2sHM3qMcmqORPRdxqP
# epo+SB2ZIXdOLkq2snDUoaS5oDosUmROalt6L9Jgm4Aw17BuUl4l1mnsRcCYz09n
# +G+QOR1Pxp2CSz5VpiNTIzYP/tfHgymh6BueEUY5Bm2AjmQULqk7FZut+WpMfqv1
# s6fq7Q5KbbqzCzJGiBdYzXtuX3lN+QprxrFUqvqoLyPZMyNxrBC9TmW22cpoBRRX
# yO8xAgMBAAGjRjBEMA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcD
# AzAdBgNVHQ4EFgQUGh9juQJ6uSsgREn8hJnKvw7q//owDQYJKoZIhvcNAQEFBQAD
# ggEBAEKeC4eJBP3tmLOT+QPdXZr4s1wBBDGBJd+w9+21XLB1YXOyiC0sAVIe5Gar
# 1pnVGDJFq3SoqzB91z0XqD8pfbJmcfSnujWx1ttdL9nq4VnHUAGDoIE++ZWRPYOE
# DWIuV4+eZdBkmV5jEHbfo/S3J7xPOijaxgNDlLiC4iH7OrIW8oI4o6fl/zZ7PMvF
# 6HGxeMmR4rt/WqhQk8GPW4nOeeWxJPhJE0GL7AKyLxC4dZDryqpC9f+WmjYoRFYk
# T+JhHHOHX4loyL1Oz9fiJ1GoVeUQGpkR3EAeGAS1DG57+l6QfWX2w9enx7JZ8DGO
# xM758r2wgk+q+xbb+N4c3tOfWN0xggHSMIIBzgIBATAxMB0xGzAZBgNVBAMMEkxv
# Y2FsIENvZGUgU2lnbmluZwIQF45a52Wr7YhMoaqRTJzY+zAJBgUrDgMCGgUAoHgw
# GAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGC
# NwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQx
# FgQU2GnLsZg8qT5et00fhqNOJm9QOeEwDQYJKoZIhvcNAQEBBQAEggEAo9RLfmc5
# vGBmco8E1F3NecnHkMGz6dY9oz6V+Q8TDJsvIjcS8V9zGqRfmtwZVuJw0zslWL52
# G9/JwQrp3mS7yh49GVykP1LsiZoohsS43SIeDvlrSJrvhe3HVAagg2zNhwrlHD2S
# Y0CNYVqKJohoY2x242S5DYKz1YjraI7TfF/eoRVqGnyqA9Js6A5h/LHURDCKGqRc
# hz155/OsNpmSMY8K7YFR+opFr/VRe5Cvw3du6b2R7xdozr9X8eG4OJww0tovGmHE
# 7TsnylP2g/8xcuYtlJoHtFgM0KpTdrBCt6DTJoQiU+YbutorWdL2/XH94cRTZL3A
# QtsbNuMqyf9Aow==
# SIG # End signature block
