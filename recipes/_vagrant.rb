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

if node["ut_workstation"]["install_virtualbox"]
  if platform_family?("mac_os_x")
    homebrew_cask "virtualbox"
  else
    include_recipe "virtualbox"
  end
end

node.set["vagrant"]["version"] = node["ut_workstation"]["vagrant"]["version"]
node.set["vagrant"]["url"] = vagrant_package_uri(node["vagrant"]["version"])
node.set["vagrant"]["checksum"] = vagrant_sha256sum(node["vagrant"]["version"])

include_recipe "vagrant" if node["ut_workstation"]["install_vagrant"]
