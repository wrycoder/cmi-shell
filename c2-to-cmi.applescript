--Convert .csv files in Composer2 format to CMI's format

on open the_playlists
	set csv_folder to "~/radio/website/"
	repeat with a_list in the_playlists
		set full_name to name of (info for a_list)
		set base_name to do shell script "echo " & (full_name) & "| sed 's/\\.[^.]*$//'"
		set the_result to do shell script ("~/radio/bin/c2-to-cmi.sh " & (csv_folder) & base_name)
	end repeat
	display dialog "Done"
end open

on run
	display dialog "This converts .csv files in Composer-2 format to CMI's format. To use, just drop the file(s) onto the icon."
end run
