#!/usr/bin/osascript
--- To use this script, create two variables and a Trigger in Indigo.
--- The two variables are "SendCamPicture" and "Subscribers".
--- Format of Indigo Variable Subscribers is "user1 user2" (ie. "user@email.com +12099113203")
--- The Trigger should simply run this script when SendCamPicture changes, and pass these two arguments, like this:
--- /Users/administrator/Documents/IndigoAppleScripts/Send_SecuritySpy_Image.applescript "%%v:1891888064%%" "%%v:381621976%%"
--- To use it, change the variable SendCamPicture to the number of a camera in SecuritySpy.
--- I use this to send a camera pictures based on a z-wave motion detector.
--- Or when someone presses my doorbell. ;)

--- Set this to true if you wish for sent messages to be logged in the Indigo Log.
property LogMessages : true
-- This folder is used to save a temporary Image file.
property TempFolder : "/tmp"

on run arg
	if (count of arg) is not 2 then
		tell application "System Events" to set myname to get name of (path to me)
		return "Usage: " & myname & " \"suscriber1 subscriber2 ...\" <camera_number>"
	end if
	set AppleScript's text item delimiters to space
	-- This creates a list, which we iterate over next.
	set Subscribers to text items of (item 1 of arg)
	set AppleScript's text item delimiters to ""
	return SendPicture(Subscribers, item 2 of arg)
end run

on SendPicture(Subscribers, camNum)
	try
		tell application "Messages"
			set ImageFile to ""
			repeat with Subscriber in Subscribers
				-- We only capture an image if we have Subscribers.
				if ImageFile is "" then set ImageFile to my GetImage(camNum)
				send ImageFile to buddy Subscriber of (1st service whose service type = iMessage)
				my LogIt("Sent " & Subscriber & " -> A picture of camera #" & camNum)
				-- You can adjust this delay.  0.5 is long, but it's more reliable.
				if (count of Subscribers) is greater than 1 then delay 0.5
			end repeat
			-- If you use an applescript handler in Message.app, then you need this next line.
			close windows
		end tell
	on error
		return my LogIt("Error interacting with Messages.app.")
	end try
	return "Sent a picture from camera # " & camNum & " to (" & (count of Subscribers) & "): " & Subscribers
end SendPicture

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
	return Msg
end LogIt
