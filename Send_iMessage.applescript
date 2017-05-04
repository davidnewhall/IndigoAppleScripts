#!/usr/bin/osascript
--- This script is meant to be used via CLI or as a script you can execute
--- from within Indigo. If you use Indigo, your shell script will look like mine:
--- /Users/administrator/Documents/IndigoAppleScripts/Send_iMessage.applescript "%%v:1891888064%%" "%%v:1023892794%%"
--- The first variable is for my Subscribers. Space separated list of recipients.
--- The second is a variable triggers this script when it changes (the msg).

on SendMessage(Subscribers, theMessage)
	tell application "Messages"
		repeat with Subscriber in Subscribers
			set targetBuddy to buddy Subscriber of (1st service whose service type = iMessage)
			-- You can adjust this delay.  0.5 is long, but it's more reliable.
			delay 0.2
			send theMessage to targetBuddy
		end repeat
		-- If you use an applescript handler in Messages.app, then you need this next line.
		close windows
	end tell
end SendMessage

on run arg
	if (count of arg) is not 2 then
		tell application "System Events" to set myname to get name of (path to me)
		return "Usage: " & myname & " \"suscriber1 subscriber2 ...\" \"Message to send\""
	end if
	set AppleScript's text item delimiters to space
	-- This creates a list, which we iterate over next.
	set Subscribers to text items of (item 1 of arg)
	set AppleScript's text item delimiters to ""
	return SendMessage(Subscribers, item 2 of arg)
end run
