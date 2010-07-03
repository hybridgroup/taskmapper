module TicketMaster::Provider
  # Common module
  # contains method definitions common to all or most of the models
  module Common
      module ClassMethods
        # Create a something.
        # Basically, a .new and .save in the same call. The default method assumes it is passed a
        # single hash with attribute information
        def create(*options)
          if self::API.is_a? Class
            something = self::API.new(*options)
            something.save
            self.new something
          else
            raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
          end
        end
      end
      
      # Automatic extension of class methods on include
      def self.included(base)
        base.extend ClassMethods
      end
      
      # The initializer
      # It tries to do a default system for ActiveResource-based api providers
      def initialize(*options)
        @system_data ||= {}
        @cache ||= {}
        first = options.shift
        case first
          when ActiveResource::Base
            @system_data[:client] = first
            self.prefix_options ||= @system_data[:client].prefix_options if @system_data[:client].prefix_options
            super(first.attributes)
          
          when Hash
            super(first.to_hash)
        end
      end
      
      # Update the something and save
      # As opposed to update which just updates the attributes
      def update!(*options)
        update(*options)
        save
      end
      
      # Save changes to this project
      # Returns true (success) or false (failure) or nil (no changes)
      def save
        if @system_data and (something = @system_data[:client]) and something.respond_to?(:attributes)
          changes = 0
          something.attributes.each do |k, v|
            if self.send(k) != v
              something.send(k + '=', self.send(k)) 
              changes += 1
            end
          end
          something.save if changes > 0
        else
          raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
        end
      end
      
      # Delete this project
      # Returns true (success) or false(failure)
      def destroy
        if @system_data and @system_data[:client] and @system_data[:client].respond_to?(:destroy)
          return @system_data[:client].destroy
        else
          raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
        end
      end
      
      def respond_to?(symbol)
        result = super(symbol)
        return true if result or @system_data.nil? or @system_data[:client].nil?
        @system_data[:client].respond_to?(symbol)
      end
  end
end
