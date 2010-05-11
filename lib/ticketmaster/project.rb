module TicketMaster
  class Project
    attr_reader :name, :owner, :id, :description, :created_at, 
      :updated_at, :url, :private

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
    end

    def self.system(system)
      # Set the System, e.g. github. Capitalizing
      # because we use Eval (or const_get) to call
      # for the object
      #
      # @todo: Use some other system to get this function,
      # since this'll make it tricky to interact with multiple
      # systems at the same time!
      @@system = system.to_s.capitalize
      self
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
      eval(@@system)::Project.tickets(self)
    end

    def self.find(query = nil, options = {})
      # @todo replace eval with const_get
      #
      # We ask our API module for our project!
      eval(@@system)::Project.find(query, options)
    end
  end
end
