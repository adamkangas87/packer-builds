Start-Transcript -Path 'c:\temp\packer-log.txt' -append
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force
########################################################
#
#  Clean update cache
#
# https://github.com/mwrock/packer-templates
########################################################
Write-Output "Cleaning updates....."
Stop-Service -Name wuauserv -Force
Remove-Item c:\Windows\SoftwareDistribution\Download\* -Recurse -Force
Start-Service -Name wuauserv
Stop-Transcript