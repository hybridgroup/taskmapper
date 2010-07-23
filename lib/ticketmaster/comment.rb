module TicketMaster::Provider
  module Base
    # The comment class
    #
    # This will probably one of the most troublesome parts of creating a provider for ticketmaster
    # since there are so many different ways comments are handled by different APIs.
    # Keep in mind that if you do need to change/overwrite the methods, you will most likely
    # only need to overwrite #find_by_id, #find_by_attributes, #search, and possibly #initialize
    # as long as their parameters conform to what the find method expects.
    #
    # Here are the expected attributes:
    #
    # * author
    # * body
    # * id
    # * created_at
    # * updated_at
    # * ticket_id
    # * project_id
    class Comment < Hashie::Mash
      include TicketMaster::Provider::Common
      include TicketMaster::Provider::Helper
      extend TicketMaster::Provider::Helper
      attr_accessor :system, :system_data
      API = nil # Replace with your comment's API's Class

      # Find comment
      # You can also retrieve an array of all comments by not specifying any query.
      #
      # * find(<project_id>, <ticket_id>) or find(<project_id>, <ticket_id>, :all) - Returns an array of all comments
      # * find(<project_id>, <ticket_id>, ##) - Returns a comment based on that id or some other primary (unique) attribute
      # * find(<project_id>, <ticket_id>, [#, #, #]) - Returns many comments with these ids
      # * find(<project_id>, <ticket_id>, :first, :name => 'Project name') - Returns the first comment based on the comment's attribute(s)
      # * find(<project_id>, <ticket_id>, :last, :name => 'Some project') - Returns the last comment based on the comment's attribute(s)
      # * find(<project_id>, <ticket_id>, :all, :name => 'Test Project') - Returns all comments based on the given attribute(s)
      def self.find(project_id, ticket_id, *options)
        first, attributes = options
        if first.nil? or (first == :all and attributes.nil?)
          self.find_by_attributes(project_id, ticket_id)
        elsif first.is_a? Array
          first.collect { |id| self.find_by_id(project_id, ticket_id, id) }
        elsif first == :first
          comments = attributes.nil? ? self.find_by_attributes(project_id, ticket_id) : self.find_by_attributes(project_id, ticket_id, attributes)
          comments.first
        elsif first == :last
          comments = attributes.nil? ? self.find_by_attributes(project_id, ticket_id) : self.find_by_attributes(project_id, ticket_id, attributes)
          comments.last
        elsif first == :all
          self.find_by_attributes(project_id, ticket_id, attributes)
        else
          self.find_by_id(project_id, ticket_id, first)
        end
      end
      
      # The first of whatever comment
      def self.first(project_id, ticket_id, *options)
        self.find(project_id, ticket_id, :first, *options)
      end
      
      # The last of whatever comment
      def self.last(project_id, ticket_id, *options)
        self.find(project_id, ticket_id, :last, *options)
      end
      
      # Accepts an integer id and returns the single comment instance
      # Must be defined by the provider
      def self.find_by_id(project_id, ticket_id, id)
        if self::API.is_a? Class
          self.new self::API.find(id, :params => {:project_id => project_id, :ticket_id => ticket_id})
        else
          raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
        end
      end
      
      # Accepts an attributes hash and returns all comments matching those attributes in an array
      # Should return all comments if the attributes hash is empty
      # Must be defined by the provider
      def self.find_by_attributes(project_id, ticket_id, attributes = {})
        if self::API.is_a? Class
          self.search(project_id, ticket_id, attributes)
        else
          raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
        end
      end
      
      # This is a helper method to find
      def self.search(project_id, ticket_id, options = {}, limit = 1000)
        if self::API.is_a? Class
          comments = self::API.find(:all, :params => {:project_id => project_id, :ticket_id => ticket_id}).collect { |comment| self.new comment }
          search_by_attribute(comments, options, limit)
        else
          raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
        end
      end
    end
  end
end
