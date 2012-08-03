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
        self.provider.list(criteria).each do |attributes|
          yield new_entity(attributes)
        end
      end
      
      def create(attributes)
        self << new_entity(attributes)
      end

      def find(criteria = {}, &block)
        return super &block if block_given?
        case criteria
          when Fixnum then find_by_id criteria
          else find_by_attributes criteria
        end
      end    
          
      def find_by_id(id)
        return find { |entity| entity.id == id } unless provider.respond_to?(:find_by_id)
        new_entity_or_nil provider.find_by_id(id)
      end
      
      def find_by_attributes(attrs)
        return find { |entity| entity.satisfy(attrs) } unless provider.respond_to?(:find_by_attributes)
        new_entity_or_nil provider.find_by_attributes(attrs.merge criteria)
      end
      
      def where(criteria = {})
        self.class.new factory, self.criteria.merge(criteria)
      end
      
      def delete(entity)
        self.provider.delete entity
        entity
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
        def <<(entity)
          id = self.provider.create entity.to_hash
          entity.tap do |p|
            p.id          = id
            p.created_at  = Time.now
            p.updated_at  = Time.now
            p.extend Entities::PersistedEntity
          end
        end
        
        def dynamic_find(attribute, value)
          criteria = {}
          criteria[attribute.to_sym] = value
          find_by_attributes criteria
        end
        
        def new_entity(attrs)
          factory.entity(entity_class, attrs)
        end
        
        def new_entity_or_nil(attrs)
          attrs ? new_entity(attrs) : nil 
        end
    end
  end
end
