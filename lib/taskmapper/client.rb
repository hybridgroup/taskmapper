module TaskMapper
  class Client
    attr_accessor :session
    
    protected :session=
    
    def initialize(provider_name, credentials, factory = Factory.new(provider_name, credentials))
      self.session = factory.session
    end
    
    def project!(attrs)
      session.create_project(attrs.merge :session => self)
    end
    
    def projects
      session.projects
    end
  end
end
