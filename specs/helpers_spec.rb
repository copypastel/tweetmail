require 'rubygems'
require 'twitter'
require 'fileutils'
require '../lib/helpers.rb'
require '../lib/twitter_ext.rb'

include TweetMailHelpers

describe TweetMailHelpers do
  
  before :all do
    Twitter.extend TwitterExt
    @username = 'ecin'
    @email = 'ecin@copypastel.com'
    @replies = Twitter::Replies(@username)
    @latest = @replies.first.when?
  end
  
  it "should save to a YAML file" do
    write_config(@username, @email, @replies)
    File.exists?(@username + '.yaml').should be(true)
  end
  
  it "should load from a config YAML file" do
    config = read_config(@username)
    config.username.should eql(@username)
    config.email.should eql(@email)
    config.datetime.should eql(@latest)
  end
  
  after :all do
    FileUtils::rm @username + '.yaml'
  end
  
end