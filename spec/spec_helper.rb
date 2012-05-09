$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'taskmapper.rb'
require 'taskmapper/dummy/dummy.rb'
require 'rspec'

RSpec.configure do |config|
  config.color_enabled = true
end
