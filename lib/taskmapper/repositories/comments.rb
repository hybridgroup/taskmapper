module TaskMapper
  module Repositories
    class Comments < Repositories::EntityRepository
      def initialize(factory, criteria = {})
        super factory, factory.comment_class, criteria
      end

      def task
        criteria[:task]
      end
    end
  end
end
