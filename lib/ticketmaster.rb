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
  attr_reader :system, :authentication

  def initialize(system, authentication = {})
    @authentication, @system = Authenticator.new(authentication), system
  end

  def projects
    Project::Finder.new(@system, @authentication)
  end
end

class TicketMaster
  include TicketMasterMod
end
