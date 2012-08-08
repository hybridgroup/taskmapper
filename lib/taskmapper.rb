require 'taskmapper/version'
require 'taskmapper/exceptions'
require 'taskmapper/repositories'
require 'taskmapper/entities'
require 'taskmapper/client'
require 'taskmapper/providers'
require 'taskmapper/factory'

module TaskMapper
  def self.new(provider_name, credentials = {})
    TaskMapper::Factory.new(provider_name, credentials).client
  end
end
