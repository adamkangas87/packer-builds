Start-Transcript -Path 'c:\temp\packer-log.txt' -append
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force
########################################################
#
#  Boot Hole Fix
#
########################################################
Write-Output "Security Fix - BootHole ......"
Disable-TlsCipherSuite -Name "TLS_RSA_WITH_3DES_EDE_CBC_SHA"
Stop-Transcript