#!/usr/bin/awk -f

/CATEGORY:/ {
    # Match "CATEGORY: " followed by a single capital letter (A–Z)
    if (match($0, /CATEGORY: *[A-Z]/)) {
        # RSTART is where the match starts, RLENGTH is its length
        # We want the last character of "CATEGORY: X" → the letter
        cat = substr($0, RSTART + RLENGTH - 1, 1)
    }
}

/Pre-recorded content:/ {
    # Look for a time like 00:53:35 anywhere on the line
    if (match($0, /[0-9][0-9]:[0-9][0-9]:[0-9][0-9]/)) {
        time = substr($0, RSTART, RLENGTH)
        print cat, time
    }
}

