module TaskMapper
  module Exceptions
    class TaskMapperException < Exception; end
    
    class RequiredAttribute < TaskMapperException
      def initialize(entity, attribute, value)
        super "#{entity} #{attribute} is required. Given value #{value}"
      end
    end
  end
end
