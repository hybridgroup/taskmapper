module TaskMapper
  class Client
    attr_reader :session
    
    def initialize(provider_name, credentials, options = {})
      self.session = Entities::Session.new options.merge(:provider_name => provider_name, 
        :credentials => credentials)
    end
    
    def project!(attrs)
      session.create_project(attrs.merge :session => self)
    end
    
    def projects
      session.projects
    end
    
    protected
      attr_writer :session
  end
end
