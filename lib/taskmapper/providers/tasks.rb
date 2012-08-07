module TaskMapper
  module Providers
    class Tasks < EntityProvider
      def initialize(factory)
        super factory, :Tasks
      end
    end
  end
end
