#!/usr/bin/awk -f
/CATEGORY:/ { 
    cat = $0
    gsub(/&nbsp;|&amp;nbsp;/, "", cat)
}
/Pre-recorded content:/ {
    line = $0
    gsub(/&nbsp;|&amp;nbsp;/, "", line)
    print cat "  ||  " line
}
