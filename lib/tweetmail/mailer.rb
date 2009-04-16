libdir = File.dirname(__FILE__)

require "#{libdir}/../actionmailer-2.3.2/lib/actionmailer"
require "#{libdir}/../actionmailer-2.3.2/lib/smtp_tls}"

# Actionmailer config
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp

module Tweetmail
  module Mailer
    class Notifier < ActionMailer::Base
      def tweet_replies(email,body_html)
        recipients   email
        from         ServerSettings.get[:user_name]
        subject      "You have new tweets"
        body         body_html
        content_type "text/html"
      end
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
    
    def self.send(email,body_html)
      unless replies == []
        body_html = Tweetmail::Mailer::format_replies(replies)
        Notifier.deliver_tweet_replies(email,body_html)
      end
    end
    
    def self.set_mailer_smtp_settings(settings)
      ServerSettings.set(settings)
      ActionMailer::Base.smtp_settings = ServerSettings.get
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
end