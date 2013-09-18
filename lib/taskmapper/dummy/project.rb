module TaskMapper::Provider
  module Dummy
    # This is the Project class for the Dummy provider
    class Project < TaskMapper::Provider::Base::Project
      def self.find_by_id(id)
        self.new({:id => id})
      end

      def self.find_by_attributes(*options)
        [self.new(*options)]
      end

      def self.create(*attributes)
        self.new(*attributes)
      end

      # You should define @system and @system_data here.
      # The data stuff is just to initialize fake data. In a real provider, you would use the API
      # to grab the information and then initialize based on that info.
      # @system_data would hold the API's model/instance for reference
      def initialize(*options)
        data = {
          :id => rand(1000).to_i,
          :name => 'Dummy',
          :description => 'Mock!-ing Bird',
          :created_at => Time.now,
          :updated_at => Time.now
        }
        @system = :dummy
        super(data.merge(options.first || {}))
      end

      # Nothing to save so we always return true
      # ...unless it's an odd numbered second on Friday the 13th. muhaha!
      def save
        time = Time.now
        !(time.wday == 5 and time.day == 13 and time.to_i % 2 == 1)
      end

      # Nothing to update, so we always return true
      def update!(*options)
        return true
      end
    end
  end
end
