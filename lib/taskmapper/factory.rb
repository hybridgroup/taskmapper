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
        Entities::Project     => Providers::Projects.new(self),
        Entities::Task        => Providers::EntityProvider.new(self, :Tasks),
        Entities::TaskComment => Providers::EntityProvider.new(self, :TaskComments) 
      }
    end
    
    def client
      TaskMapper::Client.new provider_name, credentials
    end    
    
    def projects_provider
      providers[project_class]
    end

    def tasks_provider
      providers[task_class]
    end
    
    def comments_provider
      providers[comment_class]
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
    
    def comment_class
      Entities::TaskComment
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
    
    def comments(criteria = {})
      Repositories::TaskComments.new self, criteria
    end
    
    def provider_metadata
      Provider::Metadata.new self
    end
    
    def get_entity_module(entity_name)
      get_provider_module.const_get(entity_name)
    end
    
    def providers_module
      TaskMapper::Providers
    end
    
    def exceptions_module
      TaskMapper::Exceptions
    end
    
    def get_provider_module
      unless provider_module_name
        raise exceptions_module::ProviderNotFound
          .new(nice_provider_name) 
      end      
      providers_module.const_get provider_module_name
    end
    
    def provider_module_name
      providers_module.constants
        .find { |c| c.to_s.downcase == nice_provider_name }
    end
    
    def nice_provider_name
      provider_name.to_s
        .gsub /\_/, ''
        .capitalize
        .downcase
    end
  end
end
