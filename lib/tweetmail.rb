# libdir taken from sinatra
# http://github.com/sinatra/sinatra/tree/master
#For tweetmail
libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'rubygems'
require 'tweetmail/helpers'
require 'tweetmail/mailer'
require 'tweetmail/twitter_ext'
require 'tweetmail/command_parser'
require 'tweetmail/app'

Twitter.extend Tweetmail::TwitterExt