module TicketMaster
  class Interacter
    attr_reader :project

    def initialize(system)
      @project = Project.system(system)
    end
  end
end
