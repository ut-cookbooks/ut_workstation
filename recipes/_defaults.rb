if platform?("mac_os_x")
  include_recipe "mac_os_x"

  workstation_data.fetch("userdefaults", Hash.new).each_pair do |name, attrs|
    mac_os_x_userdefaults name do
      %w{domain global key value type user sudo action}.each do |attr|
        send(attr, attrs[attr]) if attrs[attr]
      end
    end
  end
end
