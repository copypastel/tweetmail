# helpers.rb -- Tweetmail uses these methods throughout its application
require 'ostruct'

module Tweetmail
  module Helpers
    def self.write_config(username, email, since)
      body = OpenStruct.new :username => username, :email => email, :since => since
      filename = File.join(File.dirname(__FILE__),'..','..','config/', username + '.yaml')
      config = File.open( filename, 'w' )
      config << YAML::dump(body)
      config.close
    end
  
    def self.read_config( filename )
      YAML::load_file(filename) 
    end 
  end
end

