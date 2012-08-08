require 'taskmapper/version'
require 'taskmapper/exceptions'
require 'taskmapper/repositories'
require 'taskmapper/entities'
require 'taskmapper/client'
require 'taskmapper/providers'
require 'taskmapper/factory'

module TaskMapper
  # Public: Overloaded constructor
  #
  # provider_name - String name of the provider you want to create
  # credentials - Hash for the provider credentials
  #
  # Examples
  #
  # TaskMapper.new :in_memory, 
  #                :user => 'username' 
  #                :password => 'password'
  #
  # Returns a client instance 
  def self.new(provider_name, credentials = {})
    TaskMapper::Factory.new(provider_name, credentials).client
  end
end
