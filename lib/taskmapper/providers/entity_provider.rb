module TaskMapper
  module Providers
    class EntityProvider
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
        raise_implementation_instructions(method, args)        
      end
      
      def raise_implementation_instructions(method, args)
        def args.to_s
          empty? ? "" : "(#{map(&:class).join ','})"
        end
        
        raise TaskMapper::Exceptions::ImplementationNotFound
          .new(factory.provider_module, entity, method, args)
      end
      
      # Default behavior for finder methods if not defined by the provider
      def find_by_id(id)
        all.find { |attributes| attributes[:id] == id }
      end
      
      def find_by_attributes(attributes)
        all.find { |attrs| attrs.merge(attributes) == attrs }
      end
      
      def all
        search
      end
      
      protected
        def get_entity_module
          factory.entity_module(entity)
        end
    end
  end
end
