module TaskMapper
  class Projects < Repository
    def initialize(factory)
      super factory, factory.project_class
    end
  end
end
