# Collect system information
$OSInfo = Get-ComputerInfo -Property "OsName", "OsVersion", "OsBuildNumber"
$Memory = Get-ComputerInfo -Property "CsTotalPhysicalMemory"
$CPU = Get-WmiObject Win32_Processor | Select-Object -First 1 Name, NumberOfCores, NumberOfLogicalProcessors
$GraphicsCards = Get-WmiObject Win32_VideoController | ForEach-Object { "$($_.Name) (Driver Version: $($_.DriverVersion), Memory: $([Math]::Round($_.AdapterRAM / 1GB, 2)) GB)" }
$HardDrive = Get-WmiObject Win32_DiskDrive | Select-Object -First 1 Model, Size
$NetworkAdapters = Get-WmiObject Win32_NetworkAdapter | Where-Object { $_.NetConnectionStatus -eq 2 } | ForEach-Object { $_.Name }

# Format the data into a paragraph
$Paragraph = "My local machine has the following configuration: Operating System: $($OSInfo.OsName), Version: $($OSInfo.OsVersion), Build: $($OSInfo.OsBuildNumber). Physical Memory: $([Math]::Round($Memory.CsTotalPhysicalMemory / 1GB, 2)) GB. CPU: $($CPU.Name), Cores: $($CPU.NumberOfCores), Logical Processors: $($CPU.NumberOfLogicalProcessors). Graphics Card(s): $($GraphicsCards -join ', '). Hard Drive: $($HardDrive.Model), Size: $([Math]::Round($HardDrive.Size / 1GB, 2)) GB. Network Adapter(s): $($NetworkAdapters -join ', '). Additional System Information: [You can add more details here if needed]"

# Copy the paragraph to the clipboard
$Paragraph | Set-Clipboard

# Optionally, display the paragraph in the console
Write-Output $Paragraph
