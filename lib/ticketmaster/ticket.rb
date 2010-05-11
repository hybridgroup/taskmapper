module TicketMaster
  class Ticket
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

    def status=(status)
      @status = status
      # Note that only some systems supports
      # this feature, if the status is :closed
      # then close function should be called
      # Update status to system
    end

    def close(option={})
      @status = :closed
      # Close at system
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
