-- What camera are we sending a picture from? Should be the number. 
set camNum to 3
set theFile to "/tmp/securityspy_imessage.jpg"
set Subscribers to "user@domain.com" as list
-- This is an example of how to set multiple receivers (subscribers).
-- set Subscribers to "user@imessage.com" & "+120991116309" as list

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
		-- You can adjust these delays.  0.5 is long, but it's more reliable.
		delay 0.5
		send "Deurbel! Front Door Image" to targetBuddy
		delay 0.5
		send theFile to targetBuddy
	end repeat
	-- If you use an applescript handler in Message.app, then you need this. 
	close windows
end tell

