module TaskMapper
  module Entities
    module Entity
      attr_accessor :id, :created_at, :updated_at
      
      def satisfy(given_attrs)
        attrs = to_hash
        attrs == attrs.merge(given_attrs)
      end
    end
  end
end
