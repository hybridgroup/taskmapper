module TicketMaster
  class Interacter
    attr_accessor :project, :hi

    def initialize(system)
      @project = Project.system(system)
    end
  end
end
