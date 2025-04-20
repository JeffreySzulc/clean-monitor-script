Write-Host "✅ Running Clean Monitor Script"

Write-Host "`nSystem Resource Report - $(Get-Date -Format 'MM/dd/yyyy HH:mm:ss')"
Write-Host "----------------------------------------------`n"

# Uptime (Last Boot + Duration)
$boot = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$uptime = (Get-Date) - $boot

Write-Host "Last Boot Time : $boot"
Write-Host "System Uptime  : $($uptime.Days) days, $($uptime.Hours) hrs, $($uptime.Minutes) mins`n"

# CPU Usage
$cpuLoad = (Get-CimInstance Win32_Processor).LoadPercentage
Write-Host "CPU Load       : $cpuLoad%`n"

# Memory Usage (in GB)
$mem = Get-CimInstance Win32_OperatingSystem
$totalMem = [math]::Round($mem.TotalVisibleMemorySize / 1MB, 2)
$freeMem = [math]::Round($mem.FreePhysicalMemory / 1MB, 2)
$usedMem = [math]::Round($totalMem - $freeMem, 2)
Write-Host "Memory Usage   : $usedMem GB / $totalMem GB`n"

# Disk Usage (C: drive only)
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$diskSize = [math]::Round($disk.Size / 1GB, 2)
$diskFree = [math]::Round($disk.FreeSpace / 1GB, 2)
$diskUsed = [math]::Round($diskSize - $diskFree, 2)
Write-Host "Disk Usage (C:): $diskUsed GB / $diskSize GB`n"
