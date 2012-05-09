module TaskMapper::Provider
  # This is the Yoursystem Provider for taskmapper 
  module Yoursystem
    include TaskMapper::Provider::Base
    #TICKET_API = Yoursystem::Ticket # The class to access the api's tickets
    #PROJECT_API = Yoursystem::Project # The class to access the api's projects
    
    # This is for cases when you want to instantiate using TaskMapper::Provider::Yoursystem.new(auth)
    def self.new(auth = {})
      TaskMapper.new(:yoursystem, auth)
    end
    
    # Providers must define an authorize method. This is used to initialize and set authentication
    # parameters to access the API
    def authorize(auth = {})
      @authentication ||= TaskMapper::Authenticator.new(auth)
      # Set authentication parameters for whatever you're using to access the API
    end
    
    # declare needed overloaded methods here
    
  end
end


