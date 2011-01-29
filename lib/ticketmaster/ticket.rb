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
    # Methods that the provider should define if feasible:
    #
    # * reload!
    # * initialize
    # * close
    # * save
    # * destroy
    #
    # Methods that would probably be okay if the provider left it alone:
    #
    # * self.create
    # * update
    # * update!
    # * self.find
    #
    # A provider should define as many attributes as feasibly possible. The list below are 
    # some guidelines as to what attributes are necessary, if your provider's api does not
    # implement them, point it to an attribute that is close to it. (for example, a title
    # can point to summary. and assignee might point to assigned_to. Remember to alias it in your class!)
    # 
    # * id
    # * status
    # * priority
    # * title
    # * resolution
    # * created_at
    # * updated_at
    # * description
    # * assignee
    # * requestor
    # * project_id
    class Ticket < Hashie::Mash
      include TicketMaster::Provider::Common
      include TicketMaster::Provider::Helper
      extend TicketMaster::Provider::Helper
      attr_accessor :system, :system_data
      API = nil # Replace with your ticket API's Class

      # Find ticket
      # You can also retrieve an array of all tickets by not specifying any query.
      #
      # * find(<project_id>) or find(<project_id>, :all) - Returns an array of all tickets
      # * find(<project_id>, ##) - Returns a ticket based on that id or some other primary (unique) attribute
      # * find(<project_id>, [#, #, #]) - Returns many tickets with these ids
      # * find(<project_id>, :first, :title => 'ticket name') - Returns the first ticket based on the ticket's attribute(s)
      # * find(<project_id>, :last, :title => 'Some ticket') - Returns the last ticket based on the ticket's attribute(s)
      # * find(<project_id>, :all, :title => 'Test ticket') - Returns all tickets based on the given attribute(s)
      def self.find(project_id, *options)
        first, attributes = options
        if first.nil? or (first == :all and attributes.nil?)
          self.find_by_attributes(project_id)
        elsif first.is_a? Array
          first.collect { |id| self.find_by_id(project_id, id) }
        elsif first == :first
          tickets = attributes.nil? ? self.find_by_attributes(project_id) : self.find_by_attributes(project_id, attributes)
          tickets.first
        elsif first == :last
          tickets = attributes.nil? ? self.find_by_attributes(project_id) : self.find_by_attributes(project_id, attributes)
          tickets.last
        elsif first == :all
          self.find_by_attributes(project_id, attributes)
        else
          self.find_by_id(project_id, first)
        end
      end
      
      # The first of whatever ticket
      def self.first(project_id, *options)
        self.find(project_id, :first, *options)
      end
      
      # The last of whatever ticket
      def self.last(project_id, *options)
        self.find(project_id, :last, *options)
      end
      
      # Accepts an integer id and returns the single ticket instance
      # Must be defined by the provider
      def self.find_by_id(project_id, ticket_id)
        if self::API.is_a? Class
          self.new self::API.find(ticket_id, :params => {:project_id => project_id})
        else
          raise TicketMaster::Exception.new("#{self.name}::#{this_method} method must be implemented by the provider")
        end
      end
      
      # Accepts an attributes hash and returns all tickets matching those attributes in an array
      # Should return all tickets if the attributes hash is empty
      # Must be defined by the provider
      def self.find_by_attributes(project_id, attributes = {})
        if self::API.is_a? Class
          self.search(project_id, attributes)
        else
          raise TicketMaster::Exception.new("#{self.name}::#{this_method} method must be implemented by the provider")
        end
      end
      
      # This is a helper method to find
      def self.search(project_id, options = {}, limit = 1000)
        if self::API.is_a? Class
          tickets = self::API.find(:all, :params => {:project_id => project_id}).collect { |ticket| self.new ticket }
          search_by_attribute(tickets, options, limit)
        else
          raise TicketMaster::Exception.new("#{self.name}::#{this_method} method must be implemented by the provider")
        end
      end

      # Asks the provider's api for the comment associated with the project,
      # returns an array of Comment objects.
      def comments(*options)
        options.insert 0, project_id
        options.insert 1, id
        easy_finder(provider_parent(self.class)::Comment, :all, options, 2)
      end
      
      def comment(*options)
        if options.length > 0
          options.insert(0, project_id)
          options.insert(1, id)
        end
        easy_finder(provider_parent(self.class)::Comment, :first, options, 2)
      end
      
      # Create a comment
      def comment!(*options)
        options[0].merge!(:project_id => project_id, :ticket_id => id) if options.first.is_a?(Hash)
        provider_parent(self.class)::Comment.create(*options)
      end
      
      # Close this ticket
      #
      # On success it should return true, otherwise false
      def close(*options)
        raise TicketMaster::Exception.new("#{self.class.name}::#{this_method} method must be implemented by the provider")
      end
      
      # Reload this ticket
      def reload!(*options)
        raise TicketMaster::Exception.new("#{self.class.name}::#{this_method} method must be implemented by the provider")
      end

    end
  end
end
