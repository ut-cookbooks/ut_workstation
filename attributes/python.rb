if platform?("mac_os_x")
  node.set['python']['prefix_dir']        = '/usr/local'
  node.set['python']['pip']['prefix_dir'] = '/usr/local/share/python'
end
