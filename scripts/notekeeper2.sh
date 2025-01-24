#!/bin/bash
# Created by Antonio Giacchetti (000928446)
# Last Update August 7 2024
# Scripting Assignment 2 (Bonus Script 2): Notekeeper ++
# NOTES: This script will append any given arguments to a file called "notes.txt" in the home directory of the user. If no arguments are given, the "notes.txt" file will be displayed in the terminal using the cat command. Additional option flags have been defined and implemented to increase functionality.
# Thorough usage/testing notes have been provided below for clarification.

# Function for "man styled" 'help' output
function help() {
	echo "DESCRIPTION:
	This script is designed to write any given arguments to a '.txt' file.
	When called without arguments, this script will output the '.txt' file in the terminal.
	Additional functionality is available through the following option flags.
SYNTAX:
	[ -h | -d | -d linenumber ]
OPTIONS:
	-h
		display this help message
	-d
		display note file with line numbers and prompts user
	-d linenumber
		delete specified line number from the file
	"
}

# Function for error handling
function errormessage() {
	# Define a default error code of '0'
	local default="0"
	# Assign function argument 1 to 'arg', or '0' if none are given
	local arg="${1:-$default}"
	# First error code - file does not exist
	if [ $arg -eq 1 ]; then
		echo "No notes to display or manage.
Try '-h' for more information."
	# Second error code - line num logic error
	elif [ $arg -eq 2 ]; then
		echo "That line does not exist.
Try '-h' for more information."
	# Any other errors
	else
		echo "Try '-h' for more information."
	fi
}

# Set default note path to home directory
FILE=/home/$USER/notes.txt

# Check if '$FILE' exists and set state as 'file_exist'
if test -f "$FILE"; then
	file_exist=true
	# Get line count of '$FILE' set as count
	count=$(wc -l < "$FILE")
else
	file_exist=false
fi

# If num of arguments is greater than 1
if [ $# -ge 1 ]; then

	# If a single argument '-h' is given
    if [ $# -eq 1 ] && [ "$1" = "-h" ]; then
        # Display help message
        help
		exit 0

	# If a single argument '-d' is given
    elif [ $# -eq 1 ] && [ "$1" = "-d" ]; then
		
		# If file exists
		if $file_exist; then
        	# Display note file with line numbers
        	cat -n "$FILE"
        	# Prompt user
        	read -p "Which line would you like to delete? (Enter any letter to cancel): " choice

			# If '$choice' is numeric
			if [[ "$choice" =~ ^[0-9]+$ ]]; then

				# If num of lines is less than user choice
				if [ $count -lt $choice ]; then
					# Handle error
					errormessage 2
				else
					# Remove chosen line number
					sed -i "${choice}d" "$FILE"
					echo "Line $choice was deleted."
					exit 0
				fi

			# If '$choice' is not a number, exit
			else
				exit 0
			fi

		# If file does NOT exist
		else
			errormessage 1
			exit 1
		fi

	# If exactly 2 arguments '-d', and a numeric line number are given
	elif [ $# -eq 2 ] && [ "$1" = "-d" ] && [[ "$2" =~ ^[0-9]+$ ]]; then
		
		# If file exists
		if $file_exist; then
			
			# If num of lines is less than '$2'
			if [ $count -lt $2 ]; then
				# Handle error
				errormessage 2
				exit 1
			else
				# Remove the chosen line from '$FILE'
				echo "Removing line $2..."
				sed -i "${2}d" "$FILE"
				echo "Line $2 was deleted."
				exit 0
			fi

		else
			errormessage 1
			exit 1
		fi

    else
        # Append all arguments to the file
        echo $* >> $FILE
        exit 0
    fi
		
# If no arguments are given
else

	# If file exists
	if $file_exist; then
		# Display the file in the terminal
		cat $FILE
		exit 0
	# Error Handling
	else
		errormessage 1
		exit 1
	fi
fi

#* Usage/Testing Notes
	#? All 5 primary functions work as intended

#* Read Notes - working as intended
	#? './notekeeper.sh'
	# If file exists, notes are read to the terminal.
	# If file does not exist, 'errormessage' function is called
		# User is informed no notes are available, and encouraged to try '-h'.

#* Append Notes - working as intended
	#? './notekeeper.sh notes go here'
	# Any arguments besides option flags are appended to the '$FILE'.
	# If note file does not exist, it is created.

#* Help Message - working as intended
	#? './notekeeper.sh -h'
	# Calls a function that outputs a description and help message to the terminal if '-h' is given as the first and ONLY argument
	# note: '-h' will NOT be appended to '$FILE' unless other arguments are given
	# ie. './notekeeper.sh -h will display a helpful message'
		# will append '-h will display a helpful message' to '$FILE'

#* Delete a specific line with prompt - working as intended
	#? './notekeeper2.sh -d'
	# If file exists, notes are read to the terminal with line numbers
		# user is prompted to delete a line or cancel
		# Invalid inputs are handled by the 'errormessage' function
	# If file does not exist, 'errormessage' function is called
		# User is informed no notes are available, and encouraged to try '-h'.
	# note: '-d' will NOT be appended to '$FILE' unless other arguments are given
	# ie. './notekeeper.sh -d displays notes with line nums'
		# will append '-d displays notes with line nums' to '$FILE'

#* Delete a specific line directly - working as intended
	#? './notekeeper2.sh -d 3'
	# If file exists, specified line number is removed from '$FILE'
		# If line number is valid, it is removed from '$FILE'
		# If line number is invalid, error is handled by 'errormessage' function
	# If file does not exist, error is handled by 'errormessage' function
	# note: If more than 1 argument follows '-d' or any non-integer is given as argument 2, all arguments are appended to '$FILE'