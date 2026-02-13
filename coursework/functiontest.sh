#!/bin/bash
# Created by Antonio Giacchetti (000928446)
# Last Update August 7 2024
# Scripting Assignment 2 (Bonus Script 2): Notekeeper ++

function errormessage() {
	local default="0" # set default value to 0 for comparison
	local arg="${1:-$default}" #stores any arg or default value into '$arg'
	if [ $arg -eq 1 ]; then
		echo "No notes to display.
Provide an argument to create a note."
	elif [ $arg -eq 2 ]; then
		echo "That line does not exist."
	else
		echo "try '-h' for more information."
	fi
}
errormessage 1 # will output from first if
errormessage 2 # will output from first elif
errormessage 3 # will output from else
errormessage   # will output from else

# scope test
echo "$arg"
echo "$default"
