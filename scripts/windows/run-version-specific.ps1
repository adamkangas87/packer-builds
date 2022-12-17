Start-Transcript -Path 'c:\temp\packer-log.txt' -append
Write-Output "Running Additonal OS Specific Scripts"
Get-ChildItem "C:\scripts" | ForEach-Object {
    if ($_.Extension -eq 'ps1')
    {
        & $_.FullName
    }
    
}
########################################################
#
#  Finalise
#
########################################################
Write-Output "Additonal OS Specific Scripts Completed..."
Stop-Transcript