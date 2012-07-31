module TaskMapper
  module Repositories
    class Tasks < Repository
      attr_accessor :factory
      
      protected :factory=
      
      def initialize(factory, criteria = {})
        self.factory = factory
        super factory.tasks_provider, criteria
      end
      
      def where(criteria = {})
        factory.tasks self.criteria.merge(criteria)
      end
    end
  end
end
