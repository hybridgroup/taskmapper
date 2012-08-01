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
        super %{Provider '#{provider_name}' was not found
          In order to implement it
          Define module: TaskMapper::Providers::#{provider_name}/
        }
      end
    end
  end
end
