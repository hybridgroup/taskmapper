module TaskMapper
  module Repositories
    class Repository
      include Enumerable
      attr_accessor :factory, :criteria, :entity_class
      
      protected :factory=, :criteria=, :entity_class=
      
      def initialize(factory, entity_class, criteria = {})
        self.factory      = factory
        self.entity_class = entity_class
        self.criteria     = criteria
      end
      
      def provider
        factory.provider self.entity_class
      end     
      
      def each(criteria = {}, &block)
        provider.list(criteria).each &block
      end
      
      def update(attributes)
        provider.update attributes
      end
      
      def find(criteria = {}, &block)
        return super &block if block_given?
        case criteria
          when Fixnum then find_by_id criteria
          else find_by_attributes criteria
        end
      end
      
      def find_by_id(id)
        provider.find_by_id(id)
      end
      
      def find_by_attributes(attrs)
        provider.find_by_attributes(attrs.merge criteria)
      end
      
      def delete(attributes)
        provider.delete attributes
      end
      
      def [](index)
        to_a[index]
      end
      
      def where(criteria = {})
        self.class.new factory, self.criteria.merge(criteria)
      end
      
      # Dynamic finder
      def method_missing(method, *args, &block)
        pattern = /^find_by_/
        method_s = method.to_s
        case method_s
          when pattern
            dynamic_find method_s.sub(pattern, ''), args.first
          else super method, *args, &block
        end
      end
      
      protected
        def <<(attributes)
          provider.create(attributes)
        end
        
        def dynamic_find(attribute, value)
          criteria = {}
          criteria[attribute.to_sym] = value
          find_by_attributes criteria
        end
    end
  end
end
