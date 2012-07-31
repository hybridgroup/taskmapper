module TaskMapper
  class Repository
    include Enumerable
    attr_accessor :criteria, :provider
    
    protected :criteria=, :provider=
    
    def initialize(provider, criteria = {})
      self.criteria = criteria
      self.provider = provider
    end      
    
    def each(criteria = {}, &block)
      self.provider.list(criteria).each &block
    end
    
    def <<(entity)
      id = self.provider.create entity.to_hash
      entity.tap do |p|
        p.id          = id
        p.created_at  = Time.now
        p.updated_at  = Time.now
        p.extend Entities::PersistedEntity
      end
    end
    
    def find_by_id(id)
      return provider.find_by_id id if provider.respond_to? :find_by_id
      provider.list.find { |e| e[:id] == id }
    end
    
    def []=(id, entity)
      self.provider.update id, entity
      entity.extend Entities::Entity
      entity.updated_at = Time.now
      entity.extend Entities::PersistedEntity
    end
    
    def delete(entity)
      self.provider.delete entity
      entity
    end
  end
end
