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

github = TicketMaster.interact_with(:github)
project = github.project.find("Flimpl", {:user => "sirupsen"})
