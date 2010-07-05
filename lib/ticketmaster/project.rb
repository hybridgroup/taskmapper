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
    # * self.find_by_id
    # * self.find_by_attributes
    #
    # Methods that might need to be implemented by the provider
    # * tickets
    # * ticket
    # * initialize
    # * update
    # * destroy
    # * self.create
    #
    # Methods that would probably be okay if the provider left it alone:
    #
    # * self.find - although you can define your own to optimize it a bit
    # * update!
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
      include TicketMaster::Provider::Common
      include TicketMaster::Provider::Helper
      extend TicketMaster::Provider::Helper
      attr_accessor :system, :system_data
      API = nil #Replace with your api digestor's class.

      # Find project
      # You can also retrieve an array of all projects by not specifying any query.
      #
      # * find() or find(:all) - Returns an array of all projects
      # * find(##) - Returns a project based on that id or some other primary (unique) attribute
      # * find([#, #, #]) - Returns many projects with these ids
      # * find(:first, :name => 'Project name') - Returns the first project based on the project's attribute(s)
      # * find(:last, :name => 'Some project') - Returns the last project based on the project's attribute(s)
      # * find(:all, :name => 'Test Project') - Returns all projects based on the given attribute(s)
      def self.find(*options)
        first = options.shift
        attributes = options.shift
        if first.nil? or (first == :all and attributes.nil?)
          self.find_by_attributes
        elsif first.is_a? Fixnum
          self.find_by_id(first)
        elsif first.is_a? Array
          first.collect { |id| self.find_by_id(id) }
        elsif first == :first
          projects = attributes.nil? ? self.find_by_attributes : self.find_by_attributes(attributes)
          projects.first
        elsif first == :last
          projects = attributes.nil? ? self.find_by_attributes : self.find_by_attributes(attributes)
          projects.last
        elsif first == :all
          self.find_by_attributes(attributes)
        end
      end
      
      # The first of whatever project
      def self.first(*options)
        self.find(:first, *options)
      end
      
      # The last of whatever project
      def self.last(*options)
        self.find(:last, *options)
      end
      
      # Accepts an integer id and returns the single project instance
      # Must be defined by the provider
      def self.find_by_id(id)
        if self::API.is_a? Class
          self.new self::API.find id
        else
          raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
        end
      end
      
      # Accepts an attributes hash and returns all projects matching those attributes in an array
      # Should return all projects if the attributes hash is empty
      # Must be defined by the provider
      def self.find_by_attributes(attributes = {})
        if self::API.is_a? Class
          self.search(attributes).collect { |thing| self.new thing }
        else
          raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
        end
      end
      
      # This is a helper method to find
      def self.search(options = {}, limit = 1000)
        if self::API.is_a? Class
          projects = self::API.find(:all)
          search_by_attribute(projects, options, limit)
        else
          raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
        end
      end

      # Asks the provider's api for the tickets associated with the project,
      # returns an array of Ticket objects.
      def tickets(*options)
        options.insert 0, id
        easy_finder(self.class.parent::Ticket, :all, options, 1)
      end
      
      # Very similar to tickets, and is practically an alias of it
      # however this returns the ticket class if no parameter is given
      # unlike tickets which returns an array of all tickets when given no parameters
      def ticket(*options)
        options.insert(0, id) if options.length > 0
        easy_finder(self.class.parent::Ticket, :first, options, 1)
      end
      
      # Create a ticket
      def ticket!(*options)
        options[0].merge!(:project_id => id) if options.first.is_a?(Hash)
        self.class.parent::Ticket.create(*options)
      end
      
      # Define some provider specific initalizations
      def initialize(*options)
        # @system_data = {'some' => 'data}
        super(*options)
      end
      
    end
  end
end
