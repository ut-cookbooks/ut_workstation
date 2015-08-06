#
# Cookbook Name:: ut_workstation
# Provider:: ut_workstation_ruby
#
# Copyright 2014, Fletcher Nichol
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

require "chef/provider/lwrp_base"

class Chef

  class Provider

    class UtWorkstationRuby < Chef::Provider::LWRPBase

      provides :ut_workstation_ruby

      use_inline_resources

      def whyrun_supported?
        true
      end

      action :install do
        set_updated { manage_ruby(:install) }
        set_updated { manage_ruby_version_file(:create) } if new_resource.default
      end

      def default_group
        Etc.getgrgid(Etc.getpwnam(new_resource.user).gid).name
      end

      def default_prefix_path
        ::File.join(user_home, ".rubies")
      end

      def group_name
        new_resource.group || default_group
      end

      def manage_ruby(run_action)
        ruby_prefix = new_resource.prefix_path || default_prefix_path
        ruby_env    = {
          "USER"  => new_resource.user,
          "HOME"  => user_home
        }.merge(new_resource.environment)

        ruby_install_ruby "#{new_resource.version} (#{new_resource.user})" do
          definition new_resource.version.sub("-", " ")
          user new_resource.user
          group group_name
          prefix_path ruby_prefix
          environment ruby_env
          action run_action
        end
      end

      def manage_ruby_version_file(run_action)
        file ::File.join(user_home, ".ruby-version") do
          user new_resource.user
          group group_name
          content "#{new_resource.version}\n"
          action run_action
        end
      end

      def set_updated
        r = yield
        new_resource.updated_by_last_action(r.updated_by_last_action?)
      end

      def user_home
        Etc.getpwnam(new_resource.user).dir
      end
    end
  end
end
