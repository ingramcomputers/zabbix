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

Start-Sleep 15

Remove-Item C:\IT-Support\LibreHardwareMonitorCLI.7z
