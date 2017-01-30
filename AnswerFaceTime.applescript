--- I once used this script to answer facetime calls on my Mac server.
--- I set this to run every 30 seconds via an Indigo schedule.
--- I no longer use this because FaceTime has too many bugs and Skype worked better. ;)
-- Really just a POC now. Have fun with this.

set camName to "HD Webcam C525"

tell application "IndigoServer" to set FTA to variable named "FaceTimeActive"
tell application "System Events"
	if (count of (processes whose name is "FaceTime")) > 0 then
		tell process "FaceTime"
			if (button "Accept" of window 1 exists) then
				click menu item named camName of menu 1 of menu bar item "Video" of menu bar 1
				delay 0.1
				click last menu item of menu 1 of menu bar item "Video" of menu bar 1
				click button "Accept" of window 1
			else if name of front window contains "with" then
				if FTA is equal to 0 then
					tell application "IndigoServer" to set value of variable named "FaceTimeActive" to 1
					click menu item named camName of menu 1 of menu bar item "Video" of menu bar 1
					delay 0.1
					click last menu item of menu 1 of menu bar item "Video" of menu bar 1
				end if
			else
				delay 1
				if name of front window does not contain "with" then
					tell application "IndigoServer" to set value of variable "FaceTimeActive" to 0
					tell application "FaceTime" to quit
				end if
			end if
		end tell
	end if
end tell
