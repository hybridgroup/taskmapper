module TicketMaster::Provider
  module Base
    # The base ticket class for ticketmaster
    # All providers should inherit this class
    #
    # The difference between the class methods and instance methods are that the instance
    # methods should be treated as though they are called on a known ticket and the class
    # methods act based on a blank slate (which means the info to find a specific ticket has
    # to be passed in the parameters in the ticket)
    #
    # Methods that a provider must define:
    #
    # * self.find
    # * close
    # * save
    # * destroy
    #
    # Methods that the provider should define if feasible:
    #
    # * reload!
    # * initialize
    #
    # Methods that would probably be okay if the provider left it alone:
    #
    # * self.create
    # * update
    # * update!
    #
    # A provider should define as many attributes as feasibly possible. The list below are 
    # some guidelines as to what attributes are necessary, if your provider's api does not
    # implement them, point it to an attribute that is close to it. (for example, a summary
    # can point to title. and assignee might point to assigned_to. Remember to alias it in your class!)
    # 
    # * id
    # * status
    # * priority
    # * summary
    # * resolution
    # * created_at
    # * updated_at
    # * description
    # * assignee
    class Ticket < Hashie::Mash
      @ignore_inspect = %w| system system_data |
      @system = nil # The symbol for the provider.
      @system_data = nil # The system info for the provider
      attr_accessor :system, :system_data
      # Find a ticket
      #
      # The implementation should be able to accept these cases if feasible:
      #
      # * find(:all) - Returns an array of all tickets
      # * find(##) - Returns a project based on that id or some other primary (unique) attribute
      # * find(:first, :summary => 'Ticket title') - Returns a ticket based on the ticket's attributes
      # * find(:summary => 'Test Ticket') - Returns all tickets based on the given attributes
      def self.find(*options)
        raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
      end
      
      # Create a ticket.
      # Basically, a .new and .save in the same call. The default method assumes it is passed a
      # single hash with attribute information
      def self.create(*options)
        ticket = self.new(options.first)
        ticket.save
      end
      
      # Instantiate a new ticket (but don't save yet!)
      # The default method assumes a single hash with all the parameters is passed to Ticket.new
      def initialize(*options)
        super(options.first)
        # do some other stuff
      end

      # Close this ticket
      #
      # On success it should return true, otherwise false
      def close(*options)
        raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
      end
      
      # Save this ticket
      # Expected return value of true (successful) or false (failure)
      def save(*options)
        raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
      end
      
      # Reload this ticket
      def reload!(*options)
        raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
      end
      
      # Delete this ticket
      #
      # If your provider doesn't have a delete or trash option for tickets:
      #    raise TicketMaster::Exception.new("Tickets can not be destroyed on SomeProviderAPI")
      def destroy(*options)
        raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
      end
      
      # Update a ticket and save
      #
      # The default assumes the options passed to it is a single hash with the attributes to update
      def update!(*options)
        update(options.first)
        save
      end
      
      # Update a ticket's attributes, but no save
      # Used when you need to do mass attribute assignment
      def update(*options)
        options.first.each do |k, v|
          self.send(k + '=', v)
        end
        self
      end

    end
  end
end
