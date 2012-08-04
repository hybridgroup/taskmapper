module TaskMapper
  class Projects < Repositories::EntityRepository
    def initialize(factory)
      super factory, factory.project_class
    end
  end
end
