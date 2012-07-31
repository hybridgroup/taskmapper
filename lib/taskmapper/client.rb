module TaskMapper
  class Client
    attr_accessor :factory, :session
    
    protected :factory=, :session=
    
    def initialize(provider_name, credentials, factory = nil)
      self.factory = factory || Factory.new(provider_name, credentials)
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
