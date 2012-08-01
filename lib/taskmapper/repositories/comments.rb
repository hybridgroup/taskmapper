module TaskMapper
  module Repositories
    class Comments < Repository
      def initialize(factory, criteria = {})
        super factory, factory.task_class, criteria
      end

      def task
        criteria[:task]
      end
    end
  end
end
