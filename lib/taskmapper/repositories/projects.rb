module TaskMapper
  class Projects < Repository
    attr_reader :session
    
    def initialize(attrs)
      self.session = attrs[:session]
      super attrs
    end
    
    def each(&block)
      super { |attrs| yield Entities::Project.new(attrs) }
    end
    
    def create(attrs)
      project = Entities::Project.new(attrs)
      
      project.tasks = session.tasks.where :project => project
        
      self << project
    end
    
    protected
      attr_writer :session
  end
end
