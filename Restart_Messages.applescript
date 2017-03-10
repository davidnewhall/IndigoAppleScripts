-- Fix Messages.app
-- This will restart the Messages.app if it gets stuck with an error window.
-- Be sure to save as an application and select "stay open after run handler"

on idle
	tell application "System Events"
		if (count of (processes whose name is "Messages")) < 1 then
			tell application "Messages" to activate
		else if (button "Wait" of window 1 of process "Messages" exists) or (button "Ignore Error" of window 1 of process "Messages" exists) then
			set theID to (unix id of processes whose name is "Messages")
			do shell script "kill -9 " & theID
			delay 4
			tell application "Messages" to activate
		end if
	end tell
	-- How often, in seconds, to check for Messages.app errors.
	-- 30 is generally okay, but every 5 seconds is still reasonable.
	return 30
end idle
