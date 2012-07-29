module TaskMapper
  class Client
    attr_reader :session
    
    def initialize(provider_name, credentials, options = {})
      self.session = Entities::Session.new provider_name, 
        credentials, options
    end
    
    def project!(attrs)
      session.projects.create(attrs)
    end
    
    def projects
      session.projects.to_a
    end
    
    protected
      attr_writer :session
  end
end
