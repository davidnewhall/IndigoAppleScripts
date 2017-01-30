-- Fix Messages.app
-- This will restart the Messages.app if it gets stuck with an error window.

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
