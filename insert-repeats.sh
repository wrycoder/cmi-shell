#!/bin/sh

if [ "$#" != "1" ]; then
cat <<EndOfHelp
  ERROR: incorrect number of arguments

  To use this command, you must specify the name
  of the input file without the extension.

  If that file is found, this process will create
  a file whose name begins with the name you supplied,
  and ends in "-with-repeats.csv". 
EndOfHelp
  exit
else
  if [[ ! -f "$1.csv" ]]; then
    echo "ERROR: input file not found" >&2
    exit 1
  fi
  export NEWFILE="$1-with-repeats.csv"
  touch $NEWFILE
  cat > $NEWFILE <<END
`sed -n -e '1 p' $1.csv`
`sed -n -e '2,59 p' $1.csv`
`sed -n -e '2,7 p' $1.csv |sed 's/\"00:/\"11:/'`
`sed -n -e '8,13 p' $1.csv |sed 's/\"01:/\"12:/'`
`sed -n -e '60,65 p' $1.csv`
`sed -n -e '18,23 p' $1.csv |sed 's/\"03:/\"14:/'`
`sed -n -e '24,29 p' $1.csv |sed 's/\"04:/\"15:/'`
`sed -n -e '66,71 p' $1.csv`
`sed -n -e '72,77 p' $1.csv`
`sed -n -e '60,65 p' $1.csv |sed 's/\"13:/\"18:/'`
`sed -n -e '30,33 p' $1.csv |sed 's/\"05:/\"19:/'`
`sed -n -e '40,45 p' $1.csv |sed 's/\"07:/\"20:/'`
`sed -n -e '14,17 p' $1.csv |sed 's/\"02:/\"21:/'`
`sed -n -e '46,51 p' $1.csv |sed 's/\"08:/\"22:/'`
`sed -n -e '66,71 p' $1.csv |sed 's/\"16:/\"23:/'`
END
fi
