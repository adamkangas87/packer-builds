Start-Transcript -Path 'c:\temp\packer-log.txt' -append
Write-Output "Running Tidy Script"
if (Test-Path "C:\Scripts")
{
    Remove-Item "C:\Scripts" -Recurse -Force -Confirm:$false
}
########################################################
#
#  Finalise
#
########################################################
Write-Output "Tidy Script Completed..."
Stop-Transcript