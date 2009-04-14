#tweeter is the tweet mailer.
require 'rubygems'
require 'actionmailer'
require 'ostruct'
require File.join(File.dirname(__FILE__), "helpers")
require File.join(File.dirname(__FILE__), "smtp_tls")

# Actionmailer config
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
#SMTP settings set by helper method

module TweetMail
  class Notifier < ActionMailer::Base
    def tweet_update(email,body_html)
      recipients email
      from       ServerSettings.get[:user_name]
      subject    "You have new tweets"
      body       body_html
      content_type "text/html"
    end
  end

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
  
  #Storage class for helping ActionMailer
  class ServerSettings
     @@settings = {}
     def self.set(settings)
       @@settings = settings
     end

     def self.get
       @@settings
     end
  end
end