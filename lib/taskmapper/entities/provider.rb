module TaskMapper
  module Providers
    class Provider
      attr_reader :credentials, :entity
      
      def initialize(provider_name, credentials, entity)
        self.credentials = credentials
        self.entity = entity
        
        provider_module = get_provider_module(provider_name)::self.entity
        raise provider_module.inspect
        self.extend provider_module
      end
      
      protected
        attr_writer :credentials, :entity
        
        def get_provider_module(name)
          TaskMapper::Providers.const_get(name.capitalize)
        end
    end
    
    class Projects < Provider
      def initialize(provider_name, credentials)
        super(provider_name, credentials, Projects)
      end
    end
    
    class Tasks < Provider
      def initialize(provider_name, credentials)
        super(provider_name, credentials, Tasks)
      end
    end
  end
end
