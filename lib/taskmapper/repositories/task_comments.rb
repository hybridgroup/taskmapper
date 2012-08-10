module TaskMapper
  module Repositories
    class TaskComments < Repositories::EntityRepository
      def initialize(factory, criteria = {})
        super factory, factory.comment_class, criteria
      end
      
      def create(attrs)
        super attrs.merge :task => task
      end

      def task
        criteria[:task]
      end
    end
  end
end
