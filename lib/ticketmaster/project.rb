module TicketMasterMod
  class ProjectFinder
    def initialize(client, authentication)
      @client = client
      @authentication = Authenticator.new(authentication)
    end

    def find(query = nil, options = {})
      options[:authentication] = @authentication
      options[:client] = @client
      Project::find(query, options)
    end
  end

  class Project < Hashie::Mash
    # Find a project
    def self.find(query = nil, options = {})
      projects = TicketMasterMod.const_get(options[:client].to_s.capitalize)::Project.find(query, options)

      if query
        projects.each do |project|
          return project if project.name == query
        end

        return [] # No results
      end

      projects
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
