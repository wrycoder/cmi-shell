#!/bin/zsh

# Adapted from sox.c
str_time()
{
  seconds=$1
  minutes=`echo "$1 / 60" |bc`
  seconds=`echo "$seconds - ($minutes * 60)" |bc`
  printf "%s:%s\n" $minutes $seconds
};

SOX=~/sox-14.4.2/sox

input=`$SOX ~/radio/voicetracks-2/$1*.wav -n stat 2>&1 | sed -n 's#^Length (seconds):[^0-9]*\([0-9.]*\)$#\1#p'`
str_time $input
