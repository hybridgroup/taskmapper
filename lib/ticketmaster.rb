%w{
  rubygems
  hashie
  active_resource
}.each {|lib| require lib }

class TicketMaster
end

%w{
  common
  helper
  project
  ticket
  comment
  authenticator
  provider
  exception
  dummy/dummy.rb
  tester/tester.rb
}.each {|lib| require File.dirname(__FILE__) + '/ticketmaster/' + lib }


# This is the TicketMaster class
#
class TicketMaster
  attr_reader :provider, :symbol
  attr_accessor :default_project
  
  # This initializes the TicketMaster instance and prepares the provider
  # If called without any arguments, it conveniently tries searching for the information in
  # ~/.ticketmaster.yml
  # See the documentation for more information on the format of that file.
  #
  # What it DOES NOT do is auto-require the provider...so make sure you have the providers required.
  def initialize(system = nil, authentication = nil)
    if system.nil? or authentication.nil?
      require 'yaml'
      data = YAML.load_file File.expand_path(ENV['TICKETMASTER_CONFIG'] || '~/.ticketmaster.yml')
      system = system.nil? ? data['default'] || data.first.first : system.to_s
      authentication = data[system]['authentication'] if authentication.nil? and data[system]['authentication']
    end
    self.extend TicketMaster::Provider.const_get(system.to_s.capitalize)
    authorize authentication
    @symbol = system.to_sym
    @provider = TicketMaster::Provider.const_get(system.to_s.capitalize)
  end
  
  # Providers should over-write this method
  def authorize(authentication = {})
    raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
  end
end
