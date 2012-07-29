module TaskMapper
  module Repositories
    class Tasks < Repository
      def initialize(attrs)
        super attrs[:provider], attrs
      end
    end
  end
end
