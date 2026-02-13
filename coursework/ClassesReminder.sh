#!/bin/bash
# Created by Antonio Giacchetti (000928446)
# Last Update: July 4 2024
# Bonus Script: Automating a routine task: Class Reminder (ALL Classes)
# NOTES: Variables are initialized within related if statements to improve efficiency and readability.
#        Thoroughly tested each if statement by manually altering $numday and $ctime.
#        Documented script behaviour at various real-times on various days.
#        All logic works as expected.

# Day of the Week
numday=$(date +%u) # numerical day of the week (1..7)
day=$(date +%A) # written day of the week (ie. Monday)
# Time of Day
ctime=$(date +%H%M) # current time for comparison
htime=$(date +%-I:%M%p) # current time (human friendly)

# Greeting
name="Antonio" # Assign Name
echo "Hello $name. It is currently $htime on $day."

# TESTING (see notes)
# numday=5
# ctime=1400

# Monday
if [ $numday -eq 1 ]; then
        server1s="1000" # starttime
        server1e="1200" # endtime
        if [ $ctime -lt $server1s ]; then
                echo "You have MS Server Administration today from 10:00AM to 12:00PM."
        elif [ $ctime -ge $server1s ] && [ $ctime -lt $server1e ]; then
                echo "You should be in MS Server Administration right now."
        else
                echo "You had MS Server Administration today from 10:00AM to 12:00PM. The class has ended."
        fi
        math1s="1230" # starttime
        math1e="1400" # endtime
        if [ $ctime -lt $math1s ]; then
                echo "You have Discreet Mathematics today from 12:30PM to 2:00PM."
        elif [ $ctime -ge $math1s ] && [ $ctime -lt $math1e ]; then
                echo "You should be in Discreet Mathematics right now."
        else
                echo "You had Discreet Mathematics today from 12:30PM to 2:00PM. The class has ended."
        fi

# Tuesday
elif [ $numday -eq 2 ]; then
        unixs="0800" # starttime
        unixe="1100" # endtime
        if [ $ctime -lt $unixs ]; then
                echo "You have Fundamentals of UNIX today from 8:00AM to 11:00AM."
        elif [ $ctime -ge $unixs ] && [ $ctime -lt $unixe ]; then
                echo "You should be in Fundamentals of UNIX right now."
        else
                echo "You had Fundamentals of UNIX today from 8:00AM to 11:00AM. The class has ended."
        fi
        tcpips="1200" # starttime
        tcpipe="1400" # endtime
        if [ $ctime -lt $tcpips ]; then
                echo "You have TCP/IP today from 12:00PM to 2:00PM."
        elif [ $ctime -ge $tcpips ] && [ $ctime -lt $tcpipe ]; then
                echo "You should be in TCP/IP right now."
        else
                echo "You had TCP/IP today from 12:00PM to 2:00PM. The class has ended."
        fi

# Thursday
elif [ $numday -eq 4 ]; then
        server2s="0900" # starttime
        server2e="1100" # endtime
        if [ $ctime -lt $server2s ]; then
                echo "You have MS Server Administration today from 9:00AM to 11:00AM."
        elif [ $ctime -ge $server2s ] && [ $ctime -lt $server2e ]; then
                echo "You should be in MS Server Administration right now."
        else
                echo "You had MS Server Administration today from 9:00AM to 11:00AM. The class has ended."
        fi
        math2s="1100" # starttime
        math2e="1230" # endtime
        if [ $ctime -lt $math2s ]; then
                echo "You have Discreet Mathematics today from 11:00AM to 12:30PM."
        elif [ $ctime -ge $math2s ] && [ $ctime -lt $math2e ]; then
                echo "You should be in Discreet Mathematics right now."
        else
                echo "You had Discreet Mathematics today from 11:00AM to 12:30PM. The class has ended."
        fi

# Friday
elif [ $numday -eq 5 ]; then
        vms="1000" # starttime
        vme="1200" # endtime
        if [ $ctime -lt $vms ]; then
                echo "You have Virtualization today from 10:00AM to 12:00PM."
        elif [ $ctime -ge $vms ] && [ $ctime -lt $vme ]; then
                echo "You should be in Virtualization right now."
        else
                echo "You had Virtualization today from 10:00AM to 12:00PM. The class has ended."
        fi
        tcpips="1200" # starttime
        tcpipe="1400" # endtime
        if [ $ctime -lt $tcpips ]; then
                echo "You have TCP/IP today from 12:00PM to 2:00PM."
        elif [ $ctime -ge $tcpips ] && [ $ctime -lt $tcpipe ]; then
                echo "You should be in TCP/IP right now."
        else
                echo "You had TCP/IP today from 12:00PM to 2:00PM. The class has ended."
        fi

# Wednesday, Saturday, Sunday
else
        echo "You don't have class today."
fi
