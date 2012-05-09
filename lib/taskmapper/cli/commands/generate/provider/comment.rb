module TaskMapper::Provider
  module Yoursystem
    # The comment class for taskmapper-yoursystem
    #
    # Do any mapping between TaskMapper and your system's comment model here
    # versions of the ticket.
    #
    class Comment < TaskMapper::Provider::Base::Comment
      #API = Yoursystem::Comment # The class to access the api's comments
      # declare needed overloaded methods here
      
    end
  end
end
