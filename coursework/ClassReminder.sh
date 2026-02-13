#!/bin/bash
# Created by Antonio Giacchetti (000928446)
# Last Update: July 4 2024
# Script 1B: Automating a routine task: Class Reminder (UNIX)
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
# numday=2
# ctime=1100

# Class today?
if [ $numday -ne 2 ]; then
        echo "You don't have Fundamentals of UNIX today."
else # tuesday
        unixs="0800" # starttime
        unixe="1100" # endtime
        if [ $ctime -lt $unixs ]; then
                echo "You have Fundamentals of UNIX today from 8:00AM to 11:00AM."
        elif [ $ctime -ge $unixs ] && [ $ctime -lt $unixe ]; then
                echo "You should be in Fundamentals of UNIX right now."
        else
                echo "You had Fundamentals of UNIX today from 8:00AM to 11:00AM. The class has ended."
        fi
fi
