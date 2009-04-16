# Frozen gems
libdir = File.join(File.dirname(__FILE__),'..','..','gem')
require "#{libdir}/twitter-0.6.4/lib/twitter"

module Tweetmail
  module App
    attr_accessor :username, :email, :since

    def run
      #Set up SMTP settings
      server = Tweetmail::Helpers::read_config(options[:server])
      Tweetmail::Mailer::set_smtp_settings(server)

      # Set attributes from command line arguments or config file
      if args.empty?
        ostruct = Tweetmail::Helpers::read_config(options[:config])
        @username,@email,@since = [ ostruct.username, ostruct.email, ostruct.since ]
      else
        @username,@email,@since = [ args[0], args[1], options[:since] ]
      end

      # Get the @reply tweets
      @replies = Twitter::Replies(@username, @since)

      # Send out emails

      unless @replies.empty?
        Tweetmail::Mailer::send(@email, @replies) 
        @since = @replies.first.id
      end

      # Write a new configuration file for later use

      if options[:write_config]
        TweetMail::Helpers::write_config(@username, @email, @since)
      end

      # Log what just happened

      File.open(File.join(File.dirname(__FILE__), '..','..','log','log.txt'),'w') do |file|
        file << "Sent #{@replies.size} @replies to #{@email} at around #{Time.now.strftime("%H:%M%p %Z on %B %d, %Y")}.\n"
      end

    end
  end
end