#
# Cookbook Name:: ut_workstation
# Recipe:: _python
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

extend(UTWorkstation::Helpers)

if platform?("mac_os_x")
  package "python"

  link "/usr/local/share/python/bin" do
    to "/usr/local/share/python"
  end
end

include_recipe "python::pip"

# install python pip packages
workstation_data.fetch("pip_packages", Hash.new).each_pair do |name, attrs|
  python_pip name do
    %w[version virtualenv options action].each do |attr|
      send(attr, attrs[attr]) if attrs[attr]
    end
  end
end
