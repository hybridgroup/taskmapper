module TicketMaster
  module Github
    def self.included(model)
      model.class_eval do
        extend model::ClassMethods
        include model::InstanceMethods
      end
    end

    module ClassMethods
    end

    module InstanceMethods
      def hai
        "Hai from Github!"
      end
    end
  end
end
