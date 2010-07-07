module TicketMasterMod
  module Dummy
    module Project
      def self.find(query = nil, options = {})
        []
      end
      
      def self.tickets(thing)
        []
      end
    end

    module Ticket
    end
  end
end
