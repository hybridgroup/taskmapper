%w{
  rubygems
  hashie
}.each {|lib| require lib }

%w{
  base
  project
  ticket
  authenticator
  systems/github
  systems/unfuddle
}.each {|lib| require 'ticketmaster/' + lib }


module TicketMasterMod
  attr_reader :project, :client

  def initialize(client, authentication = {})
    @project = ProjectFinder.new(client, authentication)
  end
end

class TicketMaster
  include TicketMasterMod
end

