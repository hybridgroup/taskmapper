module TicketMaster
  module Plugins
    def plugins
      @plugins ||= []
    end

    def plugin(plugin)
      extend plugin::ClassMethods if plugin.const_defined(:ClassMethods)
      include plugin::ClassMethods if plugin.const_defined(:Include)

      plugin.configure(self) if plugin.respond_to?(:configure)
      plugins << mod
    end

    autoload :Lighthouse, 'ticketmaster/plugins/lighthouse'
  end
end
