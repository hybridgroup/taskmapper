module TaskMapper::Provider
  module Dummy
    # This is the Comment class for the Dummy provider
    class Comment < TaskMapper::Provider::Base::Comment
      
            
      def self.find_by_id(id)
        self.new({:id => id})
      end
      
      def self.find_by_attributes(*options)
        [self.new(*options)]
      end
            
      # You don't need to define an initializer, this is only here to initialize dummy data
      def initialize(project_id, ticket_id, *options)
        data = {:id => rand(1000), :status => ['lol', 'rofl', 'lmao', 'lamo', 'haha', 'heh'][rand(6)],
          :priority => rand(10), :summary => 'Tickets ticket ticket ticket', :resolution => false,
          :created_at => Time.now, :updated_at => Time.now, :description => 'Ticket ticket ticket ticket laughing',
          :assignee => 'lol-man'}
        @system = :dummy
        super(data.merge(options.first || {}))
      end
      
    end
  end
end
