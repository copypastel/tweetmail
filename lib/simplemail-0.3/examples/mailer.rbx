#!/usr/local/bin/ruby
#
# Send a message with an attachment
# $Id: $
# $Author: $
#
# This example processes a Web form and sends an email to
# the requestor including an attachment which is specified in a hidden field
# 
# The variable stuff is read from a simple text file
#

require 'cgi'
require 'simplemail'

cgi = CGI.new
r = Apache.request

# Get values etc
# make life a bit easier
firstName = cgi['firstName'][0] || 'firstName'
lastName = cgi['lastName'][0] || 'lastName'
emailAddress = cgi['emailAddress'][0] || 'emailAddress'
attachment = cgi['attachment'][0] || nil

msgDetail = [firstName, lastName, emailAddress].join("|")

# Check what we should do
action = cgi['action'][0]
if action == "Back" || emailAddress !~ /@/
        # do redirect
  r.headers_out["Location"] = "/"
  exit Apache::REDIRECT
end
f = File.new("valuation.dat", "a")
f.puts msgDetail
f.close

# All is ready for the processing, read the config file

File.open("mailer.cfg") do |f|
	cfgFrom = f.readline
	cfgBCC = f.readline
	cfgMsg = f.read
end

# send the email
m = SimpleMail.new
m.to = "#{firstName} #{lastName} <#{emailAddress}>"
m.from = 
m.bcc = 
m.subject = "#{firstName} - Here is the information you requested"
m.text =<<END
Hello #{firstName}:

END
m.sender = "bounce@handsoffriendship.com"
m.attachments << "/var/www/adorna/bin/valuation.pdf"
m.send


# make and send the confirmation page
r.content_type = 'text/html'
r.send_http_header

print <<DETAILS

DETAILS
