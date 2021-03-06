﻿#####################WARNING################################
#     THE PERMISSIONS TO RUN POWERSHELLS SCRIPTS
#     MUST BE ENABLED                
#     https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7
#
#     I reccomend simply setting the current user permission to "AllSigned" Only. This will allow only locally made scripts to be run
#
#     Run this command to set it to allow only for current user
#     Set-ExecutionPolicy -ExecutionPolicy AllSigned -Scope CurrentUser
#
#     To Revert to safe deafaults run this:
#     Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser
#
#     See the readme file for information
#
#########################################################################

#Asks for a key press, if zoom is running and in a meeting, sends key presses (or key presses) to Zoom

#This script is typically used for quiting, mic and video toggle

param (

    [Parameter(Mandatory=$True,Position=1)]
    [string]
    $KeyPress
    )


$zoom = Get-Process Zoom -ErrorAction SilentlyContinue    #Check if Zoom is Running
if ($zoom) {
    $wshell = New-Object -ComObject wscript.shell;
    $wshell.SendKeys('^%+')                               #Ctrl+Alt+Shift Sets focus to Zoom Meeting Window, it will set the meeting as the active window
    Start-Sleep -m 1                                     #Send Keys is glitchy, wait 1ms

                                                          #We know Zoom is running, check the current window.
                                                          #If we're in the meeting, the hotkey we just pressed should have just changed the current window
                                                          #Setup for getting the current window
    Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class trick {
        [DllImport("user32.dll")]
        public static extern IntPtr GetForegroundWindow();
    }
"@

    $a = [trick]::GetForegroundWindow()                    #Gets the process ID of the current window
    #get-process | ? { $_.mainwindowhandle -eq $a }       #Displays the process ID info using the current list of running Proccesses


                                                          #Now we check if the current window is the Zoom Process!
    if ((get-process | ? { $_.mainwindowhandle -eq $a }) -like '*Zoom*'){
        $wshell.SendKeys($KeyPress)                            #Zoom is open! Send The Key!
        Start-Sleep -m 1                                      #Send Keys is glitchy, wait 1ms
    }

}
Remove-Variable zoom

# SIG # Begin signature block
# MIIFdgYJKoZIhvcNAQcCoIIFZzCCBWMCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUcHN8GvVZ+ZXATyrQCNXMs3bH
# gXugggMOMIIDCjCCAfKgAwIBAgIQF45a52Wr7YhMoaqRTJzY+zANBgkqhkiG9w0B
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
# FgQUkCggRIEbefaPZBF/64hc1rQnbocwDQYJKoZIhvcNAQEBBQAEggEAri8L59qp
# yBB2Kfteu17FyCUJi63uHRG/BVLIpJ9dprqh2vXPrFOHIjGt+qSzoEYKvv9NJbUW
# 3QhAAtoNJ+yh8udI7dT7SNaGv8QgaMBAIgluCWjuZk0SYOZ63Z1erwQANfBR9LLa
# +lEJxPPfmFne2+dKjfe3czM9NRY3wDqYvVPATS1UIJSL2HCstXF3knw/5t2UiGaN
# 2rj7EDuMWnktlAm5LfaAISrgG3FWkuAtBZt9OWzOoEqbQMtBP+qkVjt0l4gj9jFl
# 7PglNU4WQfhtxVt58oTymj2f4txnWxrlx0BAPRhlTWBRoZtfU1x5ZSWPgLZy2WI7
# o71cRSWZYQcoZg==
# SIG # End signature block
