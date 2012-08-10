module TaskMapper
  module Repositories
    class TaskComments < Repositories::EntityRepository
      def initialize(factory, criteria = {})
        super factory, factory.comment_class, criteria
      end
    end
  end
end
