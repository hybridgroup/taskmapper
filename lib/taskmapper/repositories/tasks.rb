module TaskMapper
  module Repositories
    class Tasks < Repository
      def initialize(factory, criteria = {})
        super factory, factory.task_class, criteria
      end
      
      def project_id
        criteria[:project].id if criteria[:project] 
      end
    end
  end
end
