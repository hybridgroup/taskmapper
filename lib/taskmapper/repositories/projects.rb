module TaskMapper
  class Projects < Repository
    attr_accessor :factory
    
    protected :factory
    
    def initialize(factory)
      super factory, factory.project_class
    end
  end
end
