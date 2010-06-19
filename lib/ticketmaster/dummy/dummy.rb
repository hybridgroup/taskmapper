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
    @system = :dummy
    # An example of what to do if you would like to do TicketMaster::Provider::Dummy.new(...)
    # rather than TicketMaster.new(:dummy, ...)
    def self.new(authentication = {})
      TicketMaster.new(:dummy, authentication)
      # maybe do some other stuff
    end
    
    # It returns all projects...
    def projects(*options)
      return Project.find(*options) if options.length > 0
      [Project.new]
    end
    
    # It returns all tickets...
    def tickets(*options)
      return Ticket.find(*options) if options.length > 0
      [Ticket.new]
    end
    
    # Returning a single ticket based on parameters or a Ticket class if no parameters given
    #
    # The later is for doing:
    #    ticketmaster.ticket.find(...)
    #    ticketmaster.tickets.create(...)
    #
    # It's semantically nicer to use ticketmaster.tickets.find ... but people do strange things...
    def ticket(*options)
      return Ticket.new(*options) if options.length > 0
      TicketMaster::Provider::Dummy::Ticket
    end
    
    # Return a single project based on parameters or the Project class if no parameters given
    #
    # The later is for doing:
    #     ticketmaster.project.find(...)
    #     ticketmaster.tickets.create(...)
    #
    # (It's semantically nicer to use ticketmaster.projects.find ... but people do strange things)
    def project(*options)
      return Project.new(*options) if options.length > 0
      TicketMaster::Provider::Dummy::Project
    end
  end
end

%w| project ticket |.each do |f|
  require File.dirname(__FILE__) + '/' + f +'.rb'
end
