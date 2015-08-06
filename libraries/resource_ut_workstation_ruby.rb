#
# Cookbook Name:: ut_workstation
# Resource:: ut_workstation_ruby
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

require "chef/resource/lwrp_base"

class Chef

  class Resource

    class UtWorkstationRuby < Chef::Resource::LWRPBase

      provides :ut_workstation_ruby

      self.resource_name = :ut_workstation_ruby
      actions :install
      default_action :install

      attribute :version, :kind_of => String, :name_attribute => true
      attribute :user, :required => true, :kind_of => String
      attribute :group, :kind_of => String
      attribute :prefix_path, :kind_of => String
      attribute :environment, :kind_of => Hash, :default => Hash.new
      attribute :default, :kind_of => [TrueClass, FalseClass], :default => false
    end
  end
end
