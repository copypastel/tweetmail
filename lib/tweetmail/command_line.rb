# Standard libraries
%w:optparse optparse/date optparse/time:.each {|lib| require lib}

module Tweetmail
  module CommandLine
    # Option Parsing
    # default options
    $OPTIONS = {
      :config => File.join(File.dirname(__FILE__), "..",'..',"config","user-config.yaml"),
      :server => File.join(File.dirname(__FILE__),'..','..','config','server-settings.yaml')
    }

    parser = OptionParser.new do |opts|
      opts.banner = "Usage: tweetmail [username] [email]"

      opts.separator ""
      opts.separator "Options:"

      opts.on("-d", "--date ID", "Email @reply tweets since a specified tweet id, e.g. --since 1378993302") do |d|
        $OPTIONS[:since] = s
        @validator[:since] = true
      end

      opts.on("-c", "--config FILE", "Configuration file for twitter user, e.g. --config config/ecin.yaml") do |c|
        $OPTIONS[:config] = c
        @validator[:config] = true
      end

      opts.on("-s", "--server FILE", "Configuration file for server, e.g. --server config/server-settings.yaml") do |s|
        $OPTIONS[:server] = s
        @validator[:server] = true
      end

      opts.on("-w", "--write", "Write out configuration file after emailing the tweets.") do |n|
        $OPTIONS[:write_config] = n
        @validator[:write_config] = true
      end

      opts.on_tail("-h", "--help", "Show this message.") do
        puts opts
        exit
      end
    end

    parser.parse! ARGV
    if (ARGV.length != 2 or (ARGV[1] =~ /\w+@\w+\.\w+/).nil?) and 
      puts parser
      exit
    end
  end
end