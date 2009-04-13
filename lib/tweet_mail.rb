#tweeter is the tweet mailer.
require 'rubygems'
require 'actionmailer'
require File.join(File.dirname(__FILE__), "smtp_tls")

# Actionmailer config
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address  => "smtp.gmail.com",
  :port  => 587, 
  :domain => 'copypastel.com',
  :user_name  => "tweetmail@copypastel.com",
  :password  => "tweetmailer",
  :authentication  => :plain
}


class Notifier < ActionMailer::Base
  def tweet_update(email,formatted_tweets)
     recipients email
     from       "tweetmail@copypastel.com"
     subject    "You have new tweets"
     body       formatted_tweets
     content_type "text/html"
  end
end

module TweetMail
  def self.send(email,tweets = [])
    Notifier.deliver_tweet_update(email,format_tweets(tweets)) unless tweets == []
  end
  
  def self.format_tweets(tweets)
    html = '<center><b>You have tweets!</b></center><br/><br/>'
    tweets.each do |tweet|
      html += "<a href='http://twitter.com/#{tweet.from}'>#{tweet.from}</a><br/>"
      html += tweet.msg
      html += "<br/><br/>"
    end
    html
  end
end

class TestTweet < Struct.new(:from,:msg)
end

TweetMail.send("ecin@copypastel.com",[TestTweet.new("Bob","Hello Man"),TestTweet.new("ecin","I like gay boys.")])
puts "done"