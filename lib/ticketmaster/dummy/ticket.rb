module TicketMaster::Provider
  module Dummy
    # The Dummy Provider's Ticket class
    class Ticket < TicketMaster::Provider::Base::Ticket
      @system = :dummy
      
      def self.find_by_id(project_id, ticket_id)
        self.new(project_id, {:id => ticket_id})
      end
      
      def self.find_by_attributes(*ticket_attributes)
        [self.new(*ticket_attributes)]
      end
    
      # You don't need to define an initializer, this is only here to initialize dummy data
      def initialize(project_id, *options)
        data = {:id => rand(1000), :status => ['lol', 'rofl', 'lmao', 'lamo', 'haha', 'heh'][rand(6)],
          :priority => rand(10), :summary => 'Tickets ticket ticket ticket', :resolution => false,
          :created_at => Time.now, :updated_at => Time.now, :description => 'Ticket ticket ticket ticket laughing',
          :assignee => 'lol-man', :project_id => project_id}
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
