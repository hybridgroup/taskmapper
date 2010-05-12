module TicketMasterMod
  class Ticket
    attr_reader :title, :id, :status, :body, :created_at,
      :updated_at, :closed_at, :votes, :creator, :project, :system,
      :login, :token

    def initialize(title, info = {}) 
      # @todo: Make this more dry!
      #
      # Basic functionality
      @title, @id, @status, @body = title, info[:id], info[:status], info[:body]
      # Time
      @created_at = info[:created_at]
      @updated_at = info[:updated_at]
      @closed_at = info[:closed_at]
      # Community
      @votes = info[:votes]
      @creator = info[:creator]
      # System
      @system = info[:system].to_s.capitalize
      @project = {} 
      @project[:name] = info[:project_name]
      @project[:owner] = info[:project_owner]
      # Login
      @authentication = info[:authentication]
    end

    def create
      # Create ticket at system
    end

    def save
      # Save to system
    end

    def delete
      # Delete ticket
    end

    def comments
      # Retrieve associated comments
    end

    def close!
      @status = :closed
      eval(@system)::Ticket.close!(self)
    end

    def reopen!
      @status = :open
    end

    class Comment
      def initialize(info = {})
        # Basic
        @author = info[:author]
        @body = info[:body]
        @id = info[:id]
        @ticket = info[:ticket_id] # Associate with a ticket

        # Time
        @created_at = info[:created_at]
        @updated_at = info[:updated_at]
      end

      def create
        # Create comment
      end

      def save
        # Save comment
      end

      def delete
        # Delete comment
      end
    end
  end
end
