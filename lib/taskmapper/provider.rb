# This is the TaskMapper::Provider Module
#
# All provider classes will extend into this module.
# See the Dummy provider's code for some specifics on implementing a provider
#
# Currently, only Projects and Tickets are standardized in ticket master. Therefore,
# if your provider has other types--such as People/Members, Messages, Milestones, Notes,
# Tags, etc--you may implement it at your discretion. We are planning to eventually
# incorporate and standardize many of these into the overall provider. Keep on the look out for it!
#
# We are also planning on standardizing non-standard/provider-specific object models
module TaskMapper::Provider
  module Base
    PROJECT_API = nil # The Class for the project api interaction
    TICKET_API = nil # The Class for the ticket api interaction

    include TaskMapper::Provider::Helper

    # All providers must define this method.
    # It doesn't *have* to do anything, it just has to be there. But since it's here, you don't
    # have to worry about it as long as you "include TaskMapper::Provider::Base"
    #
    # If you need to do some additional things to initialize the instance, here is where you would put it
    def authorize(authentication = {})
      @authentication = TaskMapper::Authenticator.new(authentication)
    end

    # All providers must define this method.
    # It should implement the code for validating the authentication
    def valid?
      raise TaskMapper::Exception.new("#{Base.name}::#{this_method} method must be implemented by the provider")
    end

    # Providers should try to define this method
    #
    # It returns the project class for this provider, so that there can be calls such as
    #    taskmapper.project.find :all
    #    taskmapper.project(:id => 777, :name => 'Proj test')
    #
    # Should try to implement a find :first (or find with singular result) if given parameters
    def project(*options)
      easy_finder(@provider::Project, :first, options)
    end

    # All providers should try to define this method.
    #
    # It returns all projects in an array
    # Should try to implement a find :all if given parameters
    def projects(*options)
      easy_finder(@provider::Project, :all, options)
    end

    # Create a project same as project.create()
    def project!(*options)
      project.create(*options)
    end

    # Providers should try to define this method
    #
    # It returns the ticket class for this provider, so that there can be calls such as
    #    taskmapper.ticket.find :all
    #    taskmapper.ticket(:id => 102, :title => 'Ticket')
    #
    # Don't confuse this with project.ticket.find(...) since that deals with tickets specific to a
    # project. This is deals with tickets
    #
    # Should try to implement a find :first (or find with singular result) if given parameters
    def ticket(*options)
      easy_finder(@provider::Ticket, :first, options)
    end

    # All providers should try to define this method
    #
    # It returns all tickets in an array.
    # Should try to implement a find :all if given parameters
    def tickets(*options)
      easy_finder(@provider::Ticket, :all, options)
    end
  end
end
