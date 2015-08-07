name             "ut_workstation"
maintainer       "Fletcher Nichol"
maintainer_email "fnichol@nichol.ca"
license          "Apache 2.0"
description      "Unicorn Tears Workstation"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "1.3.0"

supports "mac_os_x"
supports "ubuntu"
supports "debian"
supports "centos"

# please see Cheffile for any special/specific versions or forks
depends "apt",        "~> 2.5"
depends "ark",        "~> 0.9"
depends "bashrc"      # via git
depends "chruby",     "~> 0.2"
depends "dmg",        "~> 2.1"
depends "homebrew",   "~> 1.4"
depends "homesick",   "~> 0.4"
depends "mac_os_x",   "~> 1.4"
depends "ubuntu",     "~> 1.1"
depends "user",       "~> 0.3"
depends "ut_base",    "~> 1.2"
depends "python",     "~> 1.3"
depends "ruby_install", "1.0.4" # pending mac patch upstream
depends "xquartz"     # forked version, via git
depends "vagrant",    "~> 0.2"
depends "virtualbox", "~> 1.0"
depends "zip_app",    "~> 0.2"
