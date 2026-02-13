#!/bin/bash
# Created by Antonio Giacchetti (000928446)
# Last Update August 7 2024
# Scripting Assignment 2 C: Notekeeper
# Description: This script will append any given arguments to a file called 'notes.txt' in the home directory of the user. If no arguments are given, the "notes.txt" file will be displayed in the terminal using the cat command.
# Thorough usage/testing notes have been provided below for clarification.

# Set default note path to home directory
FILE=/home/$USER/notes.txt
# If num of arguments is greater than 1
if [ $# -ge 1 ]; then
	# Append all arguments to the file
	echo $* >> $FILE
	exit 0
# If no arguments are given
else
	# If file exists
	if test -f "$FILE"; then
		# Display the file in the terminal
		cat $FILE
		exit 0
	# Error Handling
	else
		echo "No notes to display."
		echo "Provide an argument to create a note."
		exit 1
	fi
fi

#* Usage/Testing Notes
	#? All primary functions work as intended

#* Read Notes - working as intended
	#? './notekeeper.sh'
	# If file exists, notes are read to the terminal.
	# If file does not exist, user is reminded to provide argument (exit code 1)

#* Append Notes - working as intended
	#? './notekeeper.sh notes go here'
	# Notes are appropriately appended to the '$FILE'.
	# If note file does not exist, it is created.