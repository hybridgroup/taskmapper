module TaskMapper
  module Entities
    module Entity
      attr_accessor :id, :created_at, :updated_at
      
      def initialize(attrs)
        self.id          = attrs[:id]
        self.created_at  = attrs[:created_at] || Time.now
        self.updated_at  = attrs[:updated_at] || Time.now
      end
      
      def satisfy(given_attrs)
        attrs = to_hash
        attrs == attrs.merge(given_attrs)
      end
      
      def validate_presence_of(attribute)
        value = self.__send__ attribute
        if value.nil? or value.empty?
          raise Exceptions::RequiredAttribute.new(self.class, attribute, value) 
        end
      end
      
      def update_attributes(attrs)
        id = attrs[:id]
        created_at = attrs[:created_at]
        updated_at = attrs[:updated_att]
      end
      
      def to_hash
        {
          :id         => id,
          :created_at => created_at,
          :updated_at => updated_at
        }
      end
    end
  end
end
