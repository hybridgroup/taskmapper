module TicketMaster::Provider
  # This is the Yoursystem Provider for ticketmaster
  module Yoursystem
    include TicketMaster::Provider::Base
    
    # This is for cases when you want to instantiate using TicketMaster::Provider::Yoursystem.new(auth)
    def self.new(auth = {})
      TicketMaster.new(:yoursystem, auth)
    end
    
    # declare needed overloaded methods here
    
  end
end


