require 'taskmapper/version'
require 'taskmapper/exceptions'
require 'taskmapper/repositories'
require 'taskmapper/entities'
require 'taskmapper/client'
require 'taskmapper/providers'
require 'taskmapper/factory'

module TaskMapper
  # @param [String] the provider you want to create
  # @param [Hash] the provider credentials
  #
  # @example
  #   TaskMapper.new :in_memory, :user => 'username' :password => 'password' #=> <TaskMapper
  #
  # @return [Client] 
  def self.new(provider_name, credentials = {})
    TaskMapper::Factory.new(provider_name, credentials).client
  end
end
