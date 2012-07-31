module TaskMapper
  class Factory
    attr_accessor :provider_name, 
      :credentials,
      :projects_provider,
      :tasks_provider,
      :providers
    
    protected :provider_name=, 
      :credentials=,
      :projects_provider=,
      :tasks_provider=,
      :providers=
    
    def initialize(provider_name, credentials, options ={})
      self.provider_name = provider_name
      self.credentials = credentials
      self.providers = {}
      
      self.projects_provider = options.fetch(:projects_provider) do
        Providers::Provider.new self, :projects
      end
      
      self.tasks_provider = options.fetch(:tasks_provider) do
        Providers::Provider.new self, :tasks
      end 
    end
    
    def projects_provider=(provider)
      providers[project_class] = provider
    end
    
    def tasks_provider=(provider)
      providers[tasks_class] = provider
    end
    
    def provider(entity_class)
      providers[entity_class]
    end
    
    def tasks_class
      Entities::Task
    end
    
    def project_class
      Entities::Project
    end
    
    def session
      Entities::Session.new self
    end
    
    def project(attrs)
      project_class.new attrs.merge(:factory => self)
    end
    
    def projects
      Projects.new self
    end
    
    def tasks(criteria = {})
      Repositories::Tasks.new self, criteria
    end
    
    def entity(entity_class, attrs)
      entity_class.new attrs.merge(:factory => self)
    end
  end
end
