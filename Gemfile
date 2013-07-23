source "https://rubygems.org"

gem 'rake'
gem 'foodcritic'

group :development do
  gem 'emeril', '~> 0.6.0'
end

group :integration do
  gem 'berkshelf'
  gem 'test-kitchen', git: 'git@github.com:opscode/test-kitchen.git', ref: 'master'
  gem 'kitchen-vagrant', git: 'git@github.com:opscode/kitchen-vagrant.git', ref: 'master'
end
