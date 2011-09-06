$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'ticketmaster.rb'
require 'ticketmaster/dummy/dummy.rb'
require 'rspec'

RSpec.configure do |config|

end
