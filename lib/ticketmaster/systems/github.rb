module TicketMaster
  module Github
    class Ticket < TicketMaster::Ticket
      def self.create(title, body)
      end

      def self.find(id)
      end

      def self.update(id, status)
      end

      def self.delete(id, message)
      end
    end

    class Project < TicketMaster::Project
      def self.create(title)
      end

      def self.find(query)
      end

      def self.update(id, options = {})
      end

      def self.delete(id, message)
      end
    end
  end
end
