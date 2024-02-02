on run
	set theDayChoices to {"MON", "TUE", "WED", "THU", "FRI"}
	set day_prefix to choose from list theDayChoices with prompt "Select the day:" default items {"MON"}
	if day_prefix is not false then
		set the_result to do shell script ("~/radio/bin/vt-timings.sh " & day_prefix)
		display dialog the_result buttons {"OK"}
	end if
end run
