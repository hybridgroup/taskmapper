module TaskMapper
  module Entities
    class Task
      include Entity
      
      attr_reader :project
      
      attr_accessor :title, :description, :requestor, :assignee
      
      def initialize(attrs)
        self.title        = attrs[:title]
        self.description  = attrs[:description]
        self.requestor    = attrs[:requestor]
        self.assignee     = attrs[:assignee]
        self.project      = attrs[:project]
      end
      
      def to_hash
        {
          :title        => self.title,
          :description  => self.description,
          :requestor    => self.requestor,
          :assignee     => self.assignee,
          :project      => self.project
        }
      end
      
      protected
        attr_writer :project
    end
  end
end
