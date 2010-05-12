module TicketMasterMod
  class ProjectFinder
    def initialize(client, authentication)
      @client = client
      @authentication = Authenticator.new(authentication)
    end

    def find(project, options = {})
      options[:authentication] = @authentication
      eval(@client.to_s.capitalize)::Project.find(project, options)
    end
  end

  class Project
    attr_reader :name, :owner, :id, :description, :created_at, 
      :updated_at, :url, :private, :system

    def initialize(project_vals = {})
      project_vals.each do |index, value|
        instance_variable_set("@#{index}", value)
      end

      @system = @system.to_s.capitalize
    end

    def tickets
      # Lets ask that cute little API if I have any tickets
      # associated with me, shall we?
      TicketMasterMod.const_get(@system)::Project.tickets(self)
    end
  end
end
