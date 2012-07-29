module TaskMapper
  class Repository
    include Enumerable
      attr_reader :criteria
      
      #TODO Refactor to construct with hash
      def initialize(provider, attrs = {})
        self.provider = provider
        self.criteria = attrs[:criteria] || {}
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
      
      def [](id)
        self.provider.find id
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
      
      def where(criteria)
        self.class.new :provider => self.provider,
          :criteria => self.criteria.merge(criteria)
      end
      
      protected
        attr_accessor :provider
        
        attr_writer :criteria
  end
end
