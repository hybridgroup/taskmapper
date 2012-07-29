module TaskMapper
  module Exceptions
    class TaskMapperException < Exception; end
    
    class RequiredAttribute < TaskMapperException
      def initialize(attribute)
        super "Attribute '#{attribute}' is required"
      end
    end
  end
end
