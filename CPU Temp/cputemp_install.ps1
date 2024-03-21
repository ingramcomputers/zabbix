# Make sure the bin folder extist
$dir = "C:\IT-Support\bin"
if(!(Test-Path -Path $dir )){
    New-Item -ItemType directory -Path $dir
    Write-Host "C:\IT-Support\bin folder created"
}
else { Write-Host "C:\IT-Support\bin Folder already exists" }

# Download the program to the IT Support bin folder
(New-Object System.Net.WebClient).DownloadFile("https://github.com/VF2048/LibreHardwareMonitorCLI/releases/download/12.02.2024/LibreHardwareMonitorCLI.7z", "C:\IT-Support\LibreHardwareMonitorCLI.7z")

# Extract the file
$command = "C:\Program Files\7-Zip\7z.exe"
$parms = "e C:\IT-Support\LibreHardwareMonitorCLI.7z -oC:\IT-Support\bin"
$Prms = $Parms.Split( )
& "$command" $Prms

# Wait for things to complete because powershell can be a bitch
Start-Sleep 15
# Delete the file to keep thing tidy
Remove-Item C:\IT-Support\LibreHardwareMonitorCLI.7z

# Download the script to run and send temp to Zabbix
(New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/ingramcomputers/zabbix/main/CPU%20Temp/cputemp.ps1", "C:\IT-Support\bin\cputemp.ps1")

# Create the scheduled task that runs every 5 minutes
$Trigger = New-ScheduledTaskTrigger -Daily -At '00:00'
$Action = New-ScheduledTaskAction -Execute "PowerShell" -Argument "C:\IT-Support\bin\cputemp.ps1"
$Principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount
$task = Register-ScheduledTask -TaskName "Zabbix CPU Temperature" -Trigger $Trigger -Action $Action -Principal $Principal
$task.Triggers.Repetition.Duration = 'P7300D'
$task.Triggers.Repetition.Interval = 'PT5M'
$task | Set-ScheduledTask

