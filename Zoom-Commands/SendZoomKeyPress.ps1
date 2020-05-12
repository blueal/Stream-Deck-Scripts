#####################WARNING################################
#     
#     Version 1.0.0
#     Verified compaitability with Zoom 5.0.2 Windows Client
#     Author: Alex Friedberg
#     License: GNU AGPL
#
#
#
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
#     See the readme file in `example scripts` for information
#
#########################################################################

#Asks for a key press, if zoom is running and in a meeting, sends key presses (or key presses) to Zoom

#This script is typically used for quiting, mic and video toggle

param (

    [Parameter(Mandatory=$True,Position=1)]
    [string]
    $KeyPress
    )


$zoom = Get-Process Zoom -ErrorAction SilentlyContinue        #Check if Zoom is Running
if ($zoom) {
    $wshell = New-Object -ComObject wscript.shell;
    if($wshell.AppActivate('Zoom Meeting') -or $wshell.AppActivate('Meeting Controls')) {
        "SUCCESS: Meeting Detected, sending keystroke: " + $KeyPress
        Start-Sleep -m 1                                      #Send Keys is glitchy, wait 1ms
        $wshell.SendKeys($KeyPress)                           #Zoom is open! Send The Key!
        Start-Sleep -m 1                                      #Send Keys is glitchy, wait 1ms
    }
    else{
        "ERROR: No Meeting Detected"
    }
}
exit
# SIG # Begin signature block
# MIIFdgYJKoZIhvcNAQcCoIIFZzCCBWMCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUAh/VSsUIdIeVTyv/DighYqbX
# 18ugggMOMIIDCjCCAfKgAwIBAgIQF45a52Wr7YhMoaqRTJzY+zANBgkqhkiG9w0B
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
# FgQUap67vATFPq48ftT+PUsJCi0hEgcwDQYJKoZIhvcNAQEBBQAEggEAff5dexy3
# dpwoZ9tDtVNlMRNUzpH33rXOfnxwUARA0wIw7zZncOf/OuUZKOYcvC65Q5gH3fYM
# LeJtnvYEoNhBZyFRPCaVGqd0b18DGRMTaqMXAgBK3Z8DnI/m2M7AZ+6rj2CJSMUy
# 2rftJeq86yASH97ZjzqT2uNN5lkvdnVtL+5nt3DB7dmMmdQFqdfwX3ID9VhvDOfg
# muA5nK74NgN7O2H1QGZdffEab7QDK1dnW5NRdu8m1NEUOUBzqNIvBUt6c0soiS/4
# TdJpZK5DnBjuEZrb3vWh/NYSf7krQXHV/un7QD3umhdle1VSlR5VQi0IFIAKhkRD
# YoYt22lDuUdyVQ==
# SIG # End signature block
