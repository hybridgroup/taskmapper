module TicketMaster::Provider
  # This is the Dummy Provider
  #
  # It doesn't really do anything, it exists in order to test the basic functionality of ticketmaster
  # and to provide an example the basics of what is to be expected from the providers.
  # 
  # Note that the initial provider name is a module rather than a class. TicketMaster.new
  # extends on an instance-based fashion. If you would rather initialize using code that is 
  # closer to:
  # 
  #    TicketMaster::Provider::Dummy.new(authentication)
  #
  # You will have to do a little magic trick and define new on the provider as a wrapper
  # around the TicketMaster.new call.
  module Dummy
    include TicketMaster::Provider::Base
    # An example of what to do if you would like to do TicketMaster::Provider::Dummy.new(...)
    # rather than TicketMaster.new(:dummy, ...)
    def self.new(authentication = {})
      TicketMaster.new(:dummy, authentication)
      # maybe do some other stuff
    end
  end
end

%w| project ticket comment |.each do |f|
  require File.dirname(__FILE__) + '/' + f +'.rb'
end
