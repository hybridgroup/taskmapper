require 'taskmapper/version'
require 'taskmapper/exceptions'
require 'taskmapper/repositories'
require 'taskmapper/entities'
require 'taskmapper/client'
require 'taskmapper/provider_metadata'
require 'taskmapper/factory'

module TaskMapper
  def self.new(provider_name, credentials = {})
    factory = TaskMapper::Factory.new(provider_name, credentials)
    factory.client
  end
  
  module Providers
  end
end
