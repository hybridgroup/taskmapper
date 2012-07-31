module TaskMapper
  module Repositories
    class Tasks < Repository
      def initialize(factory, criteria = {})
        super factory, factory.tasks_class, criteria
      end
    end
  end
end
