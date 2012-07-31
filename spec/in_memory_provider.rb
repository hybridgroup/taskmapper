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
  
  def create(object)
    id = next_id
    objects << object.merge(:id => id)
    id
  end
  
  def list(criteria)
    objects.select { |o| o == o.merge(criteria) }
      .map { |o| o.merge(:created_at => Time.now, :update_at => Time.now) }
  end
end

module TaskMapper
  module Providers
    module Inmemory
      module Projects
        include InMemoryProvider
      end
      
      module Tasks
        include InMemoryProvider
      end
    end
  end
end
