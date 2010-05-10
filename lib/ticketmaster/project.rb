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
      @public = info[:public] # True or false
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
        17 => Ticket.new("Fix something" {
            :id => 17,
            :status => :open,
            :body => "Something should be fixed!"
          }
        ),

        28 => Ticket.new("Fix something else" {
            :id => 27,
            :status => :open,
            :body => "Something else should be fixed!"
          }
        ),
      }
    end

    def self.find(query = nil)
      # Find projects matching query, and return an array of projects
      # or the single project if the array consists of only one project
      Project.new(query)
    end
  end
end
