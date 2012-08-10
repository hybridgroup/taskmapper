module TaskMapper
  module Providers
    class Session
      attr_accessor :projects, :tasks
      
      protected :projects=, :tasks=
      
      def initialize(factory)
        self.projects = factory.projects
        self.tasks    = factory.tasks
      end
      
      def create_project(attrs)
        projects.create(attrs.merge :tasks => self.tasks)
      end
    end
  end
end
