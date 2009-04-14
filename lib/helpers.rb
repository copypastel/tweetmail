require 'ostruct'
require 'rubygems'
require 'actionmailer'
require File.join(File.dirname(__FILE__), "tweet_mail")

module TweetMail
  module Helpers
    def self.write_config(username, email, since)
      body = OpenStruct.new :username => username, :email => email, :since => since
      filename = 'config/' + username + '.yaml'
      config = File.open( filename, 'w' )
      config << YAML::dump(body)
      config.close
    end
  
    def self.read_config( filename )
      YAML::load_file(filename) 
    end
    
    def self.set_mailer_smtp_settings(settings)
      ServerSettings.set(settings)
      ActionMailer::Base.smtp_settings = ServerSettings.get
    end
  end
end