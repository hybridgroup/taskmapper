module TaskMapper
  class Factory
    attr_accessor :provider_name, 
      :credentials,
      :providers
    
    protected :provider_name=, 
      :credentials=,
      :providers,
      :providers=
    
    def initialize(provider_name, credentials, options ={})
      self.provider_name = provider_name
      self.credentials = credentials
      self.providers = {
        Entities::Project => Providers::Provider.new(self, :projects),
        Entities::Task    => Providers::Provider.new(self, :tasks) 
      }
    end    
    
    def projects_provider
      providers[project_class]
    end

    def tasks_provider
      providers[task_class]
    end
    
    def provider(entity_class)
      providers[entity_class]
    end
    
    def task_class
      Entities::Task
    end
    
    def project_class
      Entities::Project
    end
    
    def entity(entity_class, attrs)
      entity_class.new attrs.merge(:factory => self)
    end
    
    def session
      Entities::Session.new self
    end
    
    def projects
      Projects.new self
    end
    
    def tasks(criteria = {})
      Repositories::Tasks.new self, criteria
    end
    
    def provider_metadata
      Provider::Metadata.new self
    end
  end
end
