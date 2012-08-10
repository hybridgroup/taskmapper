module TaskMapper
  module Entities
    class TaskComment
      include Entity
      
      attr_accessor :author,
        :body,
        :task,
        :task_id,
        :factory
        
      protected :author=, :task=, :task_id=, :factory=
      
      def initialize(attrs)
        super attrs
        self.author     = attrs[:author]
        self.body       = attrs[:body]
        self.task_id    = attrs[:task_id]
        self.task       = attrs[:task]
        self.factory    = attrs[:factory]
        validate
      end
      
      def task_id
        @task_id ||= task.id
      end
      
      def task
        @task ||= factory.tasks.find task_id
      end
      
      def save
        factory.task_comments.update self
      end
      
      def delete
        factory.task_comments.delete self
      end
      
      def validate
        validate_presence_of :body
        validate_presence_of :author
        validate_task
      end
      
      def validate_task
        raise TaskMapper::Exceptions::TaskMapperException
          .new("Must provider a task_id or a task object") if @task_id.nil? and @task.nil?
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
