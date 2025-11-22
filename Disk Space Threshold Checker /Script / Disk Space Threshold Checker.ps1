$threshold = 0.20
$adcomputers = (Get-ADComputer -Filter *).Name

foreach ($i in $adcomputers) {

    $free = Invoke-Command -ComputerName $i -ScriptBlock {
        (Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3").FreeSpace
    }

    $diskname = Invoke-Command -ComputerName $i -ScriptBlock {
        (Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3").DeviceID
    }

    $size = Invoke-Command -ComputerName $i -ScriptBlock {
        (Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3").Size
    }

    $below = 0
    $above = 0

    for ($j = 0; $j -lt $diskname.Count; $j++) {

        $disk = $diskname[$j]

        Write-Host "Checking disk $disk on computer $i"

        if ($free[$j] -lt ($threshold * $size[$j])) {
            Write-Host "Disk $disk's space is below threshold on computer $i" -ForegroundColor Red
            $below++
        }
        else {
            Write-Host "Disk $disk's space is above threshold on computer $i" -ForegroundColor Green
            $above++
        }
    }

    if ($below -eq 0) {
        Write-Host "No volumes have been found below threshold" -ForegroundColor Yellow
    }
    else {
        Write-Host "$below volumes have been found below threshold" -ForegroundColor Yellow
    }

    if ($above -eq 0) {
        Write-Host "No volumes have been found above threshold" -ForegroundColor Yellow
    }
    else {
        Write-Host "$above volumes have been found above threshold" -ForegroundColor Yellow
    }

}
