$command = iex C:\IT-Support\bin\LibreHardwareMonitorCLI.exe

# Regex to Extract the row we need
$regex = "Core Average: ([+-]?(?=\.\d|\d)(?:\d+)?(?:\.?\d*))(?:[Ee]([+-]?\d+))? Temperature"

# Extract the row
$found = $command -match $regex
if ($found) {
    $spid = $matches[1]
}

# Convert to String
$cputemp = $found | Out-String

# Function to strip everything out but decimals
Function get-Decimal-From-String {
    # Function receives string containing decimal
    param([String]$cputempraw)
    # Will keep only decimal - can be extended / modified for special needs
    $cputempraw = $cputemp -replace "[^\d*\.?\d*$/]" , ''
    # Convert to Decimal 
    [Decimal]$cputempraw
}
# Use the function to extract the decimals and as a variable
$cpu = get-Decimal-From-String 'Core Average'
Write-Host The CPU Temp is: $cpu C

# Use the Zabbix sender to upload the value to the server
& 'C:\Program Files\Zabbix Agent 2\zabbix_sender.exe' -c 'C:\Program Files\Zabbix Agent 2\zabbix_agent2.conf' -k temp.cpu -o $cpu -s $env:computername
