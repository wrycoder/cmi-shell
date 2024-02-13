--Convert .csv files in Composer2 format to CMI's format

on open the_playlists
	set csv_folder to "~/radio/website/"
	repeat with a_list in the_playlists
		set full_name to POSIX path of a_list
		set the_result to do shell script ("~/radio/bin/c2-to-cmi " & full_name)
	end repeat
	display dialog "Done"
end open

on run
	display dialog "This converts .csv files in Composer-2 format to CMI's format. To use, just drop the file(s) onto the icon."
end run
