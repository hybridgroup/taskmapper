%w{
  rubygems
  hashie
}.each {|lib| require lib }

%w{
  project
  ticket
  authenticator
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
