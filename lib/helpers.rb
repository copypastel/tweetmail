require 'ostruct'
require 'rubygems'
require 'actionmailer'

module TweetMail
  module Helpers
  
    def self.write_config(username, email, since)
      body = OpenStruct.new :username => username, :email => email, :since => since
      filename = 'config/' + username + '.yaml'
      config = File.open( filename, 'w' )
      config << YAML::dump(body)
      config.close
    end
  
    def self.read_config( file )
      filename = file
      file = File.open( filename, 'r' )
      config = YAML::load(file.read)
      file.close
      config 
    end
    
    def self.set_mailer_smtp_settings(config)
      ActionMailer::Base.smtp_settings = {
        :address         => config.address,
        :port            => config.port, 
        :domain          => config.domain,
        :user_name       => config.user_name,
        :password        => config.password,
        :authentication  => config.authentication  
      }
    end
  end
end