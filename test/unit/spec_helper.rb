require "chefspec"
require "chefspec/librarian"

RSpec.configure do |config|
  config.log_level = :fatal
end

ChefSpec::Runner.define_runner_method :apt_repository
