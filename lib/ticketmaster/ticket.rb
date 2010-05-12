module TicketMasterMod
  class Ticket
    attr_reader :title, :id, :status, :body, :created_at,
      :updated_at, :closed_at, :votes, :creator, :project, :system,
      :login, :token

    def initialize(ticket_vals = {}) 
      ticket_vals.each do |index, value|
        instance_variable_set("@#{index}", value)
      end

      @system = @system.to_s.capitalize
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
      TicketMasterMod.const_get(@system)::Ticket.close!(self)
    end

    def reopen!
      @status = :open
    end

    class Comment
      def initialize(comment_vals = {})
        comment_vals.each do |index, value|
          instance_variable_set("@#{index}", value)
        end
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
