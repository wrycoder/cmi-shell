#!/bin/sh
export NEWFILE="$1-web.csv"
touch $NEWFILE
cat > $NEWFILE <<END
`awk -F '\t' -f c2-to-cmi.awk $1.csv`
END
echo 'done'