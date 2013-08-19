name             "ut_workstation"
maintainer       "Fletcher Nichol"
maintainer_email "fnichol@nichol.ca"
license          "Apache 2.0"
description      "Unicorn Tears Workstation"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.4"

supports "mac_os_x"
supports "ubuntu"
supports "debian"

# please see Berksfile for any special/specific versions or forks
depends "apt",        '~> 2.0.0'
depends "bashrc"      # via git
depends "chgems",     '~> 1.0.2'
depends "chruby"      # forked version
depends "dmg",        '~> 1.1.0'
depends "homebrew"    # forked version
depends "homesick",   '~> 0.4.0'
depends "mac_os_x"    # forked version
depends "mosh",       '~> 0.3.0'
depends "ubuntu",     '~> 1.1.2'
depends "user",       '~> 0.3.0'
depends "ut_base",    '~> 1.0.2'
depends "python",     '~> 1.3.4'
depends "ruby_build", '~> 0.8.0'
depends "xquartz",    '~> 1.0.0'
depends "vagrant",    '~> 0.2.0'
depends "virtualbox"  # forked version
depends "zip_app",    '~> 0.2.2'
