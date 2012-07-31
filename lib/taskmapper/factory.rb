module TaskMapper
  class Factory
    attr_accessor :provider_name, 
      :credentials,
      :projects_provider,
      :tasks_provider
    
    protected :provider_name=, 
      :credentials=,
      :projects_provider=,
      :tasks_provider=
    
    def initialize(provider_name, credentials, options ={})
      self.provider_name = provider_name
      self.credentials = credentials
      
      self.projects_provider = options.fetch(:projects_provider) do
        Providers::Provider.new self, :projects
      end
      
      self.tasks_provider = options.fetch(:tasks_provider) do
        Providers::Provider.new self, :tasks
      end 
    end
    
    def session
      Entities::Session.new self
    end
    
    def project(attrs)
      Entities::Project.new self, attrs
    end
    
    def projects
      Projects.new self
    end
    
    def tasks(criteria = {})
      Repositories::Tasks.new self, criteria
    end
  end
end
