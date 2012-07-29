module TaskMapper
  class Comments < Repository
    def initialize(provider = DefaultProvider.new :comments)
      super provider
    end
  end
end
