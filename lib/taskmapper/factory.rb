module TaskMapper
  class Factory
    # !@attribute [r] provider_name
    #   @return [String] 
    #
    # !@attribute [r] credentials
    #   @return [Hash] 
    #
    # !@attribute [r] providers
    #   @return [Hash]
    attr_accessor :provider_name, 
      :credentials,
      :providers
    
    protected :provider_name=, 
      :credentials=,
      :providers,
      :providers=

    # @param [String] 
    # @param [Hash]
    # @param [Hash] Optional instantiation options
    #
    # @example
    #   Factory.new "kanbanpad", {:user => '', :password => ''}
    #
    # @return [TaskMapper::Factory] instance
    def initialize(provider_name, credentials, options ={})
      self.provider_name = provider_name
      self.credentials = credentials
      self.providers = {
        Entities::Project     => Providers::Projects.new(self),
        Entities::Task        => Providers::Tasks.new(self),
        Entities::TaskComment => Providers::TaskComments.new(self) 
      }
    end
    
    # Return the TaskMapper client instance
    #
    # @return [TaskMapper::Client]
    #
    # @see [TaskMapper.new]
    def client
      TaskMapper::Client.new provider_name, credentials
    end    
    
    # Return the projects instance for a built provider
    #
    # @return [TaskMapper::Providers::Projects]
    def projects_provider
      providers[project_class]
    end

    # Return the task instance for a built provider
    #
    # @return [TaskMapper::Providers::Tasks]
    def tasks_provider
      providers[task_class]
    end
    
    # Return the comment for a task instance of a built provider
    #
    # @return [TaskMapper::Providers::TaskComment]
    def comments_provider
      providers[comment_class]
    end

    # Return any entity from the built provider
    #
    # @param [Entity] class constant 
    #
    # @return [TaskMapper::Providers::EntityProvider]
    def provider(entity_class)
      providers[entity_class]
    end
    
    # @return [TaskMapper::Providers::Entities::Task]
    def task_class
      Entities::Task
    end
    
    # @return [TaskMapper::Providers::Entities::Project]
    def project_class
      Entities::Project
    end
    
    # @return [TaskMapper::Providers::Entities::TaskComment]
    def comment_class
      Entities::TaskComment
    end
    
    # Builder for any entity
    #
    # @param [TaskMapper::Entities::Entity]
    def entity(entity_class, attrs)
      entity_class.new attrs.merge(:factory => self)
    end
    
    # Return the session instance for the provider
    #
    # @return [TaskMapper::Providers:Session]
    def session
      Providers::Session.new self
    end
    
    def projects
      Projects.new self
    end
    
    # Return a instance of a task repository for the provider
    #
    # @param [Hash] criteria for searching inside tasks repository 
    #
    # @example 
    #   Factory.new(...).tasks
    #   #=> <TaskMapper::Repositories::Tasks>
    #
    # @return [TaskMapper::Repositories::Tasks] instance
    def tasks(criteria = {})
      Repositories::Tasks.new self, criteria
    end
    
    # Return a instance of a task comments repository for the provider
    #
    # @param [Hash] criteria for searching inside the tasks comment repositories
    #
    # @example
    #   Factory.new(...).task_comments
    #   #=> <TaskMapper::Repositories::TaskComments>
    #
    # @return [TaskMapper::Repositories::TaskComments] instance
    def task_comments(criteria = {})
      Repositories::TaskComments.new self, criteria
    end
    
    # Return the provider meta data instance
    #
    # @return [TaskMapper::Providers::Metadata]
    def provider_metadata
      Providers::Metadata.new self
    end
    
    def providers_module
      TaskMapper::Providers
    end
    
    def exceptions_module
      TaskMapper::Exceptions
    end
    
    def provider_module
      @provider_module ||= get_provider_module
    end
    
    def entity_module(entity_name)
      entity_modules[entity_name] ||= get_entity_module(entity_name)
    end
    
    def entity_modules
      @entity_modules ||= {}
    end
    
    protected
      def get_entity_module(entity_name)
        get_provider_module.const_get(entity_name)
      end
      
      def get_provider_module
        unless get_provider_module_name
          raise exceptions_module::ProviderNotFound
            .new(nice_provider_name) 
        end      
        providers_module.const_get get_provider_module_name
      end
      
      def get_provider_module_name
        providers_module.constants
          .find { |c| c.to_s.downcase == nice_provider_name }
      end
      
      def nice_provider_name
        provider_name.to_s
          .gsub /\_/, ''
          .capitalize
          .downcase
      end
  end
end
