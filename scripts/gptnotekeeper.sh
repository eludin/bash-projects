#!/bin/bash
# Created by Antonio Giacchetti (000928446)
# Last Update August 7 2024
# Scripting Assignment 2 (Bonus Script 2): Notekeeper ++
# NOTES: This script will append any given arguments to a file called "notes.txt" in the home directory of the user. If no arguments are given, the "notes.txt" file will be displayed in the terminal using the cat command.

# Set default note path to home directory
FILE=/home/$USER/notes.txt

# If number of arguments is greater than 0
if [ $# -ge 1 ]; then

    # If a single argument "-h" is given
    if [ $# -eq 1 ] && [ "$1" = "-h" ]; then
        # Display help message
        echo "This script is designed to save and read notes to and from a .txt file. If no arguments are provided, the .txt file will output to the terminal. Additional functionality is available through the following option flags." 
        echo "Syntax: [ -h | -d | -d linenumber ]"
        echo "options:"
        echo "-h              display this help message"
        echo "-d              display note file with line numbers and prompt user"
        echo "-d linenumber   delete specified line number from the file"
        exit 0

    # If the first and only argument is '-d'
    elif [ $# -eq 1 ] && [ "$1" = "-d" ]; then
        # Check if the file exists and is not empty
        if [ -f "$FILE" ] && [ -s "$FILE" ]; then
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
                echo "Invalid choice. No line was deleted."
                exit 1
            fi
        else
            echo "File not found or is empty. No lines to display or delete."
            exit 1
        fi

    # If exactly 2 arguments '-d', and a numeric line number are given
    elif [ $# -eq 2 ] && [ "$1" = "-d" ] && [[ "$2" =~ ^[0-9]+$ ]]; then
        # Check if the file exists and is not empty
        if [ -f "$FILE" ] && [ -s "$FILE" ]; then
            echo "Removing line $2..."
            # Remove the chosen line from '$FILE'
            sed -i "${2}d" "$FILE"
            echo "Line $2 was deleted."
            exit 0
        else
            echo "File not found or is empty. No lines to delete."
            exit 1
        fi

    else
        # Append all arguments to the file
        echo "$*" >> "$FILE"
        exit 0
    fi

# If no arguments are given
else
    # Check if the file exists
    if [ -f "$FILE" ]; then
        # Display the file in the terminal
        cat "$FILE"
    else
        echo "File not found. No notes to display."
    fi
    exit 0
fi

