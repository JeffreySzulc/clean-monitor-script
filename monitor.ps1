# monitor.ps1

Write-Host "System Resource Report - $(Get-Date)"
Write-Host "------------------------------------"

# Uptime
$uptime = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
$uptimeFormatted = [System.Management.ManagementDateTimeConverter]::ToDateTime($uptime)
Write-Host "Uptime (Last Boot): $uptimeFormatted`n"

# CPU Usage
$cpuLoad = Get-CimInstance Win32_Processor | Select-Object -ExpandProperty LoadPercentage
Write-Host "CPU Load: $cpuLoad%`n"

# Memory Usage
$mem = Get-CimInstance Win32_OperatingSystem
$total = [math]::Round($mem.TotalVisibleMemorySize / 1MB, 2)
$free = [math]::Round($mem.FreePhysicalMemory / 1MB, 2)
$used = [math]::Round($total - $free, 2)
Write-Host "Memory Usage: $used GB / $total GB`n"

# Disk Usage (C drive)
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$size = [math]::Round($disk.Size / 1GB, 2)
$freeSpace = [math]::Round($disk.FreeSpace / 1GB, 2)
$usedSpace = [math]::Round($size - $freeSpace, 2)
Write-Host "Disk Usage (C:): $usedSpace GB / $size GB"
