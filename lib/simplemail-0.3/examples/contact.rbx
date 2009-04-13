#!/usr/local/bin/ruby
#
# Send a message
# $Id: contact.rbx,v 1.1 2003/07/27 10:06:16 nigelb Exp $
# $Author: nigelb $
#
# This is a simple example of using simplemail to send an email resulting from
# a typical web contact form. 
#

# Extract details and send confirmation email
# Send message to recipient

require 'cgi'

cgi = CGI.new
r = Apache.request

# Get values etc
# make life a bit easier
firstName = cgi['firstName'][0] || "firstName"
lastName = cgi['lastName'][0] || 'lastName'
subject = cgi['subject'][0] || "subject"
emailAddress = cgi['emailAddress'][0] || 'emailAddress'
copyMe = cgi['copyMe'][0] || false
message = cgi['message'][0] || "message"

msgDetail = firstName + "|" + lastName + "|" + emailAddress + "|" + subject + "|" + message
f = File.new("enquiry.dat", "a")
f.puts msgDetail
f.close

# send the email

# make and send the confirmation page
r.content_type = 'text/html'
r.send_http_header

print <<DETAILS
