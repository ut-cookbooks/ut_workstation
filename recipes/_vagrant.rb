node.set['vagrant']['url']      = workstation_data['vagrant']['url']
node.set['vagrant']['checksum'] = workstation_data['vagrant']['checksum']

include_recipe "virtualbox"
include_recipe "vagrant"
