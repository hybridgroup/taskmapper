module TaskMapper
  module Repositories
    class Tasks < Repositories::EntityRepository
      def initialize(factory, criteria = {})
        super factory, factory.task_class, criteria
      end
    end
  end
end
