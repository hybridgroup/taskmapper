module TaskMapper
  module Entities
    class Task
      include Entity
      
      attr_accessor :title, 
        :description, 
        :requestor, 
        :assignee, 
        :project_id, 
        :priority,
        :status,
        :factory
      
      protected :requestor=,
        :project_id=,
        :factory=

      def initialize(attrs)
        super attrs
        self.title        = attrs[:title]
        self.description  = attrs[:description]
        self.requestor    = attrs[:requestor]
        self.assignee     = attrs[:assignee]
        self.priority     = attrs[:priority]
        self.status       = attrs[:status]
        self.project_id   = attrs[:project_id]
        self.factory      = attrs[:factory]
        validate
      end

      def save
        factory.tasks.update self
      end
      
      def delete
        factory.tasks.delete self
      end
      
      def validate
        validate_presence_of  :title
        validate_presence_of  :requestor
        validate_status :in => [:open, :close] 
        validate_priority 
      end

      def validate_status(criteria)
        in_values = criteria[:in]
        raise Exceptions::InvalidStatus.new(in_values) unless in_values.include? self.status
      end 

      def validate_priority
        raise Exceptions::InvalidPriority.new if self.priority.nil? || self.priority < 0
      end


      def create_comment(attrs)
        comments.create attrs
      end
      
      alias :comment! :create_comment
      
      def comments
        factory.task_comments.where(:task => self)
      end
      
      def comments_count
        comments.count
      end
      
      def to_hash
        super.merge({
          :title        => self.title,
          :description  => self.description,
          :requestor    => self.requestor,
          :assignee     => self.assignee,
          :project_id   => self.project_id,
          :status       => self.status, 
          :priority     => self.priority
        })
      end
      
      protected
        attr_writer :project
    end
  end
end
