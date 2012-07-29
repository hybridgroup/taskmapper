module TaskMapper
  module Factories
    module Session
      def self.new(attributes)
        provider = Factories::Provider.create(:name => attributes[:provider_name])
        
        session = Entities::Session.new :provider => provider,
          :credentials => attributes[:credentials]
      end
    end
    
    module Provider
      def self.create(attributes)
        Entities::Provider.new attributes
      end
    end
  end
end
