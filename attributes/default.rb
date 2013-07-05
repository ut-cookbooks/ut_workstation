self.extend(UTWorkstation::Helpers)
self.extend(Chef::DSL::DataQuery)

load_workstation_data!
load_workstation_users!

if platform?("mac_os_x")
  include_attribute "ark"
  node.set['ark']['tar'] = "/usr/bin/tar"
end
