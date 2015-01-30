#!/bin/bash

NEXTTOLAST=`expr $1 - 1`

#Build the main loop for iterating through task ids
for i in `seq 1 $NEXTTOLAST`
do
  echo "$i" | nc -l localhost $2
done

#Send the last task id and then sit around forever closing connection requests
echo "$1" | nc -l -k localhost $2
