%w{
  base
  project
  ticket
  authenticator
  systems/github
}.each {|lib| require 'ticketmaster/' + lib }

require 'rubygems'

module TicketMasterMod
  attr_reader :project, :client

  def initialize(client, authentication = {})
    @project = ProjectFinder.new(client, authentication)
  end
end

class TicketMaster
  include TicketMasterMod
end

p github = TicketMaster.new(:github)
p github.project.find("flimpl", {:user => "Sirupsen"}).tickets[0].close!
