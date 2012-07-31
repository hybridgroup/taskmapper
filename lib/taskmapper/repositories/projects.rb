module TaskMapper
  class Projects < Repositories::EntityRepository
    def initialize(factory)
      super factory, factory.project_class
    end

    def delete(project)
      super project
    end
  end
end
