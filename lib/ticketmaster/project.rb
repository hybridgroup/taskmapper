module TicketMasterMod
  class Project < Hashie::Mash
    # Find a project, or find more projects. You can also retrieve an array of all
    # projects by not specifying any query.
    #
    #     unfuddle = TicketMaster.new(:unfuddle, {:username => "..", :password => "..", :subdomain => ".."})
    #     unfuddle.projects.find("ticketmaster")
    #         #=> TicketMasterMod::Project<#name = "ticketmaster", ..>
    #     unfuddle.projects.find
    #         #=> [TicketMasterMod::Project<..>, TicketMasterMod::Project<..>, ..]
    #
    def self.find(query = nil, options = {})
      # Asks the client for the projects, should return an array of
      # project objects.
      projects = TicketMasterMod.const_get(options[:client].to_s.capitalize)::Project.find(query, options)
      
      if query
        query = {:name => query} if query.is_a?(String)

        # For some reason #tickets find ability messes up if we use a class method.
        # Thus I decided to go for an instance method.
        return Project.new.search(query, projects)
      end

      # No query, so we just go ahead and return the array of projects
      projects
    end

    # Asks the client for the tickets associated with the project,
    # returns an array of Ticket objects.
    #
    #     project.tickets
    #         #=> [TicketMasterMod::Ticket<...>, TicketMasterMod::Ticket<...>, ..]
    def tickets(query = {})
      tickets = TicketMasterMod.const_get(self.system.capitalize)::Project.tickets(self)
      return search(query, tickets) unless query.empty?

      tickets
    end

    # Mainly here because it is more natural to do:
    #     project.ticket.create(..)
    #
    # Than
    #     project.tickets.create(..)
    def ticket
      TicketMasterMod::Ticket::Creator.new(self)
    end

    def search(query, objects)
      matching_objects = []

      objects.each do |object|
        matches = 0
        query.each_pair do |method, expected_value|
          matches += 1 if object.send(method) == expected_value
        end

        matching_objects << object if matches == query.length
      end

      # Raw object versus array with one entry
      return matching_objects.first if matching_objects.length == 1
      matching_objects
    end

    class Finder
      def initialize(client, authentication)
        @client = client
        @authentication = Authenticator.new(authentication)
      end

      def find(query = nil, options = {})
        options[:authentication] = @authentication
        options[:client] = @client
        Project::find(query, options)
      end

      alias_method :[], :find
    end
  end
end
