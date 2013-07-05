Chef::Recipe.send(:include, UTWorkstation::Helpers)

# system-wide
include_recipe "ut_workstation::_packages"
include_recipe "ut_workstation::_vagrant"
include_recipe "ut_workstation::_python"
include_recipe "ut_workstation::_defaults"

# per-user
include_recipe "ut_workstation::_users"
include_recipe "ut_workstation::_bashrc"
include_recipe "ut_workstation::_homesick"
include_recipe "ut_workstation::_ruby"
