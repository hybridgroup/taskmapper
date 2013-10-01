%w{
  rubygems
  hashie
  active_resource
}.each {|lib| require lib }

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
  version
}.each {|lib| require File.dirname(__FILE__) + '/taskmapper/' + lib }

# This is the TaskMapper class
class TaskMapper
  attr_reader :provider, :symbol
  attr_accessor :default_project

  # This initializes the TaskMapper instance and prepares the provider
  # If called without any arguments, it conveniently tries searching for the information in
  # ~/.taskmapper.yml
  # See the documentation for more information on the format of that file.
  #
  # What it DOES NOT do is auto-require the provider...so make sure you have the providers required.
  def initialize(system = nil, authentication = nil)
    if system.nil? or authentication.nil?
      require 'yaml'
      data = YAML.load_file File.expand_path(ENV['TASKMAPPER_CONFIG'] || '~/.taskmapper.yml')
      system = system.nil? ? data['default'] || data.first.first : system.to_s
      authentication = data[system]['authentication'] if authentication.nil? and data[system]['authentication']
    end
    self.extend TaskMapper::Provider.const_get(system.to_s.capitalize)
    authorize authentication
    @symbol = system.to_sym
    @provider = TaskMapper::Provider.const_get(system.to_s.capitalize)
  end

  # Providers should over-write this method
  def authorize(authentication = {})
    raise TaskMapper::Exception.new("This method must be reimplemented in the provider")
  end
end
