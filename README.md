#KateIsAwesome

#####currently live at www.katerainey.ninja


###Noteworthy features

* Twilio SMS processing
* Pusher-backed open web socket for instant page updates

###Twilio SMS processing
I define a route for a webhook endpoint that is called by the Twilio API whenever a text message is received. The Twilio controller parses data from the message and saves a new relation to the database.

###Open web socket
Using the Pusher gem and pusher.js, I instantiate a socket channel for incoming text messages. An event which automatically inserts new elements into the DOM is bound to the open channel. The Twilio controller triggers the event and passes down the relavent message data when a message is received.
