-- Fix Messages.app
-- This will restart the Messages.app if it gets stuck with an error window.
-- Be sure to save as an application and select "stay open after run handler"
-- You may also run this from script editor or from Indigo as a Schedule.

--- Set this to true if you wish for sent messages to be logged in the Indigo Log.
--- If you do not use Indigo, set this to false to avoid errors.
property LogMessages : true
-- When compiled as a standalone app, how often in seconds to check Messages.app.
-- 30 is generally okay, but every 5 seconds is still ok.
property CheckSeconds : 30

on CheckMessages()
	tell application "System Events"
		if (count of (processes whose name is "Messages")) < 1 then
			my LogIt("Started Messages.app. It was not running.")
			activate application "Messages"
			delay 0.5
			tell application "Messages" to close windows
		else if (button "Wait" of window 1 of process "Messages" exists) or (button "Ignore Error" of window 1 of process "Messages" exists) then
			set theID to (unix id of processes whose name is "Messages")
			do shell script "kill -9 " & theID
			my LogIt("Killed Messages.app. It had an error window!")
			delay 4
			activate application "Messages"
			delay 0.5
			tell application "Messages" to close windows
		end if
	end tell
end CheckMessages

on LogIt(Msg)
	if LogMessages is not true then return
	tell application "IndigoServer" to log Msg
end LogIt

on idle -- Used for standalone app.
	CheckMessages()
	return CheckSeconds
end idle

on run -- Used by Script Editor and Indigo.
	CheckMessages()
end run
