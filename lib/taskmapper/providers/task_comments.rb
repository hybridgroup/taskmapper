module TaskMapper
  module Providers
    class TaskComments < EntityProvider
      def initialize(factory)
        super factory, :TaskComments
      end
    end
  end
end
