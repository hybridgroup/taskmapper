module TicketMasterMod
  class ProjectFinder
    def initialize(client)
      @client = client
    end

    def find(project, options = {})
      eval(@client.to_s.capitalize)::Project.find(project, options)
    end
  end

  class Project
    attr_reader :name, :owner, :id, :description, :created_at, 
      :updated_at, :url, :private, :system

    def initialize(name, info = {})
      # @todo: Make this more DRY!
      #
      # Basic
      @name = name
      @owner = info[:owner]
      @id = info[:id]
      @description = info[:description]

      # Time
      @created_at = info[:created_at]
      @updated_at = info[:updated_at]

      # Url
      @url = info[:url]

      # Public
      @private = info[:private] # True or false

      # System
      @system = info[:system].to_s.capitalize
    end

    def create
      # Create project
    end

    def delete
      # Delete project
    end

    def tickets
      # Lets ask that cute little API if I have any tickets
      # associated with me, shall we?
      eval(@system)::Project.tickets(self)
    end
  end
end
