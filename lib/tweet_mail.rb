#tweeter is the tweet mailer.
require 'rubygems'
require 'actionmailer'
require 'ostruct'
require File.join(File.dirname(__FILE__), "smtp_tls")

# Actionmailer config
config = YAML::load_file(File.join(File.dirname(__FILE__),'..','config','config.yaml'))
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address         => config.address,
  :port            => config.port, 
  :domain          => config.domain,
  :user_name       => config.user_name,
  :password        => config.password,
  :authentication  => config.authentication  
}

class Notifier < ActionMailer::Base
  def tweet_update(email,body_html)
     recipients email
     from       "tweetmail@copypastel.com"
     subject    "You have new tweets"
     body       body_html
     content_type "text/html"
  end
end

module TweetMail
  def self.send(email,replies = [])
    Notifier.deliver_tweet_update(email,format_replies(replies)) unless replies == []
  end
  
  def self.format_replies(replies)
    html = '<center><b>You have @tweets!</b></center><br/><br/>'
    replies.each do |reply|
      html += "<a href='http://twitter.com/#{reply.from}'>#{reply.from}</a> at #{reply.when.strftime("%H:%M%p %Z on %B %d, %Y")}<br/>"
      html += reply.msg
      html += "<br/><br/>"
    end
    html
  end
end