#
# Cookbook Name:: ut_workstation
# Recipe:: _ruby
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

chruby_installs = workstation_users.select { |_user, data|
  !data["chruby"].nil? && !data["chruby"] == false
}.map { |user, data|
  { "user" => user }.merge(data["chruby"])
}

if !chruby_installs.empty?
  include_recipe "chruby"
  include_recipe "ruby_install"

  # mac platform does not have a root group, fix needed in ruby_install
  # cookbook upstream
  if platform_family?("mac_os_x")
    resources("execute[chown root:root /usr/local/bin/ruby-install]").
      command("chown root:wheel /usr/local/bin/ruby-install")
  end
end

chruby_installs.each do |chruby|
  (chruby["rubies"] || Hash.new).each_pair do |ruby, flag_or_opts|
    next if flag_or_opts.nil? || flag_or_opts == false
    opts = flag_or_opts.is_a?(Hash) ? flag_or_opts : Hash.new

    ut_workstation_ruby "Ruby #{ruby} (#{chruby["user"]})" do
      version ruby
      user chruby["user"]
      group opts["group"]
      prefix_path opts["prefix_path"]
      environment opts["environment"]
      default opts["default"]
      action opts.fetch("opts", :install)
    end
  end
end
