Start-Transcript -Path 'c:\temp\packer-log.txt' -append
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force
########################################################
#
#  Reset Empty Space
#
# https://github.com/mwrock/packer-templates
########################################################
Write-Output "Resetting Empty Space......"
$FilePath="c:\zero.tmp"
$Volume = Get-WmiObject win32_logicaldisk -filter "DeviceID='C:'"
$ArraySize= 64kb
$SpaceToLeave= $Volume.Size * 0.05
$FileSize= $Volume.FreeSpace - $SpacetoLeave
$ZeroArray= new-object byte[]($ArraySize)
 
$Stream= [io.File]::OpenWrite($FilePath)
try {
   $CurFileSize = 0
    while($CurFileSize -lt $FileSize) {
        $Stream.Write($ZeroArray,0, $ZeroArray.Length)
        $CurFileSize +=$ZeroArray.Length
    }
}
finally {
    if($Stream) {
        $Stream.Close()
    }
}

Del $FilePath
Stop-Transcript