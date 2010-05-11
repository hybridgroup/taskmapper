%w{
  base
  interacter
  project
  ticket
  systems/github
}.each {|lib| require 'ticketmaster/' + lib }

module TicketMaster
  def self.interact_with(client)
    Interacter.new(client)
  end

  class NotYetImplemented < StandardError
  end
end
