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

  class Ticket
    def initialize(name, id, description)
      @title, @id, @body = title, id, body
    end
  end

  class Project
    def initialize(name, id, description)
      @title, @id, @body = title, id, body
    end
  end

  module Github
    class Tickets < TicketMaster::Tickets
      def self.create
        # Github way of creating a ticket
        # Returns a ticket object
      end

      def self.find
        # Github way of finding tickets
        # Returns an array of ticket objects
      end
    end

    class Projects < TicketMaster::Projects
      def self.find(query)
        # Github way of finding a project
        # Returns an array of project objects
      end
    end

    class Project < TicketMaster::Project
      def initialize
        @tickets = {1 => Ticket, 17 => Ticket, 23 => Ticket}
        # Extend hash object with a find method so one could call
        # project.tickets.find
        @ticket = Ticket
        # So one could call for class methods easily
        # project.ticket.create
      end
    end

    class Ticket < TicketMaster::Ticket
      def initialize
        super
        create
      end

      def self.create(title, options={})
        # Create ticket
        # Return self
      end

      def status=(status)
        # Set ticket status
        # Close if :done
        # Open if :in_progress
      end

      def close(option={})
        # close with :message
      end
    end
  end
end

p MyProject.methods
github = TicketMaster.new(:github)
p github

#=> [:PrivateTicketApp, :Github, :Lighthouse]
