module TaskMapper
  module Entities
    module PersistedEntity
      protected
        attr_writer :id, :created_at, :updated_at
    end
  end
end
