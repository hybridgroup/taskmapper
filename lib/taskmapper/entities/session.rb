module TaskMapper
  module Entities
    class Session
      attr_reader :projects, :tasks
      
      def initialize(provider_name, credentials, options = {})
        projects_provider = options[:projects_provider] ||TaskMapper::Providers::Projects.new(provider_name, self)
        tasks_provider = options[:tasks_provider] || TaskMapper::Providers::Tasks.new(provider_name, self)
        
        self.projects = TaskMapper::Projects.new :session => self, 
          :provider => projects_provider
        
        self.tasks = TaskMapper::Repositories::Tasks.new :session => self, 
          :provider => tasks_provider
      end
      
      def create_project(attrs)
        projects.create(attrs)
      end
      
      protected
        attr_writer :projects, :tasks
    end
  end
end
