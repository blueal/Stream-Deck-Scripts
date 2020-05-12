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
#     See the readme file for information
#
#########################################################################

#Toggles Video.

#Checks if zoom is running, toggles video if it is.


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
    public class test {
        [DllImport("user32.dll")]
        public static extern IntPtr GetForegroundWindow();
    }
"@

    $a = [test]::GetForegroundWindow()                    #Gets the process ID of the current window
    #get-process | ? { $_.mainwindowhandle -eq $a }       #Displays the process ID info using the current list of running Proccesses


                                                          #Now we check if the current window is the Zoom Process!
    if ((get-process | ? { $_.mainwindowhandle -eq $a }) -like '*Zoom*'){
        $wshell.SendKeys('%v')                            #Zoom is open! Send the Key!
        Start-Sleep -m 1                                      #Send Keys is glitchy, wait 1ms
    }

}
Remove-Variable zoom
# SIG # Begin signature block
# MIIFdgYJKoZIhvcNAQcCoIIFZzCCBWMCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUxe+vGMaxlRcjb2pA115z2h2q
# XNWgggMOMIIDCjCCAfKgAwIBAgIQF45a52Wr7YhMoaqRTJzY+zANBgkqhkiG9w0B
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
# FgQUBrP52H3pNjWXMr/z3YbdhvxmTF4wDQYJKoZIhvcNAQEBBQAEggEAiVX4eq3Z
# S/HOe+qCoIYOJSfUHKRjj46gAzfync8ALdrswUdtJo401e2xDj40MVFTa0l5QchM
# y1AQ8N7o8dPCKFDno2bjSPaMP+4UfHhDbi4s7YYHsfQ8TP8FCw1Bw9QwBGwO5czp
# GnOXi2vg7O/SyCyGQrNNu4HB6X6iSlGD+YLSFx3OCjKdOTBjuAzMdQaToNnijfgh
# 0wq7p/NYzylpBGG+aIliAOC3tH0mbOTzjeevMLPdT434NwwzZC7Q1bLaGHRUX1fk
# wLAXWfFxeZhZSNR9be8++X9xkYmNF+LbKXxFQGDKPL0kFNEYhKr8tACpDGQ+hoyx
# 3sR+0aAKAa0Jrg==
# SIG # End signature block
