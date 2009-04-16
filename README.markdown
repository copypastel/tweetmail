TweetMail
============

TweetMail is a <b>2.hour.project</b> inspired, unsurprisingly, by a <a href='http://twitter.com/golan/statuses/1501685014'>tweet</a>. Single purpose: check for replies to a twitter username, package them up, and send them to a specified email. Dresses up nicely as a cron job.

Current Status
--------------

As a 2.hour.project, TweetMail is already feature-complete. Any future updates will only include bug fixes.

Dependencies
------------


* actionmailer
* twitter

For the web-server...
________
* sinatra
* simple-daemon

Usage
-----

Edit `config/server-settings.template.yaml` by entering your SMTP server's information for emailing and save it as config.yaml.  The example is set up for gmail.  If you wish you may edit `user-config.template.yaml` and supply it as a command line option specified later.

Run `bin/tweetmail` with a twitter username and an email to send the @reply twitters to. It's suggested to run the script with `-w` to write a config file that keeps track of the latest @reply twitter that was sent. Afterwards, run `bin/tweetmail` with the `-c` option, specifying the previous config file which should rest neatly inside `config/`.  You need to have a server settings config file located at `config/server-settings.yaml`.  If you have more then one server settings file you can use -s to specify which file.

Web Server
----------

The Web Server is used in case you want to set up a service for several people to sign up at a local place.  It maintains its own daemon so you don't have to keep modifying your cron jobs.  The base server is sinatra.  To run the server run `bin/tweetmail_server`.

Lessons Learned
---------------


* extending a class with a module inside a `before :all` block in a spec doesn't seem to pass onto tests
* using Struct.new is much faster than writing attribute accessors for method-less classes
* `require 'time'` may be needed for Time#parse to become available; try it out in IRB
* on a related note, there aren't many reasons to use DateTime over Time
* Time.parse works on '10:30am october 20 2009'; not so much luck on '10:30am 20 october 2009'
* ostruct is needed to access the fields from the user config file.

