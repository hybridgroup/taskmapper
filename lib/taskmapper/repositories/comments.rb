module TaskMapper
  module Repositories
    class Comments < Repositories::EntityRepository
      def initialize(factory, criteria = {})
        super factory, factory.comment_class, criteria
      end
      
      def create(attrs)
        super attrs.merge(:task_id => task_id)
      end

      def task_id
        criteria[:task_id]
      end
    end
  end
end
