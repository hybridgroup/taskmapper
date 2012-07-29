module TaskMapper
  module Entities
    class Session
      attr_reader :projects
      
      def initialize(provider_name, credentials, options = {})
        projects_provider = options[:projects_provider] || Provider.new(provider_name, self) 
        self.projects = TaskMapper::Projects.new self, projects_provider
      end
        
      protected
        attr_writer :projects
    end
  end
end
