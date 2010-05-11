module TicketMaster
  class Project
    def initialize(name, info = {})
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
      @@system = system.capitalize
      self
    end

    def create
      # Create project
    end

    def delete
      # Delete project
    end

    def tickets
      # Find tickets associated with the project

      # Dummy stuff
      {
        17 => Ticket.new("Fix something", {
            :id => 17,
            :status => :open,
            :body => "Something should be fixed!",
          }
        ),

        28 => Ticket.new("Fix something else", {
            :id => 27,
            :status => :open,
            :body => "Something else should be fixed!",
          }
        ),
      }
    end

    def self.find(query = nil, options = {})
      # @todo replace eval with const_get
      eval(@@system)::Project.find(query, options)
    end
  end
end
