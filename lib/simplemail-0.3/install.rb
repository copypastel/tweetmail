 #!/usr/local/bin/ruby
 #
 # $Id: install.rb,v 1.2 2003/06/07 12:28:24 nigelb Exp $
 # $Author: nigelb $
 #
 # Installer for rsite-ng using InstallPkg fom RAA
 
 require 'install-pkg'
 include InstallPkg
 package_name = "simplemail"
 InstallPkg.install_pkg(package_name)

