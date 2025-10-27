#!/bin/sh

#
# Extracts recording file names from selected programs in the 
# schedule. Currently focuses on programs B, C, G, H, I, J, and K.
#

if [ "$#" -ne 1 ]; then
  printf "Error: you must specify a filename for input\n"
  exit 1
fi

date=`sed -nE 's/.*([0-9]{4}-[0-9]{2}-[0-9]{2}).*/\1/p' $1 | head -1`

output="$date.csv"
touch $output

for program in B C G H I J K; do
  sed -n "/CATEGORY\: $program/,/CATEGORY\:/p" $1 | sed -nE '/ {4}C[0-9]{4,5}-/p' >> $output
done

# Use this one to scoop up the last show of the day...
# sed -n "/CATEGORY\: K/,/\/html>/p" $1 | sed -nE '/ {4}C[0-9]{4,5}-/p' >> $output

