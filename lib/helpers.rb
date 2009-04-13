require 'ostruct'

module TweetMailHelpers
  
  def write_config(username, email, replies)
    body = OpenStruct.new :username => username, :email => email, :since => replies.first.id
    filename = 'config/' + username + '.yaml'
    config = File.open( filename, 'w' )
    config << YAML::dump(body)
    config.close
  end
  
  def read_config( username )
    filename = 'config/' + username + '.yaml'
    file = File.open( filename, 'r' )
    config = YAML::load(file.read)
    file.close
    config 
  end
  
end