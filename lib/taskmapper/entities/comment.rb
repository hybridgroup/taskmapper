module TaskMapper
  module Entities
    class Comment
      include HashMade
      
      attr_reader :author, :parent
      
      attr_accessor :body
      
      def initialize(attributes)
        update_attributes attributes
      end
      
      protected
        attr_writer :author, :parent
    end
  end
end
