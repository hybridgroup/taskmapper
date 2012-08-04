module TaskMapper
  module Repositories
    class EntityRepository < Repository
      def each(criteria = {}, &block)
        super { |attributes| yield new_entity(attributes) }
      end
      
      def create(attributes)
        self << new_entity(attributes)
      end
      
      def update(entity)
        updated = super entity.to_hash
        entity.instance_eval do
          updated_at = Time.now
        end if updated
        updated
      end
      
      def find_by_id(id)
        new_entity_or_nil super(id)
      end
      
      def find_by_attributes(attrs)
        new_entity_or_nil super(attrs)
      end
      
      def delete(entity)
        super entity.to_hash
        entity
      end
      
      protected
        def <<(entity)
          entity.id = super(entity.to_hash)
          entity.extend Entities::PersistedEntity
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
