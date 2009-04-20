require 'rubygems'
require 'sinatra'

require File.join(File.dirname(__FILE__),'../gem/cronedit-0.3.0/lib/cronedit')

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
  command = relative('../bin/tweetmail') + " -c config/#{params[:user_name]}.yaml"
  CronEdit::Crontab.Add( params[:user_name], "0,30 * * * * #{command}")
end