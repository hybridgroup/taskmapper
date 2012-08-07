module TaskMapper
  module Entities
    class Comment
      include Entity
      
      attr_accessor :author,
        :body,
        :task_id
        
      protected :author=, :task_id=
      
      def initialize(attrs)
        self.author     = attrs[:author]
        self.body       = attrs[:body]
        self.task_id    = attrs[:task_id]
      end
      
      def to_hash
        {
          :author     => author,
          :body       => body,
          :task_id    => task_id
        }
      end
    end
  end
end
