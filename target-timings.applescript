
on split(theString)
	-- save delimiters to restore old settings
	set oldDelimiters to AppleScript's text item delimiters
	-- set delimiters to delimiter to be used
	set AppleScript's text item delimiters to ","
	-- create the array
	set theArray to every text item of theString
	-- restore the old setting
	set AppleScript's text item delimiters to oldDelimiters
	-- return the result
	return theArray
end split

on write_text_to_file(the_text, the_file, overwrite_existing)
	try
		set the_file to the_file as string
		set the_opened_file to open for access the_file with write permission
		if overwrite_existing is true then set eof of the_opened_file to 0
		write the_text & (ASCII character 10) to the_opened_file starting at eof
		close access the_opened_file
		return true
	on error err_description
		display dialog "Error: " & err_description
		try
			close access file the_file
		end try
		return false
	end try
end write_text_to_file

-- Extract hourly timings from daily preview page
on open the_file
	set voicetrack_folder to "Macintosh HD:Users:toulipp:radio:voicetracks-2" as alias
	set shell_script_folder to "~/radio/development/cmi-shell/"
	set full_name to POSIX path of the_file
	set raw_seconds to do shell script (shell_script_folder & "raw_seconds.sh " & full_name)
	set output_folder to choose folder with prompt "Choose the day" default location voicetrack_folder
	set timing_file_name to POSIX path of output_folder & ".timings"
	set timings_written to write_text_to_file(raw_seconds, timing_file_name, true)
	if timings_written is false then display dialog "Write failed"
end open

on get_timings(input_folder)
	set raw_seconds to ""
	try
		set fp to open for access (POSIX path of input_folder) & ".timings"
		set raw_seconds to read fp until eof
		close access fp
	on error err_description
		display dialog "Error reading timings: " & err_description
		try
			close access fp
		end try
	end try
	set split_timings to split(raw_seconds)
	set hours to {"N1", "N2", "L1", "N3", "N4", "L2", "A1", "A2", "A3", "L3", "L4", "P3", "P1", "P2"}
	choose from list hours as list with prompt "Please choose the hour"
	set selected_hour to result
	repeat with i from 1 to (count items of hours)
		if item i of hours is equal to selected_hour as text then
			set hour_total to item i of split_timings
			return hour_total
		end if
	end repeat
end get_timings

on run
	set voicetrack_folder to "Macintosh HD:Users:toulipp:radio:voicetracks-2" as alias
	set shell_script_folder to "~/radio/development/cmi-shell/"
	set input_folder to choose folder with prompt "Choose the day" default location voicetrack_folder
	set filled_time to get_timings(input_folder)
	display dialog "Pre-recorded time: " & filled_time
	set unfilled_time to do shell script (shell_script_folder & "time-remaining.sh " & (POSIX path of voicetrack_folder) & " " & filled_time)
	display dialog "Unfilled time: " & unfilled_time
end run