module TaskMapper
  class Tasks < Repository
    def initialize(provider = DefaultProvider.new(:tasks))
      super provider
    end
  end
end
