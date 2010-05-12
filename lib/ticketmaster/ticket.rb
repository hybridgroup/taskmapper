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

    def comments
      # Retrieve associated comments
    end

    def close(info = {})
      TicketMasterMod.const_get(@system)::Ticket.new.close(self, info)
    end

    class Comment
      def initialize(comment_vals = {})
        comment_vals.each do |index, value|
          instance_variable_set("@#{index}", value)
        end
      end
    end
  end
end
