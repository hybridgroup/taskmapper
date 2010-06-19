module TicketMaster::Provider
  module Dummy
    # The Dummy Provider's Ticket class
    class Ticket < TicketMaster::Provider::Base::Ticket
      @system = :dummy
      
      # Find a ticket
      #
      # The implementation should be able to accept these cases if feasible:
      #
      # * find(:all) - Returns an array of all tickets
      # * find(##) - Returns a project based on that id or some other primary (unique) attribute
      # * find(:first, :summary => 'Ticket title') - Returns a ticket based on the ticket's attributes
      # * find(:summary => 'Test Ticket') - Returns all tickets based on the given attributes
      def self.find(*options)
        first = options.shift
        if first.nil? or first == :all
          [Ticket.new]
        elsif first == :first
          Ticket.new(options.shift)
        elsif first.is_a?(Hash)
          [Ticket.new(first)]
        end
      end
    
      # You don't need to define an initializer, this is only here to initialize dummy data
      def initialize(*options)
        data = {:id => rand(1000), :status => ['lol', 'rofl', 'lmao', 'lamo', 'haha', 'heh'][rand(6)],
          :priority => rand(10), :summary => 'Tickets ticket ticket ticket', :resolution => false,
          :created_at => Time.now, :updated_at => Time.now, :description => 'Ticket ticket ticket ticket laughing',
          :assignee => 'lol-man'}
        @system = :dummy
        super(data.merge(options.first || {}))
      end
      
      # Nothing to save so we always return true
      # ...unless it's the Ides of March and the second is divisible by three. muhaha!
      def save
        time = Time.now
        !(time.wday == 15 and time.day == 3 and time.to_i % 3 == 0)
      end
      
      # Nothing to close, so we always return true
      def close
        true
      end
      
      # Nothing to destroy so we always return true
      def destroy
        true
      end
    end
  end
end
