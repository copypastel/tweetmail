#tweeter is the tweet mailer.
require 'rubygems'
require 'actionmailer'
require "smtp_tls"

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
  end
end

module TweetMail
  def self.send(email,tweets)
    Notifier.deliver_tweet_update(email,format_tweets(tweets))
  end
  
  def self.format_tweets(tweets)
    # Fill this out!
    tweets
  end
end

TweetMail.send("ecin@copypastel.com","Hello")
