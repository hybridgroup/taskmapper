module TaskMapper
  class DefaultProvider
    def initialize(name)
      @name = name
    end
    
    def method_missing(method, *args, &block)
      def args.to_s
        empty? ? "" : "(#{map(&:class).join ','})"
      end
      
      raise NotImplementedError
        .new("Provider must implement #{@name}##{method}#{args} operation")
    end
  end
end
