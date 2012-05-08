class TicketMaster::Exception < Exception
end

class TicketMaster  
  module Exceptions
    class NotSupported < TicketMaster::Exception
      def initialize(operation, entity)
        super "Operation '#{operation} #{entity}' not supported by this provider"
      end
    end
  end
end
