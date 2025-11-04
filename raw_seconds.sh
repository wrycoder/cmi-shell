#!/bin/sh
sed -n 's/.Pre-recorded content\: 00\:\(.....\)./\1/p' "$1" |awk -F ':' -v ORS=',' '{ print ($1 * 60) + $2}'
printf '\n'
