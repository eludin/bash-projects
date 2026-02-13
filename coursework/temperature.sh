#!/bin/bash
temp=$1
if [[ $temp -ge 31 ]]; then
	echo "Wear light clothing"
elif [[ $temp -ge 20 ]]; then
	echo "Wear moderate clothing"
else
	echo "Wear heavy clothing"
fi
