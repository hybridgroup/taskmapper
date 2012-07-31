module TaskMapper
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
        yield factory.entity(entity_class, attributes)
      end
    end
    
    def create(attributes)
      self << factory.entity(entity_class, attributes)
    end
    
    def find_by_id(id)
      attributes= if provider.respond_to?(:find_by_id)
        provider.find_by_id id
      else
        all = provider.list 
        all.find { |e| e[:id] == id }        
      end
      factory.entity entity_class, attributes
    end
    
    def where(criteria = {})
      self.class.new factory, self.criteria.merge(criteria)
    end
    
    def delete(entity)
      self.provider.delete entity
      entity
    end
    
    protected
      def <<(entity)
        id = self.provider.create entity
        entity.tap do |p|
          p.id          = id
          p.created_at  = Time.now
          p.updated_at  = Time.now
          p.extend Entities::PersistedEntity
        end
      end
  end
end
