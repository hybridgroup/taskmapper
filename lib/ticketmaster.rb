%w{
  rubygems
  hashie
}.each {|lib| require lib }

class TicketMaster
end

%w{
  project
  ticket
  authenticator
  provider
  exception
}.each {|lib| require File.dirname(__FILE__) + '/ticketmaster/' + lib }


# This is the TicketMaster class
#
class TicketMaster
  attr_reader :provider
  
  # This initializes the TicketMaster instance and prepares the provider
  # If called without any arguments, it conveniently tries searching for the information in
  # ~/.ticketmaster.yml
  # See the documentation for more information on the format of that file.
  #
  # What it DOES NOT do is auto-require the provider...so make sure you have the providers required.
  def initialize(system = nil, authentication = nil)
    if system.nil?
      require 'yaml'
      data = YAML.load_file File.expand_path('~/.ticketmaster.yml')
      system = data['default'] || data.first.first
      authentication = data[system] if authentication.nil?
    end
    self.extend TicketMaster::Provider.const_get(system.to_s.capitalize)
    authorize authentication
  end
  
  # Providers should over-write this method
  def authorize(authentication = {})
    raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
  end
end
