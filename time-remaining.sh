#!/bin/zsh

# Adapted from sox.c
str_time()
{
  seconds=$1
  minutes=`echo "$1 / 60" |bc`
  sval=`echo "$seconds - ($minutes * 60)" |bc`
  seconds=`echo $sval |sed -n 's/\([0-9]*\)[.][0-9]*/\1/p'`
  if [[ $seconds -eq "" ]]
  then
    seconds="0"
  fi
  decimal=`echo $sval |sed -n 's/[0-9]*[.]\([0-9]*\)/\1/p'`
  printf "%02d:%02d.%s\n" $minutes $seconds $decimal
};

SOX=~/sox-14.4.2/sox
# Maximum time in an hour is 56 minutes
MAX_DURATION=`echo "60 * 56" |bc`

filled=`$SOX $1*.wav -n stat 2>&1 | sed -n 's#^Length (seconds):[^0-9]*\([0-9.]*\)$#\1#p'`

unfilled=`echo "$MAX_DURATION - ($2 + $filled)" |bc`
str_time $unfilled
