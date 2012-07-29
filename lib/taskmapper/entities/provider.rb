module TaskMapper
  module Providers
    class Provider
      attr_reader :session, :entity
      
      def initialize(provider_name, session, entity)
        self.session = session
        self.entity = entity
        
        provider_module = get_provider_module(provider_name)::self.entity
        raise provider_module.inspect
        self.extend provider_module
      end
      
      protected
        attr_writer :session, :entity
        
        def get_provider_module(name)
          TaskMapper::Providers.const_get(name.capitalize)
        end
    end
    
    class Projects < Provider
      def initialize(provider_name, session)
        super(provider_name, session, Projects)
      end
    end
    
    class Tasks < Provider
      def initialize(provider_name, session)
        super(provider_name, session, Tasks)
      end
    end
  end
end
