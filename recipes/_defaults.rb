#
# Cookbook Name:: ut_workstation
# Recipe:: _defaults
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
  include_recipe "mac_os_x"

  execute "killall Dock" do
    action :nothing
  end

  workstation_data.fetch("userdefaults", Hash.new).each_pair do |name, attrs|
    mac_os_x_userdefaults name do
      %w[domain key value type action].each do |attr|
        send(attr, attrs[attr]) if attrs[attr]
      end

      user attrs.fetch("user", ENV["SUDO_USER"] || ENV["USER"])

      global attrs.fetch("global",
        attrs["domain"] =~ /^NSGlobalDomain$/ ? true : nil)

      sudo attrs.fetch("sudo",
        attrs["domain"] =~ /^\/Library\/Preferences/ ? true : nil)

      if attrs["domain"] =~ /^com.apple.dock$/
        notifies :run, "execute[killall Dock]"
      end
    end
  end
end
