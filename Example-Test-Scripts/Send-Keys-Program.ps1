<#
.SYNOPSIS
Send a sequence of keys to an application window

.DESCRIPTION
This Send-Keys script send a sequence of keys to an application window.
To have more information about the key representation look at http://msdn.microsoft.com/en-us/library/System.Windows.Forms.SendKeys(v=vs.100).aspx
(C)2013 Massimo A. Santin - Use it at your own risk.

.PARAMETER ApplicationTitle
The title of the application window

.PARAMETER Keys
The sequence of keys to send

.PARAMETER WaitTime
An optional number of seconds to wait after the sending of the keys

.EXAMPLE
Send-Keys "foobar - Notepad" "Hello world"

Send the sequence of keys "Hello world" to the application titled "foobar - Notepad".

.EXAMPLE
Send-Keys "foobar - Notepad" "Hello world" -WaitTime 5

Send the sequence of keys "Hello world" to the application titled "foobar - Notepad" 
and wait 5 seconds.

.EXAMPLE 
    New-Item foobar.txt -ItemType File; notepad foobar.txt ; Send-Keys "foobar - Notepad" "Hello world{ENTER}Ciao mondo{ENTER}" -WaitTime 1; Send-Keys "foobar - Notepad" "^s"

This command sequence creates a new text file called foobar.txt, opens the file using a notepad,
writes some text and saves the file using notepad.

.LINK
http://msdn.microsoft.com/en-us/library/System.Windows.Forms.SendKeys(v=vs.100).aspx
#>

param (
    [Parameter(Mandatory=$True,Position=1)]
    [string]
    $ApplicationTitle,

    [Parameter(Mandatory=$True,Position=2)]
    [string]
    $Keys,

    [Parameter(Mandatory=$false)]
    [int] $WaitTime
    )

# load assembly cotaining class System.Windows.Forms.SendKeys
[void] [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
#Add-Type -AssemblyName System.Windows.Forms

# add a C# class to access the WIN32 API SetForegroundWindow
Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class StartActivateProgramClass {
        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool SetForegroundWindow(IntPtr hWnd);
    }
"@

# get the applications with the specified title
$p = Get-Process | Where-Object { $_.MainWindowTitle -eq $ApplicationTitle }
if ($p) 
{
    # get the window handle of the first application
    $h = $p[0].MainWindowHandle
    # set the application to foreground
    [void] [StartActivateProgramClass]::SetForegroundWindow($h)

    # send the keys sequence
    # more info on MSDN at http://msdn.microsoft.com/en-us/library/System.Windows.Forms.SendKeys(v=vs.100).aspx
    [System.Windows.Forms.SendKeys]::SendWait($Keys)
    if ($WaitTime) 
    {
        Start-Sleep -Seconds $WaitTime
    }
}
# SIG # Begin signature block
# MIIFdgYJKoZIhvcNAQcCoIIFZzCCBWMCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUIQ7VkAyiuwORAcCIc1CLwPlv
# jN6gggMOMIIDCjCCAfKgAwIBAgIQF45a52Wr7YhMoaqRTJzY+zANBgkqhkiG9w0B
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
# FgQUt1A9B7iJRUICifchlK0COw81bxgwDQYJKoZIhvcNAQEBBQAEggEAD2Z9fi/n
# a7DZfFQq7WJqQReFdHi/Bv+pw3te57WBWAzdXhK3RjcwKjFPATj7/5u3RDNV2ntW
# UZfJT/WLSaeet42+nuD5Z48RYmGahkqDxJc48yRln1De16h/HgZaKrLUN2LVo/cT
# d762HNgXn8ciHoluU2COZXAtxuAAdY8kjx4KfTxAGtB6BYuDvI7gs3AbCbcSiJdD
# nm3IAw61ShcHiCBPLHNQzZAXwtY6NmcgpqbP+tuk1G22Mf66Wmy+mTgZKWrivxPs
# 5NHCq+BepYE5nCc8gcJad1Os6Efh93+wxDhRgF/ptTT2aTqHx5csOLTJsf0hbARd
# PpXYWa3Udky+vA==
# SIG # End signature block
