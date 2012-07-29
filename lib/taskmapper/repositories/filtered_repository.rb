module TaskMapper
  class FilteredRepository < Repository
    attr_reader :filter
    
    def initialize(attrs)
      super attrs[:provider]
      self.filter = attrs[:filter]
    end
    
    def each(criteria = {}, &block)
      super criteria.merge filter
    end
    
    protected
      attr_writer :filter
  end
end
