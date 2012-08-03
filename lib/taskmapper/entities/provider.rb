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
          .new(get_provider_module, entity, method, args)
      end
      
      protected
        def get_entity_module
          get_provider_module.const_get(entity)
        end
        
        def get_provider_module
          str_name = factory.provider_name.to_s
          str_name.gsub! /\_/, ''
          str_name.capitalize!
          str_name.downcase!
          const = TaskMapper::Providers.constants.find { |c| c.to_s.downcase == str_name }
          
          raise TaskMapper::Exceptions::ProviderNotFound.new(str_name) unless const
          
          provider_module = TaskMapper::Providers.const_get const
          provider_module
        end
    end
  end
end
