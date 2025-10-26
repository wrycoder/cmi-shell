#!/bin/zsh

# Sorts a list of filenames with the
# pattern 'C[0-9]{4,5}-.+' by the
# numerical values of the digits,
# and groups them into subsections:
#
# 0001-1999
# 2000-3999
# 4000-5999
# 6000-7999
# 8000-9999
# 10000-11999

# To CREATE the list of filenames from a download of a
# complete Blurve preview page, use this shell command:
#
#   sed -n '/ \{4\}C[0-9]\{4,5\}-/p' [filename] > [output csv file]
#
# To extract a given program from a complete Blurve
# preview, modify the command to excerpt a range of
# lines:
#
#   sed -n '/CATEGORY\: [A-Z]/,/CATEGORY\:/p' [filename] | sed -n '/ \{4\}C[0-9]\{4,5\}-/p' > [output]
#
# ... where [A-Z] is the letter representing the program
# you want to extract.
#

# Verify argument count
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <input_csv_file>"
  exit 1
fi

input_file="$1"

# Verify file exists
if [[ ! -f "$input_file" ]]; then
  echo "Error: File '$input_file' not found."
  exit 1
fi

sort -tC -k2,2n $1 | \
awk -F'C|-' '
{
  num = $2 + 0
  if (num >= 1     && num <= 1999)   file="group_0001-1999.csv"
  else if (num >= 2000  && num <= 3999) file="group_2000-3999.csv"
  else if (num >= 4000  && num <= 5999) file="group_4000-5999.csv"
  else if (num >= 6000  && num <= 7999) file="group_6000-7999.csv"
  else if (num >= 8000  && num <= 9999) file="group_8000-9999.csv"
  else if (num >= 10000 && num <= 11999) file="group_10000-11999.csv"
  else file="group_other.csv"
  print $0 >> file
}'

