--- To use this script, create two variables and a Trigger in Indigo.
--- The two variables are "SendCamPicture" and "Subscribers".
--- Format of Indigo Variable Subscribers is "user1 user2" (ie. "user@email.com +12099113203")
--- The Trigger should simply run this script when SendCamPictures changes.
--- To use it, change the variable SendCamPicture to the number of a camera in SecuritySpy.
--- I use this to send a camera pictures based on a z-wave motion detector.
--- Or when someone presses my doorbell. ;)

--- Set this to true if you wish for sent messages to be logged in the Indigo Log.
property LogMessages : true
-- This folder is used to save a temporary Image file. 
property TempFolder : "/tmp"

tell application "IndigoServer"
	-- set Indigo Variable SendCamPicture to the SecuritySpy camera #.
	set camNum to value of variable "SendCamPicture"
	set Subscribers to value of variable "Subscribers"
	set AppleScript's text item delimiters to space
	-- This creates a list, which we iterate over next.
	set Subscribers to text items of Subscribers
	set AppleScript's text item delimiters to ""
end tell

try
	tell application "Messages"
		set ImageFile to ""
		repeat with Subscriber in Subscribers
			-- We only capture an image if we have Subscribers.
			if ImageFile is "" then set ImageFile to my GetImage(camNum)
			send ImageFile to buddy Subscriber of (1st service whose service type = iMessage)
			my LogIt("Sent " & Subscriber & " -> A picture of camera #" & camNum)
			-- You can adjust this delay.  0.5 is long, but it's more reliable.
			if (count of Subscribers) is greater than 1 then delay 0.2
		end repeat
		-- If you use an applescript handler in Message.app, then you need this next line.
		close windows
	end tell
on error
	my LogIt("Error interacting with Messages.app.")
end try

on GetImage(camNum)
	set tempFile to TempFolder & "/securityspy_imessage.jpg"
	tell application "SecuritySpy"
		capture image camera number camNum as tempFile with overwrite
	end tell
	return (POSIX file tempFile)
end GetImage

on LogIt(Msg)
	if LogMessages is not true then return
	tell application "IndigoServer" to log Msg
end LogIt
