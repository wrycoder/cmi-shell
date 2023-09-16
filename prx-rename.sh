#!/bin/sh

# A ... 12AM or 11AM ... N1
# B ... 1AM or 12PM ... N2
# C ... 2AM or 9PM ... L1
# D ... 3AM or 2PM ... N3
# E ... 4AM or 3PM ... N4
# F ... 5AM or 7PM ... L2
# G ... 6AM        ... A1
# H ... 7AM or 8PM ... A2
# I ... 8AM or 10PM ... A3
# J ... 9AM        ... L3
# K ... 10AM       ... L4
# L ... 12AM or 11AM ... N1
# M ... 1AM or 12PM ... N2
# N ... 1PM or 6PM ... P3
# O ... 3AM or 2PM ... N3
# P ... 4AM or 3PM ... N4
# Q ... 4PM or 11PM ... P1
# R ... 5PM         ... P2
# S ... 1PM or 6PM ... P3
# T ... 5AM or 7PM ... L2
# U ... 7AM or 8PM ... A2
# V ... 2AM or 9PM ... L1
# W ... 8AM or 10PM ... A3
# X ... 4PM or 11PM ... P1

# 1 ... BILLBOARD
# 2 ... NEWS HOLE
# 3-7 ... SEG [3-7]

letters=(   "A"             "B"           "C"           "D"           "E"           "F"
            "G"             "H"           "I"           "J"           "K"           "L"
            "M"             "N"           "O"           "P"           "Q"           "R"
            "S"             "T"           "U"           "V"           "W"           "X" )

hours=(     "N1"            "N2"          "L1"          "N3"          "N4"          "L2"
            "A1"            "A2"          "A3"          "L3"          "L4"          "N1"
            "N2"            "P3"          "N3"          "N4"          "P1"          "P2"
            "P3"            "L2"          "A2"          "L1"          "A3"          "P1" )

airtimes=(  "12AM\ or\ 11AM"  "1AM\ or\ 12PM" "2AM\ or\ 9PM"  "3AM\ or\ 2PM"  "4AM\ or\ 3PM"  "5AM\ or\ 7PM"
            "6AM"           "7AM\ or\ 8PM"  "8AM\ or\ 10PM" "9AM"         "10AM"        "12AM\ or\ 11AM"
            "1AM\ or\ 12PM"   "1PM\ or\ 6PM"  "3AM\ or\ 2PM"  "4AM\ or\ 3PM"  "4PM\ or\ 11PM" "5PM"
            "1PM\ or\ 6PM"    "5AM\ or\ 7PM"  "7AM\ or\ 8PM"  "2AM\ or\ 9PM"  "8AM\ or\ 10PM" "4PM\ or\ 11PM" )

segments=(  "SEG\ 3" "SEG\ 4" "SEG\ 5" "SEG\ 6" "SEG\ 7" )

if [ "$#" != "2" ]; then
cat <<EndOfHelp

  USAGE:  $0 [digit] [day] 

  * [digit] is the episode number for the day you want to publish
  * [day] is a three-letter abbreviation for the day of the week

EndOfHelp
  exit
else
  for i in ${!letters[@]}; do
    cmd="cp CMI-${hours[i]}$2-1.mp2 Ep.\ $1.${letters[i]}\ ${airtimes[i]}\ BILLBOARD.mp2"
    eval $cmd 2>/dev/null
    cmd="cp CMI-${hours[i]}$2-2.mp2 Ep.\ $1.${letters[i]}\ ${airtimes[i]}\ NEWS\ HOLE.mp2"
    eval $cmd 2>/dev/null
    for x in ${!segments[@]}; do
      let "filenumber = $x + 3"
      cmd="cp CMI-${hours[i]}$2-$filenumber.mp2 Ep.\ $1.${letters[i]}\ ${airtimes[i]}\ ${segments[x]}.mp2"
      eval $cmd 2>/dev/null
    done
  done
  echo "Done"
fi
