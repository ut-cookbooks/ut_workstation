#
# Cookbook Name:: ut_workstation
# Recipe:: _vagrant
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

if workstation_data['vagrant'] && workstation_data['vagrant']['url']
  node.set['vagrant']['url']      = workstation_data['vagrant']['url']
  node.set['vagrant']['checksum'] = workstation_data['vagrant']['checksum']

  include_recipe "vagrant"
else
  Chef::Log.warn("Vagrant url not set so not installing Vagrant")
end

include_recipe "virtualbox" if node['ut_workstation']['install_virtualbox']
