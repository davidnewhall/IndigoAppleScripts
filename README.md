# IndigoAppleScripts
This folder contains AppleScripts for use with Indigo.app - Home Automation Software

#### Send_SecuritySpy_Image.applescript
This script will send a picture, via iMessage using Messages.app, from a 
defined camera in SecuritySpy. I originally wrote it for John Steenhuis to 
send a picture for a "doorbell ringing" action.

#### Send_iMessage.applescript
This script will send a text message, via iMessage using Messages.app. I use
this to send myelf messages when doors/windows open and close. I also use it
for my doorbell and to tell me when my dehumidifer needs its bucket emptied.

#### Restart_Messages.applescript
I've run into issues where Messages.app becomes unresponsive because of an
error window. I created a schedule in Indigo to run this script every minute.
EDIT: I modified the script so you may run it as a standalone application.
It will continue to work as-is in Indigo, or you can export it from Script
Editor as an application with the "stay open after run handler" option
selected. Once you run it, it will make sure Messages.app it always open and
error-window free. This is a great option for those of you running
SecuritySpy and iMessageSpy without Indigo.

#### FaceTimeCall.applescript
Legacy script I no longer use/maintain to initiate a FaceTime call.

#### AnswerFaceTime.applescript
Legacy script I no longer use/maintain to answer an incoming FaceTime call.
