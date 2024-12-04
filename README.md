# Born2beroot
+ Born2beroot is a project that aims to teach us about `virtualization` and system administration by setting up a server and configuring its security for the mandatory part and for the bonus part you'll try to host a site.
-----------------------------------------------------------------------
## Virtuallization
    ttttttt
----------------------------------------------------------------------
## Monitoring Script
+ The `monitoring.sh` script is a core part of your project. It will display essential system information in a clear format, including CPU usage, memory, disk usage, active users, and more. Below are detailed steps to write, configure, and test the script.
----------------------------------------------------------------------
### Step 1: Understand What the Script Needs to Display
+ The script should display the following information:

  + System Architecture and Kernel Version
  + Physical CPU count
  + Virtual CPUs count
  + Memory Usage
  + Disk Usage
  + CPU Load
  + Last Reboot Time
  + Number of Logged-in Users
  + Network Information (IP and MAC addresses)
  + Number of Processes
  + LVM (Logical Volume Management) Information
  + Firewall Status
  + Each of these will be implemented using Linux commands.
----------------------------------------------------------------------
### Step 2: Create and Edit the Script
+ Create the file:
```
sudo nano /usr/local/bin/monitoring.sh
```
+ This will create the script file and open it in the nano editor.
+ We use this path `/usr/local/bin/` : BCS Allows you to run the script by simply typing its name (e.g., monitoring.sh) without specifying the full path.
----------------------------------------------------------------------
+ Write the Script:
```
    #!/bin/bash

    info=$(uname -a)
    #-----------------------------------------------------------------#
    cpup=$(grep -c "physical id" /proc/cpuinfo)
    #-----------------------------------------------------------------#
    cpuv=$(grep -c "processor" /proc/cpuinfo)
    #-----------------------------------------------------------------#
    ram_total=$(free -m | awk '/^Mem:/ {print $2}')
    ram_use=$(free -m | awk '/^Mem:/ {print $3}')
    ram_percent=$(free -m | awk '/^Mem:/ {printf "%.2f", $3/$2*100}')
    #-----------------------------------------------------------------#
    disk_total=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_t += $2} END {printf "%dGb\n", disk_t/1024}')
    disk_use=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_u += $3} END {print disk_u}')
    disk_percent=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_u += $3} {disk_t += $2} END {printf "%d", disk_u/disk_t*100}')
    #--------------------------------------------------------------------------------------------------------------------------------#
    cpul=$(mpstat | tail -1 | awk '{printf "%.1f\n", 100 - $13}')
    #-----------------------------------------------------------------#
    lb=$(who -b | awk '$1 == "system" {print $3 " " $4}')
    #-----------------------------------------------------------------#
    lvm=$(if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo yes; else echo no; fi)
    #-----------------------------------------------------------------#
    ac=$(ss -ta | grep ESTAB | wc -l)
    #-----------------------------------------------------------------#
    logs=$(users | wc -w)
    #-----------------------------------------------------------------#
    ip=$(hostname -I)
    mac=$(ip addr | grep "link/ether" | awk '{print $2}')
    #-----------------------------------------------------------------#
    cmnd=$(journalctl _COMM=sudo | grep -c COMMAND)
    #-----------------------------------------------------------------#
    wall "	Architecture: $info
	CPU physical: $cpup
	vCPU: $cpuv
	Memory Usage: $ram_use/${ram_total}MB ($ram_percent%)
	Disk Usage: $disk_use/${disk_total} ($disk_percent%)
	CPU load: $cpul%
	Last boot: $lb
	LVM use: $lvm
	Connections TCP: $ac ESTABLISHED
	User log: $logs
	Network: IP $ip ($mac)
	Sudo: $cmnd cmd "
```
---------------------------------------------------------------------
+ the explanation :

  + `uname -a`  : used to display system information -a: Shows all available information about the system.
  ----------------------------------------------------------------------
  + `grep -c "physical id" /proc/cpuinfo` : counts the number of times the term "physical id" appears in the file /proc/cpuinfo.
  -------------------------------------------------------------------------
  + `grep -c "processor" /proc/cpuinfo` : counts the number of logical processors (CPU cores) in the system by searching for the keyword "processor" in the file /proc/cpuinfo.
  -------------------------------------------------------------------------
  + `free -m | awk '/^Mem:/ {print $2}'` : extracts and displays the total amount of physical memory (RAM) in megabytes (MB) from the free command's output.
  + `free -m | awk '/^Mem:/ {print $3}'` extracts and displays the amount of memory currently in use (in megabytes, MB) from the output of the free command.
  + `free -m | awk '/^Mem:/ {printf "%.2f", $3/$2*100}'` : calculates and displays the percentage of used memory on your system, based on the free command's output.
  -------------------------------------------------------------------------
  + `df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_t += $2} END {printf "%dGb\n", disk_t/1024}'` : calculates and displays the total disk size in gigabytes (GB) of all mounted filesystems located under /dev/, excluding the /boot partition.
  + `df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_u += $3} END {print disk_u}'` : calculates and displays the total used disk space (in megabytes, MB) of all mounted filesystems under /dev/, excluding the /boot partition.
  + `df -m | grep "/dev/" | grep -v "/boot" | awk '{disk_u += $3} {disk_t += $2} END {printf "%d", disk_u/disk_t*100}'` : calculates the percentage of used disk space across all mounted filesystems under /dev/, excluding the /boot partition.
  -------------------------------------------------------------------------
  + `mpstat | tail -1 | awk '{printf "%.1f\n", 100 - $13}'` : calculates and displays the average CPU usage percentage for all processors, excluding idle time.
  -------------------------------------------------------------------------
  + `who -b | awk '$1 == "system" {print $3 " " $4}'` : extracts and displays the last system boot time.
  ------------------------------------------------------------------------ 
  + `if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo yes; else echo no; fi` : checks if there are any LVM (Logical Volume Manager) partitions on the system. If LVM partitions exist, it outputs yes; otherwise, it outputs no.
  ------------------------------------------------------------------------ 
  + `ss -ta | grep ESTAB | wc -l` : counts the number of active TCP connections in the "ESTABLISHED" state on the system.
  ------------------------------------------------------------------------ 
  + `users | wc -w` : counts the number of logged-in users currently on the system.
  ------------------------------------------------------------------------ 
  + `hostname -I` : displays the IP addresses assigned to the host's network interfaces.
  + `ip addr | grep "link/ether" | awk '{print $2}'` : extracts and displays the MAC addresses of all active network interfaces on your system.
  ------------------------------------------------------------------------ 
  + `journalctl _COMM=sudo | grep -c COMMAND ` : is used to count the number of times the sudo command has been executed on the system.
  ------------------------------------------------------------------------ 
  + `wall` : The wall command in Linux is used to broadcast messages to all logged-in users on the system. This can be helpful for administrators to send important announcements, warnings, or maintenance notices.
  ------------------------------------------------------------------------
### Step 3: Make the Script Executable
+ After saving the script, make it executable:
```
sudo chmod +x /usr/local/bin/monitoring.sh
```
------------------------------------------------------------------------
### Step 4: Automate the Script Execution
+ Schedule the Script with Cron:
  + Open the crontab editor:
	```
	sudo crontab -e
	```
  + Add the following line to execute the script every 10 minutes:
	```
	*/10 * * * * /usr/local/bin/monitoring.sh 
	```
------------------------------------------------------------------------
+ crontab : is a configuration file used in Linux to schedule automated tasks, commonly referred to as "cron jobs." These tasks can run at specific times or intervals without manual intervention.
+ Each line in the crontab file follows this format: `minute hour day month weekday <command>`
------------------------------------------------------------------------


