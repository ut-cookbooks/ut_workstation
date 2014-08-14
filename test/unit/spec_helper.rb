require "chefspec"
require "chefspec/librarian"

RSpec.configure do |config|
  config.log_level = :fatal
end

ChefSpec::Runner.define_runner_method :apt_repository

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
