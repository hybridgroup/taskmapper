module TaskMapper
  module Repositories
    class EntityRepository < Repository
      def search(criteria = {})
        super(criteria).map { |attributes| new_entity(attributes) }
      end
      
      def create(attributes)
        self << new_entity(attributes)
      end
      
      def update(entity)
        updated = super entity
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
        super entity
        entity
      end
      
      protected
        def <<(entity)
          new_id = super(entity)
          entity.instance_eval do
            self.id = new_id
          end
          entity 
        end
        
        def new_entity(attrs)
          factory.entity(entity_class, attrs.merge(criteria))
        end
        
        def new_entity_or_nil(attrs)
          attrs ? new_entity(attrs) : nil 
        end
    end
  end
end
