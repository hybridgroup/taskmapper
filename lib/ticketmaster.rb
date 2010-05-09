class TicketMaster
  class NotYetImplemented < StandardError

  class Tickets
    [:create, :update, :find, :delete].each do |method|
      define method method do
        raise NotYetImplemented
      end
    end
  end

  class Projects
    [:create, :update, :find, :delete].each do |method|
      define method method do
        raise NotYetImplemented
      end
    end
  end

  module Github
    class Tickets < TicketMaster::Tickets
      def self.create(title, body)
      end

      def self.find(id)
      end

      def self.update(id, status)
      end

      def self.delete(id, message)
      end
    end

    class Projects < TicketMaster::Projects
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
