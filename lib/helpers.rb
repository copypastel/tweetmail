require 'ostruct'

module TweetMailHelpers
  
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
  
end