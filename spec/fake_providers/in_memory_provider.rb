# Fake provider implementation
# I use this instead of mocks because it is closer to real providers interaction
module InMemoryProvider
  def last_id
    @last_id ||= 0
  end
  
  def last_id=(id)
    @last_id = id
  end
  
  def next_id
    self.last_id += 1
  end
  
  def objects
    @objects ||= []
  end
  
  def <<(object)
    id = next_id
    
    objects << object.to_hash.merge(:id => id,
      :created_at => Time.now,
      :updated_at => Time.now)
    
    id
  end
  
  def delete(object)
    objects.delete_if { |o| o[:id] == object.id }
    object
  end
  
  def search(criteria = {})
    objects.select { |o| o == o.merge(criteria) }
  end
  
  def update(object)
    hash = objects.find { |o| o[:id] == object.id }
    hash.merge! object.to_hash
    true
  end
  
  def supported_operations
    [:create, :search]
  end
end

module Finders
  def find_by_id(id)
    objects.find { |o| o[:id] == id }
  end
  
  def find_by_attributes(attrs)
    objects.find { |o| o == o.merge(attrs) }
  end
end

module TaskMapper
  module Providers
    module InMemory
      module Projects
        include InMemoryProvider
        include Finders
        
        def supported_operations
          [:create, :search, :find]
        end
      end
      
      module Tasks
        include InMemoryProvider
        include Finders
        
        def supported_operations
          [:create, :search, :find]
        end
      end
      
      module TaskComments
        include InMemoryProvider
        include Finders
    
        def create(comment)
          super comment
        end
        
        def search(criteria)
          task = criteria.delete(:task)
          super criteria
        end
        
        def find_by_attributes(attrs)
          attrs.delete :task
          super attrs
        end
        
        def supported_operations
          [:create, :search]
        end
      end
    end
  end
end

module TaskMapper
  module Providers
    module WithoutFinders
      module Projects
        include InMemoryProvider
      end
      
      module Tasks
        include InMemoryProvider
      end
      
      module TaskComments
        include InMemoryProvider
      end
    end
  end
end
