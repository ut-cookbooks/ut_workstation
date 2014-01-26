source "https://rubygems.org"

# ridiculous version pins for sad ecosystem incompatabilities
gem 'json', '= 1.7.7' # make berkshelf and chef play nice(r)
gem 'yajl-ruby', '= 1.1.0' # make chef and foodcritic play nice(r)

gem 'rake'
gem 'foodcritic', '~> 3.0'

group :development do
  gem 'chef', '~> 11.8.2'
  gem 'emeril', '~> 0.6.0'
end

group :integration do
  gem 'berkshelf', '~> 3.0.0.beta5'
  gem 'test-kitchen', git: 'https://github.com/test-kitchen/test-kitchen.git'
  gem 'kitchen-vagrant'
  gem 'kitchen-docker'
end
