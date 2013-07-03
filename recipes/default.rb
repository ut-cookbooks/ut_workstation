Chef::Recipe.send(:include, UTWorkstation::Helpers)

include_recipe "ut_workstation::_packages"
include_recipe "ut_workstation::_python"
include_recipe "ut_workstation::_ruby"
include_recipe "ut_workstation::_homesick"
include_recipe "ut_workstation::_defaults"
