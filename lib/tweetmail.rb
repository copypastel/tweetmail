# libdir taken from sinatra
# http://github.com/sinatra/sinatra/tree/master
libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'tweetmail/helpers'
require 'tweetmail/mailer'
require 'tweetmail/twitter_ext'