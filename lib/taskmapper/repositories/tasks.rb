module TaskMapper
  module Repositories
    class Tasks < Repositories::EntityRepository
      def initialize(factory, criteria = {})
        super factory, factory.task_class, criteria
      end
      
      def create(attrs)
        super attrs.merge(:project_id => project_id)
      end
      
      def project_id
        criteria[:project_id]
      end
    end
  end
end
