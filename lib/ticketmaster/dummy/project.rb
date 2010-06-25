module TicketMaster::Provider
  module Dummy
    # This is the Project class for the Dummy provider
    class Project < TicketMaster::Provider::Base::Project
      # This serves to find projects
      # As noted in the Project class's documentation, we should try to accept these:
      #
      # * find(:all) - Returns an array of all projects
      # * find(##) - Returns a project based on that id or some other primary (unique) attribute
      # * find(:first, :summary => 'Project name') - Returns a project based on the project's attributes
      # * find(:summary => 'Test Project') - Returns all projects based on the given attribute(s)
      def self.find(*options)
        first = options.shift
        if first.nil? or first == :all
          [Project.new]
        elsif first == :first
          Project.new(options.shift)
        elsif first.is_a?(Hash)
          [Project.new(first)]
        end
      end
      
      # You should define @system and @system_data here.
      # The data stuff is just to initialize fake data. In a real provider, you would use the API
      # to grab the information and then initialize based on that info.
      # @system_data would hold the API's model/instance for reference
      def initialize(*options)
        data = {:id => rand(1000).to_i, :name => 'Dummy', :description => 'Mock!-ing Bird',
          :created_at => Time.now, :updated_at => Time.now}
        @system = :dummy
        super(data.merge(options.first || {}))
      end
      
      # Should return all of the project's tickets
      def tickets(*options)
        return Ticket.find(*options) if options.length > 0
        [Ticket.new]
      end
      
      # Point it to the Dummy's Ticket class
      def ticket(*options)
        return Ticket.find(:first, options.first) if options.length > 0
        Ticket
      end
      
      # Nothing to save so we always return true
      # ...unless it's an odd numbered second on Friday the 13th. muhaha!
      def save
        time = Time.now
        !(time.wday == 5 and time.day == 13 and time.to_i % 2 == 1)
      end
      
      # Nothing to update, so we always return true
      def update(*options)
        return true
      end
    end
  end
end
