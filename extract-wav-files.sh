#!/bin/sh

#
# Extracts recording file names from selected programs in the 
# schedule. Currently focuses on programs B, C, G, H, I, J, and K.
#

date=`sed -nE 's/.*([0-9]{4}-[0-9]{2}-[0-9]{2}).*/\1/p' $1 | head -1`

output="$date.csv"
touch $output

for program in B C G H I J; do
  sed -n "/CATEGORY\: $program/,/CATEGORY\:/p" $1 | sed -nE '/ {4}C[0-9]{4,5}-/p' >> $output
done

sed -n "/CATEGORY\: K/,/\/html>/p" $1 | sed -nE '/ {4}C[0-9]{4,5}-/p' >> $output

