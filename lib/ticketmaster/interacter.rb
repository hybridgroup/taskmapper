module TicketMaster
  class Interacter
    attr_reader :project

    def initialize(system)
      @system = system
      @project = Project
    end
  end
end
