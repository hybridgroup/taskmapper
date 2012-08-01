module TaskMapper
  module Entities
    class Task
      include Entity
      
      attr_accessor :title, 
        :description, 
        :requestor, 
        :assignee, 
        :project,
        :factory
      
      protected :requestor=,
        :project=,
        :factory=
      
      def initialize(attrs)
        super attrs
        self.title        = attrs[:title]
        self.description  = attrs[:description]
        self.requestor    = attrs[:requestor]
        self.assignee     = attrs[:assignee]
        self.project      = attrs[:project]
        self.factory      = attrs[:factory]
      end
      
      def title=(value)
        @title = value
        validate_presence_of :title
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
          :project      => self.project.to_hash
        })
      end
      
      protected
        attr_writer :project
    end
  end
end
