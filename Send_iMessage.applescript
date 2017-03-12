--- Use this script to send a message via iMessage from within Indigo.
--- To use this, create two variables and a trigger when "MSG_Var" changes.
--- The other variable, "Subscribers" should be set to a space-delimited list of iMessage names.
--- Format of Indigo Variable Subscribers is "user1 user2" (ie. "user@email.com +12099113203")
--- The trigger should simply execute this script file.

--- Set this to true if you wish for sent messages to be logged in the Indigo Log.
property LogMessages : true

tell application "IndigoServer"
	-- This is a string of text that will be sent.
	set theMessage to value of variable "MSG_Var"
	set Subscribers to value of variable "Subscribers"
	set AppleScript's text item delimiters to space
	-- This creates a list, which we iterate over next.
	set Subscribers to text items of Subscribers
	set AppleScript's text item delimiters to ""
end tell


try
	tell application "Messages"
		repeat with Subscriber in Subscribers
			send theMessage to buddy Subscriber of (1st service whose service type = iMessage)
			if (count of Subscribers) is greater than 1 then delay 0.1
			my LogIt("Sent " & Subscriber & " -> " & theMessage)
		end repeat
		-- If you use an applescript handler in Message.app, then you need this. 
		close windows
	end tell
on error
	my LogIt("Error with Messages.app.")
end try

on LogIt(Msg)
	if LogMessages is not true then return
	tell application "IndigoServer" to log Msg
end LogIt
