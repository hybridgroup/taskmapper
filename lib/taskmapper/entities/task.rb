module TaskMapper
  module Entities
    class Task
      include HashMade
      
      attr_accessor :status, 
        :priority, 
        :description, 
        :assignee, 
        :closed,
        :resolution
        
      attr_reader :title, :requestor, :project, :comments
      
      def initialize(attributes)
        update_attributes defaults.merge(attributes)
      end
      
      def title=(value)
        raise Exceptions::RequiredAttribute.new :title if value.nil? or value.empty?
        @title = value
      end
      
      def requestor=(value)
        raise Exceptions::RequiredAttribute.new :requestor if value.nil? or value.empty?
        @requestor = value
      end
      
      protected
        attr_writer :comments, :project
        
        def defaults
          {
            :status => :new,
            :priority => 1
          }
        end
    end
  end
end
