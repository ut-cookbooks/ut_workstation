require "chefspec"
require "chefspec/librarian"
require_relative "support/example_groups/provider_example_group"
require_relative "support/example_groups/resource_example_group"

RSpec.configure do |config|
  config.log_level = :fatal

  config.include Chef::ProviderExampleGroup,
    :type => :provider,
    :file_path => %r{test/unit/libraries/*/provider_*}

  config.include Chef::ResourceExampleGroup,
    :type => :resource,
    :file_path => %r{test/unit/libraries/*/resource_*}
end

ChefSpec.define_matcher :mac_os_x_userdefaults

def install_zip_app_package(name)
  ChefSpec::Matchers::ResourceMatcher.new(:zip_app_package, :install, name)
end

def install_dmg_package(name)
  ChefSpec::Matchers::ResourceMatcher.new(:dmg_package, :install, name)
end

def install_homebrew_cask(name)
  ChefSpec::Matchers::ResourceMatcher.new(:homebrew_cask, :install, name)
end

def uninstall_homebrew_cask(name)
  ChefSpec::Matchers::ResourceMatcher.new(:homebrew_cask, :uninstall, name)
end

def write_mac_os_x_userdefaults(default)
  ChefSpec::Matchers::ResourceMatcher.new(:mac_os_x_userdefaults, :write, default)
end

def install_ruby_install_ruby(rubie)
  ChefSpec::Matchers::ResourceMatcher.new(:ruby_install_ruby, :install, rubie)
end
