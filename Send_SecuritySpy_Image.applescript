--- To use this script, create two variables and an Action Group in indigo.
--- The two variables are "SendCamPicture" and "Subscribers".
--- The action group should simply run this script.
--- To use it, set the two variables and run the script/action group.
--- I use this to send a camera pictures based on a z-wave motion detector.
--- Or when someone presses my doorbell. ;)

set tempFile to "/tmp/securityspy_imessage.jpg"

tell application "IndigoServer"
	set astid to AppleScript's text item delimiters
	set Subscribers to value of variable "Subscribers"
	-- Format of Indigo Variable Subscribers is "user1 user2", space separated recipients (ie. "user@email.com +12099113203")
	set AppleScript's text item delimiters to space
	set Subscribers to Subscribers's text items
	set AppleScript's text item delimiters to astid
	set camNum to value of variable "SendCamPicture"
	-- set Indigo Variable SendCamPicture to the SecuritySpy camera #.
end tell

tell application "SecuritySpy"
	-- If you leave SecuritySpy closed, then uncomment the following lines.
	--	launch
	--	delay 1
	capture image camera number camNum as theFile with overwrite
end tell

-- This makes the variable work with Messages.app
set theFile to (POSIX file theFile)

tell application "Messages"
	repeat with Subscriber in Subscribers
		set targetBuddy to buddy Subscriber of (1st service whose service type = iMessage)
		-- You can adjust this delay.  0.5 is long, but it's more reliable.
		delay 0.2
		send theFile to targetBuddy
	end repeat
	-- If you use an applescript handler in Message.app, then you need this next line.
	close windows
end tell
