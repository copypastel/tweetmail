TweetMail
============

TweetMail is a 2.hour.project inspired, unsurprisingly, by a <a href='http://twitter.com/golan/statuses/1501685014'>tweet</a>. Single purpose: check for replies to a twitter username, package them up, and send them to a specified email. Dresses up nicely as a cron job.

Current Status
--------------

As a 2.hour.project, TweetMail is already feature-complete. Any future updates will only include bug fixes.

Dependencies
------------

* actionmailer
* twitter

Lessons Learned
---------------

* extending a class with a module inside a `before :all` block in a spec doesn't seem to pass onto tests
* using Struct.new is much faster than writing attribute accessors for method-less classes
* `require 'time'` may be needed for Time#parse to become available; try it out in IRB
* on a related note, there aren't many reasons to use DateTime over Time
* Time.parse works on '10:30am october 20 2009'; not so much luck on '10:30am 20 october 2009'

