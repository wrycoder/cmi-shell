#!/bin/bash


SOX=~/sox-14.4.2/sox
# Maximum time in an hour is 56 minutes
MAX_DURATION=`echo "60 * 56" |bc`

`/bin/ls $1*$2*.wav >/dev/null 2>&1`
if [ $? -eq 0 ]; then
  filled=`$SOX $1*$2-S*.wav -n stat 2>&1 | sed -n 's#^Length (seconds):[^0-9]*\([0-9.]*\)$#\1#p'`
else
  filled=0
fi

unfilled=`echo "$MAX_DURATION - ($3 + $filled)" |bc`
echo $unfilled
