module TaskMapper
  module Entities
    class Task
      include Entity
      
      attr_accessor :title, 
        :description, 
        :requestor, 
        :assignee,
        :project_id, 
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
        self.project_id   = attrs[:project_id]
        self.factory      = attrs[:factory]
        validate
      end
      
      def delete
        factory.tasks.delete self
      end
      
      def validate
        validate_presence_of :title
        validate_presence_of :requestor
      end
      
      def comments
        factory.comments.where(:task => self)
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
