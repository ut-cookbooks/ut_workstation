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

if platform?("mac_os_x")
  homebrew_tap "homebrew/dupes"

  include_recipe "xquartz"
elsif platform_family?("debian")
  include_recipe "ubuntu" if platform?("ubuntu")
end

# install additional packages for the platform
workstation_data.fetch('system_packages', Hash.new).each_pair do |name, attrs|
  package name do
    %w{version source options action}.each do |attr|
      send(attr, attrs[attr]) if attrs[attr]
    end
  end
end

if platform?("mac_os_x")
  # install zip-based apps
  workstation_data.fetch('zip_apps', Hash.new).each_pair do |name, attrs|
    zip_app_package name do
      %w{source zip_file destination checksum action}.each do |attr|
        send(attr, attrs[attr]) if attrs[attr]
      end
    end
  end

  # install dmg-based apps
  workstation_data.fetch('dmgs', Hash.new).each_pair do |name, attrs|
    dmg_package name do
      %w{volumes_dir dmg_name destination type source checksum action}.each do |attr|
        send(attr, attrs[attr]) if attrs[attr]
      end
    end
  end

  # symlink vim/view to use macvim, if installed
  %w{vim view}.each do |v|
    link "/usr/local/bin/#{v}" do
      to "/usr/local/bin/mvim"
      only_if { ::File.exists?("/usr/local/bin/mvim") }
    end
  end
end
