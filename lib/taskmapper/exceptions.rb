module TaskMapper
  module Exceptions
    class TaskMapperException < Exception; end
    
    class RequiredAttribute < TaskMapperException
      def initialize(entity, attribute, value)
        super "#{entity} #{attribute} is required. Given value '#{value.inspect}'"
      end
    end
    
    class ProviderNotFound < TaskMapperException
      def initialize(provider_name)
        super ("Provider '#{provider_name.capitalize}' was not found " +
              "In order to implement it " +
              "Define module: TaskMapper::Providers::#{provider_name.capitalize}")
      end
    end
    
    class ImplementationNotFound < TaskMapperException
      def initialize(provider, entities, method, args)
        super "Provider #{provider} does not define #{entities}##{method}#{args}"
      end
    end
  end
end
