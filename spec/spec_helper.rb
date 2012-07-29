unless ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end
end

require 'rspec'
RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end

def catch_error(&block)
  yield
  nil
rescue Exception => e
  e
end

require_relative '../lib/taskmapper'
