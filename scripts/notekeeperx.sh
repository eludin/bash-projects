#!/bin/bash
# Created by Antonio Giacchetti (000928446)
# Last Update August 7 2024
# Scripting Assignment 2 (Bonus Script 2): Notekeeper ++
# NOTES: This script will append any given arguments to a file called "notes.txt" in the home directory of the user. If no arguments are given, the "notes.txt" file will be displayed in the terminal using the cat command.

# Set default note path to home directory
FILE=/home/$USER/notes.txt

# If num of arguments is greater than 1
if [ $# -ge 1 ]; then

    # If a single argument "-h" is given
    if [ $# -eq 1 ] && [ "$1" = "-h" ]; then
        # Display help message
        echo "This script is designed to save and read notes to and from a .txt file. If no arguments are provided, the .txt file will output to the terminal. Additional functionality is available through the following option flags." 
        echo "Syntax: [ -h | -d | -d linenumber ]"
        echo "options:"
        echo "-h              display this help message"
        echo "-d              display note file with line numbers and prompts user"
        echo "-d linenumber   delete specified line number from the file"
        exit 0

    # If a single argument '-d' is given
    elif [ $# -eq 1 ] && [ "$1" = "-d" ]; then
        # Display note file with line numbers
        cat -n "$FILE"
        # Prompt user
        read -p "Which line would you like to delete? (Enter any letter to cancel): " choice
		
		# If '$choice' is numeric
		if [[ "$choice" =~ ^[0-9]+$ ]]; then
			# Remove chosen line number
			sed -i "${choice}d" "$FILE"
			echo "Line $choice was deleted."
			exit 0

		# If '$choice' is not a number, exit
		else
			exit 1
		fi

	# If exactly 2 arguments '-d', and a numeric line number are given
	elif [ $# -eq 2 ] && [ "$1" = "-d" ] && [[ "$2" =~ ^[0-9]+$ ]]; then
		echo "Removing line $2..."
		# Remove the chosen line from '$FILE'
		sed -i "${2}d" "$FILE"
		echo "Line $2 was deleted."
		exit 0

    else
        # Append all arguments to the file
        echo $* >> $FILE
        exit 0
    fi

# If no arguments are given
else
    # Display the file in the terminal
    cat $FILE
    exit 0
fi

# Usage/Testing Notes
	# All 5 primary functions work as expected

# Read Notes - working as expected
	# ./notekeeper2.sh
	# If file exists, notes are read to the terminal.
	# If file does not exist, user is reminded to provide argument (exit code 1)

# Append Notes - working as expected
	# ./notekeeper.sh notes go here
	# Notes are appropriately appended to the '$FILE'.
	# If note file does not exist, it is created.


# NEED TO ADD
#	error handling if -d is provided before file exists
#	error handling if a line argument is provided for a line that doesnt exist
	#  && [ $choice -le $]
	# wc -l "$FILE" | grep ^.
