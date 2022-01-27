$filelist = "C$\Windows\ServiceProfiles\LocalService\AppData\Local\Temp\*"
$computerlist = Get-Content C:\AgentList.txt

foreach ($file in $filelist){
    foreach ($computer in $computerlist){
        Write-Host -ForegroundColor Yellow "Analysing $computer"

        $newfilepath = Join-Path "\\$computer\" "$file"
        if (test-path $newfilepath){
            Write-Host "$newfilepath file exists"
            try
            {
                Remove-Item $newfilepath -force -recurse
            }
            catch
            {       
                Write-host "Error while deleting $newfilepath on $computer.`n$($Error[0].Exception.Message)"
                       
            }
            Write-Host "$newfilepath file deleted"
        } else {
            Write-Information -MessageData "Path $newfilepath does not exist"
        }
    }
}

