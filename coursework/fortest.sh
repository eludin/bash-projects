#!/bin/bash

# Run pi.sh the specified number of times
for (( i=1; i<=$1; i++ ))
do
	echo "hi $i"
    /opt/Mohawk/bin/pi.sh 5 2>/dev/null
done

