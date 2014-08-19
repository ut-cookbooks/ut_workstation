require "chefspec"
require "chefspec/librarian"
require_relative "support/example_groups/provider_example_group"
require_relative "support/example_groups/resource_example_group"

RSpec.configure do |config|
  config.log_level = :fatal

  config.include Chef::ProviderExampleGroup,
    :type => :provider,
    :file_path => %r{test/unit/providers/}

  config.include Chef::ResourceExampleGroup,
    :type => :resource,
    :file_path => %r{test/unit/resources/}
end

ChefSpec::Runner.define_runner_method :apt_repository

ChefSpec::Runner.define_runner_method :mac_os_x_userdefaults

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

def load_resource(cookbook, lwrp)
  require "chef/resource/lwrp_base"
  name = class_name_for_lwrp(cookbook, lwrp)
  unless Chef::Resource.const_defined?(name)
    Chef::Resource::LWRPBase.build_from_file(
      cookbook,
      File.join(File.dirname(__FILE__), %W[.. .. resources #{lwrp}.rb]),
      nil
    )
  end
end

def load_provider(cookbook, lwrp)
  require "chef/provider/lwrp_base"
  name = class_name_for_lwrp(cookbook, lwrp)
  unless Chef::Provider.const_defined?(name)
    Chef::Provider::LWRPBase.build_from_file(
      cookbook,
      File.join(File.dirname(__FILE__), %W[.. .. providers #{lwrp}.rb]),
      nil
    )
  end
end

def class_name_for_lwrp(cookbook, lwrp)
  require "chef/mixin/convert_to_class_name"
  Chef::Mixin::ConvertToClassName.convert_to_class_name(
    Chef::Mixin::ConvertToClassName.filename_to_qualified_string(cookbook, lwrp)
  )
end
