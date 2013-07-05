#
# Cookbook Name:: ut_workstation
# Recipe:: _basrhrc
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

bashrc_installs = workstation_users.select { |user, data|
  !data['bashrc'].nil? && !data['bashrc'] == false
}.map { |user, data|
  { 'user' => user, 'update' => true }.
    merge(data['bashrc'].is_a?(Hash) ? data['bashrc'] : Hash.new)
}

node.set['bashrc']['user_installs'] = bashrc_installs

include_recipe "bashrc::user"
