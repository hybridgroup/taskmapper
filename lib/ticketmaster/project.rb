module TicketMasterMod
  class ProjectFinder
    def initialize(client, authentication)
      @client = client
      @authentication = Authenticator.new(authentication)
    end

    def find(project = nil, options = {})
      options[:authentication] = @authentication
      options[:client] = @client
      Project::find(project, options)
    end
  end

  class Project < Hashie::Mash
    # Find a project
    def self.find(project = nil, options = {})
      TicketMasterMod.const_get(options[:client].to_s.capitalize)::Project.find(project, options)
    end

    # Ask the right client for the tickets associated with the project
    # returns an array of Ticket objects.
    def tickets
      TicketMasterMod.const_get(self.system.capitalize)::Project.tickets(self)
    end

    # For creating tickets
    def ticket
      TicketMasterMod::Ticket::Interacter.new(self)
    end
  end
end
