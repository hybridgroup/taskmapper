module TaskMapper
  class Projects < Repository
    def initialize(attrs)
      super attrs
    end
    
    def each(&block)
      super { |attrs| yield Entities::Project.new(attrs) }
    end
    
    def create(attrs)
      self << Entities::Project.new(attrs)
    end
  end
end
