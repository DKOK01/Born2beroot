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
