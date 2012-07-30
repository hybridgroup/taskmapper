module TaskMapper
  module Entities
    class Project
      include Entity
      
      attr_accessor :name, :description
      
      def initialize(attrs)
        self.id           = attrs[:id]
        self.name         = attrs[:name]
        self.description  = attrs[:description]
        self.created_at   = attrs[:created_at]
        self.tasks        = attrs[:tasks]
      end
      
      def name=(value)
        raise Exceptions::RequiredAttribute.new 'Project', 'name', value if value.nil? or value.empty?
        @name = value
      end
      
      def tasks
        @tasks.where :project => self
      end
      
      def to_hash
        { 
          :name => self.name,
          :description => self.description
        }
      end
            
      protected
        attr_writer :tasks
        
        def task_factory
          TaskMapper::Entities::Task
        end
    end
  end
end
