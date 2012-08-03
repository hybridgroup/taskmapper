module TaskMapper
  module Repositories
    class Tasks < Repositories::Repository
      def initialize(factory, criteria = {})
        super factory, factory.task_class, criteria
      end
      
      def create(attrs)
        super attrs.merge(:project => project)
      end
      
      def project
        criteria[:project]
      end
    end
  end
end
