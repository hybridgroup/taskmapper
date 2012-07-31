module TaskMapper
  class Projects < Repository
    attr_accessor :factory
    
    protected :factory
    
    def initialize(factory)
      self.factory = factory
      super factory.projects_provider
    end
    
    def each(&block)
      super { |attrs| yield factory.project(attrs) }
    end
    
    def create(attrs)
      self << factory.project(attrs)
    end
    
    def find_by_id(id)
      factory.project(super id)
    end
  end
end
