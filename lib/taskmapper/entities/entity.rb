module TaskMapper
  module Entities
    module Entity
      attr_accessor :id, :created_at, :updated_at
      
      def initialize(attrs)
        self.id          = attrs[:id]
        self.created_at  = attrs[:created_at]
        self.updated_at  = attrs[:updated_at]
      end
      
      def satisfy(given_attrs)
        attrs = to_hash
        attrs == attrs.merge(given_attrs)
      end
    end
  end
end
