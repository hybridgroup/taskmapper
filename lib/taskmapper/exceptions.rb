module TaskMapper
  module Exceptions
    class TaskMapperException < Exception; end
    
    class RequiredAttribute < TaskMapperException
      # @param [Entity] 
      # @param [Hash] attributes for the entity
      # @param [String]  
      #
      # @example
      #   TaskMapper::Exceptions::RequiredAttribute.new Task, 
      #                                                 :value => 'value',
      #                                                 'value'
      #                                                 
      #
      # @return [TaskMapper::Exceptions::RequiredAttribute] represting the required attribute error
      def initialize(entity, attribute, value)
        super "#{entity} #{attribute} is required. Given value '#{value.inspect}'"
      end
    end
    
    class ProviderNotFound < TaskMapperException
      # @param [String] provider name
      #
      # @example
      #   TaskMapper::Exceptions::ProviderNotFound.new "In memory"
      #
      # @return [TaskMapper::Exceptions::ProviderNotFound] representing the provider not found error
      def initialize(provider_name)
        super ("Provider '#{provider_name.capitalize}' was not found " +
              "In order to implement it " +
              "Define module: TaskMapper::Providers::#{provider_name.capitalize}")
      end
    end
    
    class ImplementationNotFound < TaskMapperException
      # @param [Module] provider definition module
      # @param [Entity] instance
      # @param [String] method name
      # @param [Array] parameters passed to the method
      #
      # @example
      #   TaskMapper::Exceptions::ImplementationNotFound.new Kanbanpad,
      #                                                      Task,
      #                                                      "find_by_id",
      #                                                      [1],
      # @return [TaskMapper::Exceptions::ImplementationNotFound] representing the error for implementation not found
      def initialize(provider, entities, method, args)
        super "Provider #{provider} does not define #{entities}##{method}#{args}"
      end
    end
  end
end
