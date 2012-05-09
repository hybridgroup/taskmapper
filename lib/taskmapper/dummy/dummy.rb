module TaskMapper::Provider
  # This is the Dummy Provider
  #
  # It doesn't really do anything, it exists in order to test the basic functionality of ticketmaster
  # and to provide an example the basics of what is to be expected from the providers.
  # 
  # Note that the initial provider name is a module rather than a class. TaskMapper.new
  # extends on an instance-based fashion. If you would rather initialize using code that is 
  # closer to:
  # 
  #    TaskMapper::Provider::Dummy.new(authentication)
  #
  # You will have to do a little magic trick and define new on the provider as a wrapper
  # around the TaskMapper.new call.
  module Dummy
    include TaskMapper::Provider::Base
    # An example of what to do if you would like to do TaskMapper::Provider::Dummy.new(...)
    # rather than TaskMapper.new(:dummy, ...)
    def self.new(authentication = {})
      TaskMapper.new(:dummy, authentication)
      # maybe do some other stuff
    end
  end
end

%w| project ticket comment |.each do |f|
  require File.dirname(__FILE__) + '/' + f +'.rb'
end
