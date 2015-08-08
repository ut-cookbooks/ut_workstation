#
# Cookbook Name:: ut_workstation
# Recipe:: _packages
#
# Copyright 2013, Fletcher Nichol
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

extend UTWorkstation::Helpers

if platform?("mac_os_x")
  homebrew_tap "homebrew/dupes"

  # install and setup homebrew cask
  Chef::Recipe.send(:include, Homebrew::Mixin)
  brew_owner = homebrew_owner
  include_recipe "homebrew::cask"
  %w[
    /opt/homebrew-cask /opt/homebrew-cask/Caskroom
    /Library/Caches/Homebrew /Library/Caches/Homebrew/Casks
  ].each do |dir|
    directory dir do
      owner brew_owner
    end
  end

  workstation_data.fetch("homebrew_taps", Hash.new).each_pair do |name, attrs|
    homebrew_tap name do
      %w[action].each do |attr|
        send(attr, attrs[attr]) if attrs[attr]
      end
    end
  end

  include_recipe "xquartz"
elsif platform_family?("debian")
  include_recipe "ubuntu" if platform?("ubuntu")
end

# install additional packages for the platform
workstation_data.fetch("system_packages", Hash.new).each_pair do |name, attrs|
  package name do
    %w[version source options action].each do |attr|
      send(attr, attrs[attr]) if attrs[attr]
    end
  end
end

if platform?("mac_os_x")
  # install homebrew casks
  ENV["HOMEBREW_CASK_OPTS"] = "--appdir=/Applications"
  workstation_data.fetch("casks", Hash.new).each_pair do |name, attrs|
    homebrew_cask name do
      %w[casked action].each do |attr|
        send(attr, attrs[attr]) if attrs[attr]
      end
    end
  end

  # symlink vim/view to use macvim, if installed
  %w[vim view].each do |v|
    link "/usr/local/bin/#{v}" do
      to "/usr/local/bin/mvim"
      only_if { ::File.exist?("/usr/local/bin/mvim") }
    end
  end
end
