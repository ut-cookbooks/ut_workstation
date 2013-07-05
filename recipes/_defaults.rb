if platform?("mac_os_x")
  include_recipe "mac_os_x"

  execute "killall Dock" do
    action :nothing
  end

  workstation_data.fetch("userdefaults", Hash.new).each_pair do |name, attrs|
    mac_os_x_userdefaults name do
      %w{domain key value type action}.each do |attr|
        send(attr, attrs[attr]) if attrs[attr]
      end

      user attrs.fetch('user', ENV['SUDO_USER'] || ENV['USER'])

      global attrs.fetch('global',
        attrs['domain'] =~ /^NSGlobalDomain$/ ? true : nil)

      sudo attrs.fetch('sudo',
        attrs['domain'] =~ /^\/Library\/Preferences/ ? true : nil)

      if attrs['domain'] =~ /^com.apple.dock$/
        notifies :run, "execute[killall Dock]"
      end
    end
  end
end
