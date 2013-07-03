self.extend(UTWorkstation::Helpers)
self.extend(Chef::DSL::DataQuery)

workstation_data = begin
  data_bag_item('workstation', node['platform'])
rescue Chef::Exceptions::InvalidDataBagPath => ex
  Hash.new
end
