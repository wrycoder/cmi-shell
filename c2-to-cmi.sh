#!/bin/sh

export AWKFILE="$HOME/radio/bin/c2-to-cmi.awk"
export TARGETDIR="$HOME/radio/website"

if [ "$#" != "1" ]; then
cat <<EndOfHelp
  ERROR: Filename is missing.

  To use this command, you must specify the full
  path of the input file, including the '.csv' extension.

  This process will create a file in $TARGETDIR,
  with the same basename as the input file, plus
  "-web.csv".
EndOfHelp
  exit
else
  if [[ ! -f "$1" ]]; then
    echo "ERROR: input file not found" >&2
    exit 1
  fi
  export SOURCEFILE=`basename $1`
  export NEWFILE=`printf $SOURCEFILE |sed 's/\(\.csv\)$/-web\1/'`
  touch "${TARGETDIR}/${NEWFILE}"
  cat > "${TARGETDIR}/${NEWFILE}" <<END
  `awk -F '\t' -f $AWKFILE $1`
END
  echo 'done'
fi