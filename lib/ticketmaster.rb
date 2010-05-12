%w{
  base
  project
  ticket
  systems/github
}.each {|lib| require 'ticketmaster/' + lib }

require 'rubygems'

module TicketMasterMod
  attr_reader :project, :client

  def initialize(client)
    @project = ProjectFinder.new(client)
  end
end

class TicketMaster
  include TicketMasterMod
end

p github = TicketMaster.new(:github)
p github.project.find("flimpl", {:user => "Sirupsen"}).tickets
