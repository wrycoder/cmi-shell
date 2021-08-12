#!/bin/zsh

export SOXI=~/sox-14.4.2/soxi

$SOXI -D ~/radio/voicetracks-2/$1*.wav |awk 'BEGIN { s = 0 }; { s = s + $1 }; END { print s / 60 " minutes and " s % 60 " seconds" }'