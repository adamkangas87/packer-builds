Start-Transcript -Path 'c:\temp\packer-log.txt' -append
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force
########################################################
#
#  Boot Hole Fix
#
########################################################
Write-Output "Security Fix - BootHole ......"
Install-PackageProvider -Name Nuget -Force -Confirm:$false -Scope AllUsers
Install-Script -Name SplitDbxContent -Force -Confirm:$false -Scope AllUsers
Invoke-WebRequest -Uri "https://uefi.org/sites/default/files/resources/dbxupdate_x64.bin" -OutFile "C:\temp\dbxupdate.bin"
Set-Location c:\temp
SplitDbxContent.ps1 .\dbxupdate.bin
Set-SecureBootUefi -Name dbx -ContentFilePath .\content.bin -SignedFilePath .\signature.p7 -Time 2010-03-06T19:17:21Z -AppendWrite
Stop-Transcript