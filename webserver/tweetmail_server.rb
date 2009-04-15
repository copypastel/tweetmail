require 'rubygems'
require 'sinatra'

def relative(path)
  File.join(File.dirname(__FILE__),path)
end

set :views, File.dirname(__FILE__)

get '/' do
  erb :index
end

post '/' do
  command = relative('../bin/tweetmail') + " -w #{params[:user_name]} #{params[:email]}"
  system(command)
  command
end