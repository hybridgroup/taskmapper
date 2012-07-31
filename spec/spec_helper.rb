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

# Fake provider implementation
# I use this instead of mocks because it is closer to real providers interaction
module InMemoryProvider
  def last_id
    @last_id ||= 0
  end
  
  def last_id=(id)
    @last_id = id
  end
  
  def next_id
    self.last_id += 1
  end
  
  def objects
    @objects ||= []
  end
  
  def create(object)
    objects << object
    next_id
  end
end

