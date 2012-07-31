module TaskMapper
  class Client
    attr_accessor :session, :factory
    
    protected :session=, :session=
    
    def initialize(provider_name, credentials = {}, factory = Factory.new(provider_name, credentials))
      self.factory = factory
      self.session = factory.session
    end
    
    def project!(attrs)
      session.create_project(attrs.merge :session => self)
    end
    
    def projects
      session.projects
    end
    
    def metadata
      self.factory.provider_metadata
    end
    
    def support?(operation, entity)
      self.factory.provider_metadata.support? operation, entity
    end
  end
end
