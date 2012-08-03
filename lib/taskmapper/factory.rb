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
        Entities::Project => Providers::Provider.new(self, :Projects),
        Entities::Task    => Providers::Provider.new(self, :Tasks) 
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
    
    def comments(criteria = {})
      Repositories::Comments.new self, criteria
    end
    
    def provider_metadata
      Provider::Metadata.new self
    end
    
    def get_entity_module(entity_name)
      get_provider_module.const_get(entity_name)
    end
    
    def get_provider_module
      str_name = provider_name.to_s
      str_name.gsub! /\_/, ''
      str_name.capitalize!
      str_name.downcase!
      const = TaskMapper::Providers.constants.find { |c| c.to_s.downcase == str_name }
      
      raise TaskMapper::Exceptions::ProviderNotFound.new(str_name) unless const
      
      provider_module = TaskMapper::Providers.const_get const
      provider_module
    end
  end
end
