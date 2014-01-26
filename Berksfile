#!/usr/bin/env ruby
#^syntax detection

source 'http://api.berkshelf.com'

metadata

cookbook 'bashrc', git: 'https://github.com/fnichol/chef-bashrc.git', ref: 'v0.3.4'

# adds support for per-user defaults, pending release of new cookbook
cookbook 'mac_os_x', git: 'https://github.com/jtimberman/mac_os_x-cookbook.git', ref: '5055975f967e4fcc4c5d733a5bc6257e3adbff2c'

# adds support for creating profile.d dir & removing default chruby call, pending release of new cookbook
cookbook 'chruby', git: 'https://github.com/Atalanta/chef-chruby.git', ref: '48398b709e7bf6840995c7ec59968de1da19722c'

# pending merge and release containing:
# * https://github.com/chef-osx/xcode/pull/2
cookbook 'xcode', git: 'https://github.com/fnichol/xcode.git', ref: 'mac-10.7-support'

# adds support for vagrant 1.4.3+, pending release of new cookbook
# * https://github.com/jtimberman/vagrant-cookbook/pull/3
cookbook 'vagrant', git: 'https://github.com/fnichol/vagrant-cookbook.git', ref: 'atomic-penguin-pr-3'

# adds support for xquartz 2.7.5, pending release of new cookbook
# * https://github.com/jtimberman/xquartz-cookbook/pull/4
cookbook 'xquartz', git: 'https://github.com/jtimberman/xquartz-cookbook.git', ref: '2b2f8828d77ce79834a3ba9314c19737158511a3'

# adds support for configurable packages deps, pending release of new cookbook
# * https://github.com/opscode-cookbooks/ark/pull/46
cookbook 'ark', git: 'https://github.com/fnichol/ark.git', ref: 'configurable-pkg-deps'
