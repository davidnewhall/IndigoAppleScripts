--- Use this script to send a message via iMessage from within Indigo.
--- Set two variables and create an action group to use this.
--- The two variables are "Subscribers" and "MSG_Var"
--- The action group should simply execute this script file.

tell application "IndigoServer"
	set astid to AppleScript's text item delimiters
	set Subscribers to value of variable "Subscribers"
        -- Format of Indigo Variable Subscribers is "user1 user2", space separated recipients (ie. "user@email.com +12099113203")
	set AppleScript's text item delimiters to space
	-- This creates a list, which we iterate over later.
	set Subscribers to Subscribers's text items
	set AppleScript's text item delimiters to astid
	set theMessage to value of variable "MSG_Var"
        -- This is a string of text that will be sent.
end tell

-- If you wanted to run this without Indigo, you might simply remove the code above and add two lines like these:
-- set theMessage to "Some message you want to send here."
-- set Subscribers to {"+12099113203", "user@email.com"}

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
