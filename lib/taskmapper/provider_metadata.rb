module TaskMapper
  class Provider
    class Metadata
      attr_accessor :operations
      
      protected :operations=
      
      def initialize(factory)
        self.operations = {
          :projects => factory.projects_provider.supported_operations,
          :tasks    => factory.tasks_provider.supported_operations
        }
      end
      
      def support?(operation, entity)
        operations[entity].include? operation
      end
    end    
  end
end
