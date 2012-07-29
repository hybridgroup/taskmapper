module TaskMapper
  class Repository
    include Enumerable
      def initialize(provider)
        self.provider = provider
      end      
      
      def each(criteria = {}, &block)
        provider.list(criteria).each &block
      end
      
      def <<(entity)
        id = provider.create entity.to_hash
        entity.tap do |p|
          p.id          = id
          p.created_at  = Time.now
          p.updated_at  = Time.now
          p.extend Entities::PersistedEntity
        end
      end
      
      def [](id)
        provider.find id
      end
      
      def []=(id, entity)
        provider.update id, entity
        entity.extend Entities::Entity
        entity.updated_at = Time.now
        entity.extend Entities::PersistedEntity
      end
      
      def delete(entity)
        provider.delete entity
        entity
      end
      
      protected
        attr_accessor :provider
  end
end
