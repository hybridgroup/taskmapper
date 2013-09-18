module TaskMapper::Provider
  module Tester
    # This is the Project class for the Tester provider
    class Project < TaskMapper::Provider::Base::Project
      # You should define @system and @system_data here.
      # The data stuff is just to initialize fake data. In a real provider, you would use the API
      # to grab the information and then initialize based on that info.
      # @system_data would hold the API's model/instance for reference
      def initialize(*options)
        data = {
          :id => rand(1000).to_i,
          :name => 'Tester',
          :description => 'Mock!-ing Bird',
          :created_at => Time.now,
          :updated_at => Time.now
        }
        @system = :tester
        super(data.merge(options.first || {}))
      end
    end
  end
end
