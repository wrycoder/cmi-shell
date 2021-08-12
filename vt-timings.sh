#!/bin/zsh
# the function "round()" was taken from
# http://stempell.com/2009/08/rechnen-in-bash/

# the round function:
round()
{
echo $(printf %.$2f $(echo "scale=$2;(((10^$2)*$1)+0.$3)/(10^$2)" | bc))
};

pad()
{
if [ "$1" -lt "10" ]; then
  printf 0%s "$1"
else
  if [ "$1" -eq "60" ]; then
    printf %s "00"
  else
    printf %s "$1"
  fi
fi
};

SOXI=~/sox-14.4.2/soxi

#$SOXI -D ~/radio/voicetracks-2/$1*.wav |awk 'BEGIN { s = 0 }; { s = s + $1 }; END { print s / 60 " minutes and " s % 60 " seconds" }'
minutes=$($SOXI -D ~/radio/voicetracks-2/$1*.wav |awk 'BEGIN { s = 0 }; { s = s + $1 }; END { print s / 60 }')
seconds=$($SOXI -D ~/radio/voicetracks-2/$1*.wav |awk 'BEGIN { s = 0 }; { s = s + $1 }; END { print s % 60 }')

echo "$(round $minutes 0 0):$(pad $(round $seconds 0 5))"
