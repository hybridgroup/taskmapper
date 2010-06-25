module TicketMaster::Provider
  module Base
    # This is the base Project class for providers
    #
    # Providers should inherit this class and redefine the methods
    # 
    # Each provider should have their own @system defined.
    # For example, ticketmaster-unfuddle's @system is :unfuddle and ticketmaster-lighthouse's
    # @system is :lighthouse.
    #
    # Methods that must be implemented by the provider
    #
    # * self.find
    # * tickets
    # * ticket
    # * save
    # * initialize
    # * update
    # * destroy
    #
    # Methods that would probably be okay if the provider left it alone:
    #
    # * self.create
    #
    # A provider should define as many attributes as feasibly possible. The list below are 
    # some guidelines as to what attributes are necessary, if your provider's api does not
    # implement them, point it to an attribute that is close to it. (for example, a name
    # can point to title. Remember to alias it in your class!)
    # 
    # * id
    # * name
    # * created_at
    # * updated_at
    # * description
    class Project < Hashie::Mash
      attr_accessor :system, :system_data
      # Find a project, or find more projects.
      # You can also retrieve an array of all projects by not specifying any query.
      #
      # The implementation should be able to accept these cases if feasible:
      #
      # * find(:all) - Returns an array of all projects
      # * find(##) - Returns a project based on that id or some other primary (unique) attribute
      # * find(:first, :summary => 'Project name') - Returns a project based on the project's attributes
      # * find(:summary => 'Test Project') - Returns all projects based on the given attribute(s)
      def self.find(*options)
        raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
      end
      
      # Create a project.
      # Basically, a .new and .save in the same call. The default method assumes it is passed a
      # single hash with attribute information
      def self.create(*options)
        project = self.new(options.first)
        project.save
        project
      end
      
      # The initializer
      def initialize(*options)
        super(options.shift)
        # do some other stuff
      end

      # Asks the provider's api for the tickets associated with the project,
      # returns an array of Ticket objects.
      def tickets(*options)
        raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
      end

      # Mainly here because it is more natural to do:
      #     project.ticket.create(..)
      #
      # Than
      #     project.tickets.create(..)
      # 
      # returns a ticket object or ticket class that responds to .new and .create. 
      def ticket(*options)
        raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
      end
      
      # Save changes to this project
      # Returns true (success) or false (failure)
      def save
        raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
      end
      
      # Delete this project
      # Returns true (success) or false(failure)
      def destroy
        raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
      end
      
    end
  end
end
