# Born2beroot
+ Born2beroot is a project that aims to teach us about **virtualization** and **system administration** by setting up a **server** and configuring its security for the mandatory part and for the bonus part you'll try to host a site.
-----------------------------------------------------------------------
### Install your virtual machine
+ for Debian and if you want to do the bonus part :
+ (https://youtu.be/73r3JbkCVy0?si=A68GjkJJofwhX0f0)
-----------------------------------------------------------------------
## I . Virtuallization
+ 1 . What is a **Virtual Machine** (VM)?
	+ A virtual machine is a computer inside another computer.
	+ It runs its own operating system (e.g., Linux) but uses the hardware (CPU, RAM, storage) of the main machine (called the host).
	+ Example: Your main computer runs Windows, but you install a VM to run Linux without affecting your main system.

	-----------------------------------------------------------------------
+ 2 . How Does **Virtualization** Work?
	+ **Virtualization** allows you to split your physical computer into multiple virtual computers (VMs).
	+ A software called a **hypervisor** manages the VMs and shares the host’s hardware between them.
	+ Each VM behaves like a real computer with its own OS and applications.
 
	![image](https://github.com/user-attachments/assets/f3c14b18-05d2-4ba3-aea3-d918871d6533)

	-----------------------------------------------------------------------
+ 3 . Advantages of a **Virtual Machine**
	+ Isolation: VMs are separate, so problems in one VM don’t affect the host or other VMs.
	+ Testing: Safe for experimenting with new systems or software.
	+ Cost-Efficient: No need for multiple physical machines.
	+ Backup & Portability: Easy to save and move VMs to other systems.
	+ Efficient Use of Resources: Share your computer's hardware among multiple VMs.

	-----------------------------------------------------------------------
+ 4 . Types of **Hypervisors**
	+ A hypervisor is the software that creates and manages VMs.

	+ Type 1 (Bare-Metal):
		+ Runs directly on the hardware (no OS in between).
		+ Used in large data centers or servers.
		+ Example: VMware ESXi, Microsoft Hyper-V.
	+ Type 2 (Hosted):
		+ Runs on top of an existing operating system.
		+ Easier to set up on personal computers.
		+ Example: VirtualBox, VMware Workstation.

	![image](https://github.com/user-attachments/assets/89511cb8-7ad7-4fc5-8796-26e3df8ddccc)

	-----------------------------------------------------------------------
+ 5 . What is **System Administration**?
	+ System Administration involves managing and maintaining computer systems and networks.
	+ Tasks include:
		+ Installing and updating software.
		+ Managing users and permissions.
		+ Monitoring system performance.
		+ Backing up and restoring data.
		+ Ensuring system security.
	+ Example: A system administrator (sysadmin) ensures a company’s servers run smoothly.

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
## BONUS
### what is WordPress, what is lighttpd, what is PHP, what is MariaDB, ow do they work together :
+ 1. What is WordPress?
	+ WordPress is a tool for creating websites and blogs.
	+ It’s user-friendly and doesn’t require coding knowledge.
	+ Example: You can use WordPress to create a blog, portfolio, or even an online store.
	------------------------------------------------------------------------
+ 2. What is lighttpd?
	+ lighttpd is a web server.
	+ It delivers your website (e.g., WordPress) to users’ browsers when they visit your site.
	+ Think of it as the “waiter” that brings the website (stored on your VM) to people online.
	------------------------------------------------------------------------
+ 3. What is PHP?
	+ PHP is a programming language that runs on the server.
	+ WordPress uses PHP to process requests like creating posts or loading pages dynamically.
	+ Example: If someone visits your WordPress blog, PHP generates the page they see.
	------------------------------------------------------------------------
+ 4. What is MariaDB?
	+ MariaDB is a database system that stores your website data.
	+ It keeps everything like blog posts, user accounts, and comments organized.
	+ WordPress retrieves data from MariaDB when needed (e.g., when displaying a blog post).
	------------------------------------------------------------------------
+ 5. How Do They Work Together?
	When someone visits your WordPress site:

	+ lighttpd (web server) receives the visitor’s request.
	+ PHP processes the request (e.g., fetching blog posts or login pages).
	+ MariaDB provides the necessary data (e.g., blog content or user details).
	+ lighttpd sends the generated page to the user’s browser.
	+ It’s like:

		+ WordPress: The website.
		+ lighttpd: The delivery service.
		+ PHP: The chef preparing the website.
		+ MariaDB: The storage room with all the ingredients (data).
------------------------------------------------------------------------
### Prometheus service :
+ What is Prometheus? :
 	+ Prometheus is an open-source monitoring and alerting tool designed for collecting, storing, and analyzing metrics from systems, applications, and services.
	------------------------------------------------------------------------
+ Why Do We Use It? :
	+ `Monitor System Performance`: It helps track CPU usage, memory, disk, and other system metrics.
	+ `Alerting`: It sends alerts when something goes wrong (e.g., high CPU usage).
	+ `Scalability`: Works well with dynamic systems like VMs or containerized apps.
	+ `Ease of Use`: It is lightweight and easy to integrate with modern tools.
	------------------------------------------------------------------------
+ How Does It Work? :
	+ `Data Collection`: Prometheus uses exporters (small programs) to collect metrics from servers or applications.
	+ `Example`: node_exporter collects system-level metrics.
	+ `Storage`: Prometheus stores metrics in a time-series database (metrics over time).
	+ `Querying`: Metrics are analyzed using a query language called PromQL.
	+ `Alerts`: Alerts are triggered based on specific conditions you define in rules.
	------------------------------------------------------------------------
+ Why Is It Useful? :
	+ `Proactive Monitoring`: Quickly spot issues before they become big problems.
	+ `Detailed Insights`: See trends over time (e.g., performance spikes).
	+ `Automation`: Alerts help automate responses to failures or anomalies.
	------------------------------------------------------------------------
+ In short, Prometheus is great for keeping your systems healthy, tracking performance, and reacting to problems faster.
------------------------------------------------------------------------
## III - Sources
+ (https://github.com/42-adbouras/Born2beroot-1337MED/tree/master)
+ (https://github.com/RIDWANE-EL-FILALI/Born2beroot/blob/master/Configuration.md)
+ (https://42-cursus.gitbook.io/guide/rank-01/born2beroot/whats-a-virtual-machine)
+ ChatGPT, Youtube, Google, trust me broo.
