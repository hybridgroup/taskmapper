module TaskMapper
  class Client
    attr_accessor :session, :factory
    
    protected :session=, :session=
    
    def initialize(provider_name, credentials = {}, factory = Factory.new(provider_name, credentials))
      self.factory = factory
    end
    
    def create_project(attrs)
      projects.create(attrs)
    end
    
    alias :project! :create_project

    def projects
      factory.projects
    end
    
    def tasks
      factory.tasks
    end
    
    def metadata
      self.factory.provider_metadata
    end
    
    def support?(operation, entity)
      self.factory.provider_metadata.support? operation, entity
    end
  end
end
