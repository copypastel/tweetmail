# Standard libraries
%w:optparse optparse/date optparse/time:.each {|lib| require lib}

module Tweetmail
  module CommandParser
    # Option Parsing
    def self.parse(args)
    # default options
      options = {
        :config => File.join(File.dirname(__FILE__), "..",'..',"config","user-config.yaml"),
        :server => File.join(File.dirname(__FILE__),'..','..','config','server-settings.yaml')
      }

      parser = OptionParser.new do |opts|
        opts.banner = "Usage: tweetmail [-wh] [-i twitter_id] [-c config_file] [-s server_config_file] [username] [email]"

        opts.separator ""
        opts.separator "Options:"

        opts.on("-i", "--id ID", "Email @reply tweets since a specified tweet id, e.g. --id 1378993302") do |i|
          options[:since] = i
        end
      
        opts.on("-c", "--config FILE", "Configuration file for twitter user, e.g. --config config/ecin.yaml") do |c|
          options[:config] = c
        end

        opts.on("-s", "--server FILE", "SMTP configuration file for mail server, e.g. --server config/server-settings.yaml") do |s|
          options[:server] = s
        end

        opts.on("-w", "--write", "Write out configuration file after emailing the tweets") do |n|
          options[:write_config] = n
        end

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end
      
      parser.parse! args
      #todo add error checking!
      
      options
    end
  end
end