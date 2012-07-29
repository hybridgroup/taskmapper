module TaskMapper
  module Entities
    class Provider
      attr_reader :session
      
      def initialize(provider_name, session)
        self.session = session
        provider_module = get_provider_module(provider_name)::Projects
        self.extend provider_module
      end
      
      protected
        attr_writer :session
        
        def get_provider_module(name)
          TaskMapper::Providers.const_get(name.capitalize)
        end
    end
  end
end
