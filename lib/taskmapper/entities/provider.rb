module TaskMapper
  module Providers
    class Provider
      attr_accessor :credentials, :entity, :factory
      
      protected :credentials=, :entity=, :factory=
      
      def initialize(factory, entity)
        self.factory      = factory
        self.credentials  = factory.credentials
        self.entity       = entity
        self.extend get_entity_module
      end
      
      def supported_operations
        [:no_metadata_available]
      end
      
      def method_missing(method, *args, &block)
        def args.to_s
          empty? ? "" : "(#{map(&:class).join ','})"
        end
        
        raise TaskMapper::Exceptions::ImplementationNotFound
          .new(factory.get_provider_module, entity, method, args)
      end
      
      protected
        def get_entity_module
          factory.get_entity_module(entity)
        end
    end
  end
end
