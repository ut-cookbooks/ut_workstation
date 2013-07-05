if workstation_data['vagrant'] && workstation_data['vagrant']['url']
  node.set['vagrant']['url']      = workstation_data['vagrant']['url']
  node.set['vagrant']['checksum'] = workstation_data['vagrant']['checksum']

  include_recipe "vagrant"
else
  Chef::Log.warn("Vagrant url not set so not installing Vagrant")
end

include_recipe "virtualbox" if node['ut_workstation']['install_virtualbox']
