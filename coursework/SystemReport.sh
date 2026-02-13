#!/bin/bash
# Created by Antonio Giacchetti (000928446)
# Last Update August 7 2024
# Scripting Assignment D: System Report
# Description: This script will run a series of commands in order to create a "System Report" output in the terminal.
# Thorough usage/testing notes have been provided below for clarification.

echo "#############################"
echo "#####   SYSTEM REPORT   #####"

# System Information: Current Time, Uptime, Users logged in, Load Average
echo "#############################"
echo "System Information: "
uptime

# Disk Utilization: 
echo "#############################"
echo "Disk Utilization:"
df -h

# Count Installed System Packages:
# Note: Course VM uses rpm to manage packages
echo "#############################"
echo "Number of installed packages:"
rpm -qa | wc -l

# Host name of system:
echo "#############################"
echo "Host Name:"
hostname

# Additional System Info (Amount of system memory):
echo "#############################"
echo "Amount of System Memory:"
lshw -short 2>/dev/null | grep "System memory" | awk '{print $3}'
echo "#############################"

#* Usage/Testing Notes
	#? All 5 primary functions work as intended

#* 'uptime' - working as intended
    # displays current time, uptime, num of users logged in, and load average

#* 'df -h' - working as intended
    # reports on utilization level of disks in the system

#* 'rpm -qa | wc -l' - working as intended
    # rpm query piped to line count to accurately display num of packages installed
    # note: home system (WSL Ubuntu) uses APT to manage packages
    # rpm manages packages on course vm, different systems may require different commands

#* 'hostname' - working as intended
    # displays the system host name

#* 'lshw -short' - working as intended
    # chose to display amount of system memory
    # using 'grep' and 'awk' to find/strip this value from 'lshw'
    # note: 'lshw' normally recommends super user authentication.
    # I could have simply placed 'sudo' infront of the command to prompt authetication and bypass the warnings but decided it was cleaner to handle the error by redirecting the warning to '/dev/null'