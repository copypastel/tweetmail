#!/usr/local/bin/ruby

# Install documentation for access via http://localhost/doc/rubylibs/
#
# $Id: install-docs.rb,v 1.3 2003/06/07 12:28:24 nigelb Exp $
#
# $Author: nigelb $
#
# This assumes that the RDoc's have been built in ./doc and, perhaps
# that you are running RedHat with apache with the default location
# for local documentation
#
# If you have rdoc installed you can regenerate the documentation by
# doing the following:
#  cd lib; rdoc --main=simplemail.rb --op=../doc
#

if File.stat("/usr/share/doc").directory?
  unless File.stat("/usr/share/doc/rubylibs").directory?
    Dir.mkdir("/usr/share/doc/rubylibs")
  end
else
  puts "No /usr/share/doc directory\n"
  exit
end

if system("cp -pr doc /usr/share/doc/rubylibs/simplemail")
  puts "Documentation installed\n"
else
  puts "Documentation installation failed\n"
end
