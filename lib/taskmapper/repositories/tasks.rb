module TaskMapper
  module Repositories
    class Tasks < Repository
      def initialize(attrs)
        super attrs[:provider]
      end
    end
  end
end
