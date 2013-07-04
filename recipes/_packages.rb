if platform?("mac_os_x")
  include_recipe "homebrew"
  homebrew_tap "homebrew/dupes"

  include_recipe "xquartz"
end

# install additional packages for the platform
workstation_data.fetch('system_packages', Hash.new).each_pair do |name, attrs|
  package name do
    %w{version source options action}.each do |attr|
      send(attr, attrs[attr]) if attrs[attr]
    end
  end
end

if platform?("mac_os_x")
  # install zip-based apps
  workstation_data.fetch('zip_apps', Hash.new).each_pair do |name, attrs|
    zip_app_package name do
      %w{source zip_file destination checksum action}.each do |attr|
        send(attr, attrs[attr]) if attrs[attr]
      end
    end
  end

  # install dmg-based apps
  workstation_data.fetch('dmgs', Hash.new).each_pair do |name, attrs|
    dmg_package name do
      %w{volumes_dir dmg_name destination type source checksum action}.each do |attr|
        send(attr, attrs[attr]) if attrs[attr]
      end
    end
  end

  # symlink vim/view to use macvim, if installed
  %w{vim view}.each do |v|
    link "/usr/local/bin/#{v}" do
      to "/usr/local/bin/mvim"
      only_if { ::File.exists?("/usr/local/bin/mvim") }
    end
  end
end
