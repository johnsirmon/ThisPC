# Collect system information
$OSInfo = Get-ComputerInfo -Property "OsName", "OsVersion"
$Memory = Get-ComputerInfo -Property "CsTotalPhysicalMemory"
$GraphicsCards = Get-WmiObject Win32_VideoController | ForEach-Object { "$($_.Name) (Driver Version: $($_.DriverVersion), Memory: $([Math]::Round($_.AdapterRAM / 1GB, 2)) GB)" }
$HardDrive = Get-WmiObject Win32_DiskDrive | Select-Object -First 1 Model, Size

# Format the data into a paragraph
$Paragraph = "My laptop has the following specs. Operating System: $($OSInfo.OsName), Version: $($OSInfo.OsVersion). Physical Memory: $([Math]::Round($Memory.CsTotalPhysicalMemory / 1GB, 2)) GB. Graphics Card(s): $($GraphicsCards -join ', '). Hard Drive: $($HardDrive.Model), Size: $([Math]::Round($HardDrive.Size / 1GB, 2)) GB. Additional System Information: [You can add more details here if needed]"

# Copy the paragraph to the clipboard
$Paragraph | Set-Clipboard

# Optionally, display the paragraph in the console
Write-Output $Paragraph
