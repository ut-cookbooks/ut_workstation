if platform?("mac_os_x")
  package "python"

  link "/usr/local/share/python/bin" do
    to "/usr/local/share/python"
  end
end

include_recipe "python::pip"

# install python pip packages
workstation_data.fetch('pip_packages', Hash.new).each_pair do |name, attrs|
  python_pip name do
    %w{version virtualenv options action}.each do |attr|
      send(attr, attrs[attr]) if attrs[attr]
    end
  end
end
