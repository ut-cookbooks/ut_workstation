#
# Cookbook Name:: ut_workstation
# Recipe:: default
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

Chef::Recipe.send(:include, UTWorkstation::Helpers)

# system-wide
include_recipe "ut_workstation::_base"
include_recipe "ut_workstation::_packages"
include_recipe "ut_workstation::_vagrant"
include_recipe "ut_workstation::_python"
include_recipe "ut_workstation::_defaults"

# per-user
include_recipe "ut_workstation::_users"
include_recipe "ut_workstation::_bashrc"
include_recipe "ut_workstation::_homesick"
include_recipe "ut_workstation::_ruby"
