--- I used this to initiate a FaceTime call from an Indigo Action Group.
--- When someone presses my doorbell, I get a call from the camera/mic on my porch.
--- This is a POC now since i no longe ruse this. FaceTime sucks for automation.
--- I use Skype now.

set camName to "USB 2.0 Camera"

tell application "IndigoServer"
	set Who to value of variable "FaceTimeRecipient"
        -- This should be a single recipient's phone number or apple-id email address.
	set astid to AppleScript's text item delimiters
	set AppleScript's text item delimiters to space
	-- We FaceTime the first subscriber in the list
	set phone_num to Who's first text item
	set AppleScript's text item delimiters to astid
end tell

do shell script "open facetime://" & quoted form of phone_num
tell application "FaceTime" to activate
tell application "System Events"
	tell process "FaceTime"
		repeat while not (button "Call" of window 1 exists)
			delay 0.1
		end repeat
		tell application "IndigoServer" to set value of variable named "FaceTimeActive" to 1
		click menu item named camName of menu 1 of menu bar item "Video" of menu bar 1
		delay 0.1
		click last menu item of menu 1 of menu bar item "Video" of menu bar 1
		delay 0.1
		click button "Call" of window 1
	end tell
end tell
