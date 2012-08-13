module TaskMapper
  module Entities
    class Project
      include Entity
      
      attr_accessor :name, :description, :factory
      
      protected :factory=
      
      def initialize(attrs)
        super attrs
        self.name         = attrs[:name]
        self.description  = attrs[:description]
        self.factory      = attrs[:factory]
        validate
      end
      
      def save
        factory.projects.update self
      end
      
      def delete
        !factory.projects.delete(self).nil?
      end
      
      def validate
        validate_presence_of :name
      end
      
      def tasks
        factory.tasks.where :project => self
      end
      
      def create_task(attrs)
        tasks.create attrs
      end
      alias :task! :create_task
      
      def to_hash
        super.merge({ 
          :name => name,
          :description => description
        })
      end
    end
  end
end
