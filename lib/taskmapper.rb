require 'taskmapper/version'
require 'taskmapper/helpers'
require 'taskmapper/exceptions'
require 'taskmapper/default_provider'
require 'taskmapper/repositories'
require 'taskmapper/entities'
require 'taskmapper/client'
require 'taskmapper/factory'

module TaskMapper
  class << self
    def new(provider_name, credentials)
      session provider_name, credentials
    end
    
    def session(provider_name, credentials)
      Entities::Session.new provider_name, credentials
    end
  end
end
