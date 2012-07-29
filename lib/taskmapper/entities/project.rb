module TaskMapper
  module Entities
    class Project
      include Entity
      
      attr_reader :tasks
      
      attr_accessor :name, :description, :session
      
      def initialize(attrs)
        self.id           = attrs[:id]
        self.name         = attrs[:name]
        self.description  = attrs[:description]
        self.created_at   = attrs[:created_at]
        self.session      = attrs[:session]
        self.tasks        = attrs[:tasks]
      end
      
      def name=(value)
        raise Exceptions::RequiredAttribute.new 'Project', 'name', value if value.nil? or value.empty?
        @name = value
      end
      
      def task!(attrs)
        self.tasks << task_factory.new(attrs.merge :project => self)
      end
      
      def to_hash
        { 
          :name => self.name,
          :description => self.description
        }
      end
            
      protected
        attr_writer :session, :tasks
        
        def task_factory
          TaskMapper::Entities::Task
        end
    end
  end
end
