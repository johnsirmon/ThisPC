# Collect system information
$OSInfo = Get-ComputerInfo -Property "OsName", "OsVersion"
$Memory = Get-ComputerInfo -Property "CsTotalPhysicalMemory"
$GraphicsCard = Get-WmiObject Win32_VideoController | Select-Object -First 1 Name, DriverVersion, AdapterRAM
$HardDrive = Get-WmiObject Win32_DiskDrive | Select-Object -First 1 Model, Size

# Format the data into a paragraph
$Paragraph = @"
Operating System: $($OSInfo.OsName), Version: $($OSInfo.OsVersion)
Total Physical Memory: $([Math]::Round($Memory.CsTotalPhysicalMemory / 1GB, 2)) GB
Graphics Card: $($GraphicsCard.Name), Driver Version: $($GraphicsCard.DriverVersion), Memory: $([Math]::Round($GraphicsCard.AdapterRAM / 1GB, 2)) GB
Hard Drive: $($HardDrive.Model), Size: $([Math]::Round($HardDrive.Size / 1GB, 2)) GB
Additional System Information: [You can add more details here if needed]
"@

# Copy the paragraph to the clipboard
$Paragraph | Set-Clipboard

# Optionally, display the paragraph in the console
Write-Output $Paragraph
