# CPU Temperature

Using the LibrehardwareMonitor CLI (https://github.com/VF2048/LibreHardwareMonitorCLI)

### cputemp_install.ps1

Use this script to download the 7z file and extract to a folder.
Will also create a scheduled task.

### cputemp.ps1

This script will run on a schedule and upload the value to Zabbix.

### Create Item

Create a template with this item or just a new item on a host. But it needs to look like this.

![CPU Temp/zabbix_template.png](https://github.com/ingramcomputers/zabbix/blob/26ab94fd964b6e4b77cf6676712734120b194956/CPU%20Temp/zabbix_template.png)