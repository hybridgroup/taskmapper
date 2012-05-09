module TaskMapper::Provider
  module Tester
    # The Tester Provider's Ticket class
    class Ticket < TaskMapper::Provider::Base::Ticket
      @system = :tester
      
      # You don't need to define an initializer, this is only here to initialize tester data
      def initialize(project_id, *options)
        data = {:id => rand(1000), :status => ['lol', 'rofl', 'lmao', 'lamo', 'haha', 'heh'][rand(6)],
          :priority => rand(10), :summary => 'Tickets ticket ticket ticket', :resolution => false,
          :created_at => Time.now, :updated_at => Time.now, :description => 'Ticket ticket ticket ticket laughing',
          :assignee => 'lol-man', :project_id => project_id}
        @system = :tester
        super(data.merge(options.first || {}))
      end
      
    end
  end
end
