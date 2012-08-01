module TaskMapper
  class Projects < Repositories::Repository
    def initialize(factory)
      super factory, factory.project_class
    end
  end
end
