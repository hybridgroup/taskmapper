module TaskMapper
  module Entities
    class Project
      include Entity
      
      attr_accessor :name, :description, :factory
      
      protected :factory=
      
      def initialize(attrs)
        self.id           = attrs[:id]
        self.name         = attrs[:name]
        self.description  = attrs[:description]
        self.created_at   = attrs[:created_at]
        self.factory      = attrs[:factory]
      end
      
      def name=(value)
        raise Exceptions::RequiredAttribute.new 'Project', 'name', value if value.nil? or value.empty?
        @name = value
      end
      
      def tasks
        r = self.factory.tasks.where :project => self
      end
      
      def to_hash
        { 
          :name => self.name,
          :description => self.description
        }
      end
    end
  end
end
