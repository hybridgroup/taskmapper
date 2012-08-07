module TaskMapper
  module Providers
    class Projects < EntityProvider
      def initialize(factory)
        super factory, :Projects
      end
    end
  end
end
