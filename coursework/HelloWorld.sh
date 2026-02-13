#!/bin/bash
# Created by Antonio Giacchetti (000928446)
# Last Update: July 4 2024
# Script 1A: Personalized "Hello World!"
echo "       ______               _____        "
echo "____  ____  /_____  __________  /____  __"
echo "_  / / /_  __ \  / / /_  __ \  __/  / / /"
echo "/ /_/ /_  /_/ / /_/ /_  / / / /_ / /_/ / "
echo "\__,_/ /_.___/\__,_/ /_/ /_/\__/ \__,_/  "
day=$(date +%A) # written day of the week (ie. Monday)
htime=$(date +%-I:%M%p) # current time (human friendly)
name="Antonio" # Assign Name
echo "Hello $name! It is currently $htime on $day."
