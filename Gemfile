source 'https://rubygems.org'

gem 'activeresource', '~> 3.0'
gem 'activesupport', '~> 3.0'
gem 'hashie', "~> 1.2"

group :test, :development  do
  gem 'devtools', :git => 'https://github.com/datamapper/devtools.git'
  gem 'jeweler', "~> 1.8"
  gem "rcov", "~> 1.0", :platform => :ruby_18
  eval File.read('Gemfile.devtools')
end
