module TaskMapper
  module Entities
    class Session
      attr_reader :projects, :tasks
      
      def initialize(options = {})
        projects_provider = options[:projects_provider] ||TaskMapper::Providers::Projects.new(options[:provider_name], credentials)
        tasks_provider = options[:tasks_provider] || TaskMapper::Providers::Tasks.new(options[:provider_name], credentials)
        
        self.projects = TaskMapper::Projects.new :provider => projects_provider
        
        self.tasks = TaskMapper::Repositories::Tasks.new :provider => tasks_provider
      end
      
      def create_project(attrs)
        projects.create(attrs.merge :tasks => self.tasks)
      end
      
      protected
        attr_writer :projects, :tasks
    end
  end
end
