module TaskMapper
  module Entities
    class Task
      include Entity
      
      attr_accessor :title, 
        :description, 
        :requestor, 
        :assignee,
        :project,
        :project_id, 
        :priority,
        :status,
        :factory
      
      protected :requestor=,
        :project=,
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
        self.project      = attrs[:project]
        self.factory      = attrs[:factory]
        validate
      end
      
      def project_id
        @project_id ||= project.id
      end
      
      def project
        @project ||= factory.projects.find project_id
      end

      def save
        factory.tasks.update self
      end
      
      def delete
        factory.tasks.delete self
      end
      
      def validate
        validate_presence_of :title
        validate_presence_of :requestor
        validate_project
      end
      
      def validate_project
        raise TaskMapper::Exceptions::TaskMapperException
          .new("Must provider a project_id or a project object") if @project_id.nil? and @project.nil?
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
          :project_id   => self.project_id
        })
      end
      
      protected
        attr_writer :project
    end
  end
end
