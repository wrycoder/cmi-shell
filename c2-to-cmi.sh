#!/bin/sh

if [ "$#" != "1" ]; then
cat <<EndOfHelp
  ERROR: incorrect number of arguments

  To use this command, you must specify the name
  of the input file without the extension.

  If that file is found, this process will create
  a file whose name begins with the name you supplied,
  and ends in "-web.csv" (including the extension).
EndOfHelp
  exit
else
  export NEWFILE="$1-web.csv"
  touch $NEWFILE
  cat > $NEWFILE <<END
  `awk -F '\t' -f c2-to-cmi.awk $1.csv`
END
  echo 'done'
fi