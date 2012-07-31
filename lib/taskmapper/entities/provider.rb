module TaskMapper
  module Providers
    class Provider
      attr_accessor :credentials, :entity, :factory
      
      protected :credentials=, :entity=, :factory=
      
      def initialize(factory, entity)
        self.factory = factory
        self.credentials = factory.credentials
        self.extend get_entity_module(entity)
      end
      
      protected
        def get_entity_module(entity)
          get_provider_module(factory.provider_name).const_get(entity.capitalize)
        end
        
        def get_provider_module(name)
          TaskMapper::Providers.const_get(name.capitalize)
        end
    end
  end
end
