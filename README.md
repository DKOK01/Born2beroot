# **Born2beroot**

+ Born2beroot is a project that aims to teach us about **virtualization** and **system administration** by setting up a **server** and configuring its security for the mandatory part and for the bonus part you'll try to host a site.

-----------------------------------------------------------------------

### Install your virtual machine
+ for **Debian** and if you want to do the bonus part :
+ (https://youtu.be/73r3JbkCVy0?si=A68GjkJJofwhX0f0)

-----------------------------------------------------------------------
**==========================================================================================**

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

	<p align="center">
  <img src="https://www.interviewbit.com/blog/wp-content/uploads/2022/05/Hypervisors-1024x955.png" style="width:500px">
	</p>

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
**==========================================================================================**

## II . LVM

+ 1 . **What is LVM (Logical Volume Manager)?**
	+ LVM is a tool to manage storage on Linux more flexibly than traditional partitions.
	+ It allows you to resize, add, or combine storage space without restarting the system.
	+ Instead of using fixed partitions, LVM lets you group disks together and divide the space into "logical volumes.".
  
	-----------------------------------------------------------------------

+ 2 . **How Does **LVM** Work?**
	+ Think of it like a pool of storage:
		+ You combine one or more physical disks into a pool.
		+ You create logical volumes (similar to partitions) from the pool.
		+ You can easily resize or manage these volumes as your needs change
  
	-----------------------------------------------------------------------

+ 3 . **What Are the Components of LVM?**
	+ LVM has three main components:

	+ **Physical Volumes (PVs)**:

		+ These are the actual disks or partitions (e.g., /dev/sda1).
		+ Example: A hard drive or SSD.
	+ **Volume Groups (VGs)**:

		+ Combine one or more physical volumes into a pool of storage.
		+ Example: Combine two disks into one large storage pool.
	+ **Logical Volumes (LVs)**:

		Created from the volume group.
		These are the "usable partitions" where you can store files.
		Example: `/home`, `/var`, or `/mnt/data`.

		![image](https://github.com/user-attachments/assets/9a1b6449-ddf7-4d9f-8649-512767851107)

	-----------------------------------------------------------------------

+ 4 . **Why Do We Use LVM?**
	+ **Flexibility**: You can resize volumes (increase or reduce storage) as needed.
	+ **Snapshots**: You can create backups (snapshots) without stopping the system.
	+ **Better Disk Usage**: Combine multiple small disks into one large storage pool.
	+ **Easier Management**: Add more storage to the system without complex re-partitioning.
 
 	-----------------------------------------------------------------------

+ 5 . **What Are Partitions?**
	+ A partition is a way to divide a hard drive into separate sections.
	+ Each partition acts as an independent storage space.
	+ Example:
		+ One partition for the operating system (e.g., /).
		+ One partition for user data (e.g., /home).
  
----------------------------------------------------------------------
**==========================================================================================**

## III . Linux File System 

+ 1 . What is a File System in Linux?
	+ A file system is how Linux organizes and stores data on storage devices (like a hard drive or SSD).
	+ It manages files (data) and directories (folders) and controls how data is written, read, and accessed.
	+ Example: When you save a file, the file system determines where on the disk the data is stored.
	----------------------------------------------------------------------
  
+ 2 . Types of File Systems in Linux
	+ Some common types of file systems:

	+ **ext4** (Fourth Extended File System):
	The most commonly used file system in Linux.
	Reliable and fast, supports large files and drives.
	+ **ext3** (Third Extended File System):
		An older version of ext4, slower but still used sometimes.
	+ **xfs**:
		Great for handling very large files and fast performance.
	+ **btrfs** (B-tree File System):
		Advanced features like snapshots and better error handling.
	+ **FAT32/NTFS**:
		Used by Windows; Linux can read/write these file systems for compatibility.
	+ **Swap**:
		Special file system used for virtual memory (to extend RAM).

	----------------------------------------------------------------------
  
+ 3 . Purpose of a File System
	+ Why do we need a file system?

	+ **Organization**: Keeps files and directories in a structured way so you can find them.
	+ **Efficiency**: Stores data efficiently on a disk.
	+ **Access Control**: Manages who can read, write, or execute files (permissions).
	+ **Error Management**: Ensures the integrity of data in case of crashes.

	----------------------------------------------------------------------
  
+ 4 . What is the Directory Structure in Linux?
	+ Linux uses a hierarchical directory structure (tree-like form). The root directory (/) is at the top.
	+ Key Directories:

	+ `/ (Root)`:
		+ The starting point of the Linux file system. Everything is inside /.

	+ `/home`:
		+ Stores personal files for users.
		+ Example: Your desktop files are in /home/username.

	+ `/etc`:
		+ Configuration files for the system and applications.

	+ `/bin` and `/sbin`:
		+ /bin: Contains essential commands for all users (e.g., ls, cp).
		+ /sbin: Commands for system administrators (e.g., ifconfig).

	+ `/var`:
		+ Stores logs and variable data (e.g., website data or system logs).

	+ `/tmp`:
		+ Temporary files created by programs.

	+ `/usr`:
		+ Contains software and applications.

	+ `/dev`:
		+ Represents hardware devices as files (e.g., hard drives).

	+ `/mnt` or `/media`:
		+ Temporary mount points for storage devices like USBs or CDs.

----------------------------------------------------------------------
**==========================================================================================**

## IV . SUDO

+ 1 . What is SUDO?
	+ sudo (short for "superuser do") is a command in Linux that allows a user to run programs or execute commands with administrator (superuser/root) privileges.
	+ It is a way to temporarily gain more power to perform tasks that require special permissions.	 
	+ Allows specific users to execute specific commands without giving them full administrator access.

	----------------------------------------------------------------------

+ 2 . Installing sudo:
	+ 1 . Login as the Root User
		+ To install sudo, you need root access. Start by logging in as the root user:
		```
		su root
		```
		+ Enter the root password when prompted.
	+ 2 . Update and Upgrade the System
		+ Ensure your package lists and system are up to date:
		```
		apt update
		apt upgrade
		```
	+ 3 . Install the sudo package:
		```
		apt install sudo
		```
	+ 4 . Add Your Regular User to the sudo Group
		+ Grant your regular user the ability to use sudo by adding them to the sudo group:
		```
		sudo usermod -aG sudo <username>
		```
	+ 5 . Verify the User was Added to the sudo Group
		+ Check if the user is now part of the sudo group:
		```
		getent group sudo
		```
	+ 6 . Test sudo Privileges
		+ Exit the root session to return to your regular user:
		```
		exit
		```
		+ Now test if sudo works by running the following command:
		```
		sudo whoami
		```
		+ Enter your password when prompted.
		+ If everything is set up correctly, the output will be:
		```
		root
		```
	----------------------------------------------------------------------
+ 3 . Configuring sudo
	+ To meet the security requirements outlined in the Born2beroot subject, you must configure sudo with the following features:

	+ Security Enhancements to Configure
		+ 1 . **Limit Authentication Attempts**
			+ Restrict sudo to allow only 3 incorrect password attempts before failing.

	  	+ 2 . **Custom Bad Password Message**
			+ Display a custom error message for incorrect password attempts.

		+ 3 . **Log sudo Commands**
			+ Ensure all sudo commands are logged in /var/log/sudo/.

		+ 4 . **Activate TTY Requirement**
			+ Require a TTY (terminal) to prevent malicious software from granting itself root privileges via sudo.

	+ Steps to Configure sudo
		+ 1 . Open the sudoers File Safely
			+ From the root session, use the `visudo` command to edit the sudoers file securely:
			```
			sudo visudo
			```
			+ This ensures any syntax errors in the configuration will not break the system.
		+ 2 . Add the Following Configuration Lines In the sudoers.tmp file opened by `visudo`, append these lines to enable the required settings:

			```
			Defaults     passwd_tries=3
			Defaults     secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
			Defaults     badpass_message="Wrong password. Try again!"
			Defaults     logfile="/var/log/sudo/sudo.log"
			Defaults     log_input
			Defaults     log_output
			Defaults     requiretty
			```
		+ 3 .  Save and Exit
			+ After making the changes, save and close the file.
			+ In visudo, press CTRL + X, then press Y, and hit Enter to confirm.

	+ Explanation of Each Configuration Line
		+  **passwd_tries=3**: Limits users to 3 incorrect password attempts when using sudo.
		+  **secure_path=...**: Sets a secure path for running commands under sudo.
		+  **badpass_message="..."**: Displays the custom message when an incorrect password is entered.
		+  **logfile="/var/log/sudo/sudo.log"**: Logs all sudo commands to a specific file for auditing purposes.
		+ **log_input**: Records input during sudo sessions.
		+  **log_output**: Records output during sudo sessions.
		+  **requiretty**: Ensures a TTY is required to run sudo, blocking non-interactive or malicious scripts from exploiting sudo.

	+ If the `/var/log/sudo` directory doesn’t exist, we might have to mkdir sudo in `/var/log/`.
	+ Now, we can have root privileges in secure way, without having to log into the root session.

----------------------------------------------------------------------
**==========================================================================================**

## VII . Packet Management in Debian APT and Aptitude

- What is **APT**?
	- **APT** stands for **Advanced Package Tool**, and it is a **command-line** tool in Debian-based Linux distributions (like Ubuntu) for managing software packages. With **APT**, you can:

		- **Install** software: apt install <package_name>
		- **Update** the system's package list: apt update
		- **Upgrade** installed software: apt upgrade
		- **Remove** software: apt remove <package_name>
	- **APT** simplifies software installation by resolving **dependencies** automatically.

 	----------------------------------------------------------------------

- What is **Aptitude**?
	- **Aptitude** is a **higher-level package manager** that provides both:
		- A command-line interface similar to APT.
		- A **text-based user interface** (TUI) that allows users to navigate and manage packages interactively.
		- Perform all tasks that APT does (install, update, upgrade, etc.).
		- Use a more user-friendly interface to manage and browse packages.

	----------------------------------------------------------------------

- Differences Between **APT** and **Aptitude**:

	- **Interface**:
		- APT: Command-line only.
		- Aptitude: Offers both a command-line interface and a text-based user interface (TUI).

	- **User Experience**:
		- APT: Requires typing all commands manually, which can be less intuitive.
		- Aptitude: Easier for beginners as it provides an interactive navigation experience.

	- **Dependency Handling**:
		- APT: Resolves package dependencies effectively.
		- Aptitude: Handles dependencies more robustly and provides better suggestions for conflicts.
	- **Which Should You Use**?
		- APT: Best for quick, simple tasks via the command line.
		- Aptitude: Useful for users who want a visual, interactive experience or need better control over resolving dependency conflicts.

----------------------------------------------------------------------
**==========================================================================================**

## VIII . AppArmor

- 1 . What is **AppArmor**?
	**AppArmor** (Application Armor) is a Linux security framework that helps control what applications can do on the system. It works by applying **mandatory access controls (MAC)** to restrict an application's access to files, networks, and system 	resources, even if the application is compromised.

- How It Works:
	- **AppArmor** uses **profiles** that define what an application is allowed or not allowed to do.
	- Profiles can be in **complain mode** (logs violations without enforcing them) or **enforce mode** (actively restricts application behavior).

- Why Use **AppArmor**?
	- **Enhances security:** Limits the damage a compromised application can cause.
	- **Lightweight:** Simple to set up and manage compared to other security tools like **SELinux**.
	- **Granular control:** You can create specific rules for individual applications.

- For example, you can restrict a web browser from accessing sensitive files or prevent a server from modifying certain directories. This makes **AppArmor** a useful tool for securing Linux systems.

**==========================================================================================**

## VIIII . UFW

+ 1. What is **UFW**?
	+ **UFW** (Uncomplicated Firewall) is a simplified tool for managing **firewall** rules in Linux systems. It provides an easy way to configure the firewall to allow or block specific network traffic without requiring advanced knowledge of underlying firewall technologies.

	----------------------------------------------------------------------

+ 2 . What is a **Firewall**?
	+ A firewall is a security system that monitors and controls incoming and outgoing network traffic based on predefined rules. Its purpose is to create a barrier between trusted internal networks and untrusted external networks, like the internet.
	+ Types of Firewalls:
		+ **Network Firewalls:** Protect entire networks.
		+ **Host-based Firewalls:** Protect individual devices.

	----------------------------------------------------------------------

+ 3 . Relationship Between **UFW**and **Firewalls**
	+ **UFW** is a tool that manages the **iptables** (the actual **firewall** technology in Linux).
	+ It simplifies complex **firewall** rule setups, making it easier to block/allow specific traffic without needing to manually edit **iptables** rules.
	+ **UFW** makes managing **firewall** rules beginner-friendly.

	----------------------------------------------------------------------

+ 4 . What are IP Addresses?
	+ An IP address is a unique identifier for a device on a network. It's like a home address but for computers, allowing them to send and receive data.

+ 5 . What are Ports?
	+ A port is a virtual endpoint used to handle specific types of network communication. It’s like a "door" that applications use to send and receive data.

+ 6 . How They Work Together:
	+ IP addresses identify devices on a network.
	+ Ports define which application/service the traffic is intended for.
	+ Firewalls (like UFW) manage which IP addresses and ports can communicate.
	+ UFW simplifies managing firewall rules, ensuring that only safe traffic is allowed.

	----------------------------------------------------------------------

+ 7 . Installing & Configuring UFW:
	+ As the subject suggests the firewall must be active when you launch your virtual machine.
		$ sudo apt update
		$ sudo apt upgrade
		$ sudo apt install ufw
		$ sudo ufw enable
	+ To check if UFW up and running we can use the command line:
		$ sudo systemctl status ufw
		+ We should see “active” in green.
	+ Also we have to leave only port 4242 open.
		$ sudo ufw allow 4242

----------------------------------------------------------------------
**==========================================================================================**

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
**==========================================================================================**
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
**==========================================================================================**

## III - Sources
+ (https://github.com/42-adbouras/Born2beroot-1337MED/tree/master)
+ (https://github.com/RIDWANE-EL-FILALI/Born2beroot/blob/master/Configuration.md)
+ (https://42-cursus.gitbook.io/guide/rank-01/born2beroot/whats-a-virtual-machine)
+ ChatGPT, Youtube, Google, trust me broo.
