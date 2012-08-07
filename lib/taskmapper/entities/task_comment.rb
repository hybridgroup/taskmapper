module TaskMapper
  module Entities
    class TaskComment
      include Entity
      
      attr_accessor :author,
        :body,
        :task_id,
        :factory
        
      protected :author=, :task_id=, :factory=
      
      def initialize(attrs)
        super attrs
        self.author     = attrs[:author]
        self.body       = attrs[:body]
        self.task_id    = attrs[:task_id]
        self.factory    = attrs[:factory]
        validate
      end
      
      def save
        factory.comments.update self
      end
      
      def validate
        validate_presence_of :body
        validate_presence_of :author
      end
      
      def to_hash
        {
          :id         => id,
          :author     => author,
          :body       => body,
          :task_id    => task_id
        }
      end
    end
  end
end
