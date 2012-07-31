module TaskMapper
  module Repositories
    class Tasks < Repository
      attr_accessor :factory
    
      protected :factory
      
      def initialize(factory, criteria = {})
        super factory, factory.tasks_class, criteria
      end
      
      def where(criteria = {})
        factory.tasks self.criteria.merge(criteria)
      end
    end
  end
end
