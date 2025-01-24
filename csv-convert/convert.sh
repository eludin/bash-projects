#!/bin/bash
# Created by Antonio Giacchetti (000928446)
# Last Update: Sept 26 2024
# Attempting to pull data from a csv and output its contents to .md files


# Check if the CSV file is provided
if [[ -z "$1" ]]; then
  echo "Usage: $0 <input.csv>"
  exit 1
fi

# Read the CSV file line by line
while IFS=',' read -r filename first_line second_line; do
  # Remove leading/trailing spaces from filename
  filename=$(echo "$filename" | xargs)

  # Check if the second_line contains more than one space
  if [[ "$second_line" =~ [[:space:]]{2,} ]]; then
    # Replace multiple spaces with newline characters
    second_line=$(echo "$second_line" | sed -E 's/[[:space:]]{2,}/\n/g')
  fi

  # Create the .md file with the provided filename
  echo "$first_line" > "${filename}.md"
  echo -e "$second_line" >> "${filename}.md"

  echo "Created ${filename}.md"
done < "$1"

