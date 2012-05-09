module TaskMapper::Provider
  # Contains a series of helper methods
  module Helper
  
    # Current method name reflection
    # http://www.ruby-forum.com/topic/75258#895630
    # Call when raising 'implemented by the provider' exceptions
    def this_method
      caller[0][/`([^']*)'/, 1]
    end
    
    # A helper method for easy finding
    def easy_finder(api, symbol, options, at_index = 0)
      if api.is_a? Class
        return api if options.length == 0 and symbol == :first
        options.insert(at_index, symbol) if options[at_index].is_a?(Hash)
        api.find(*options)
      else
        raise TaskMapper::Exception.new("#{Helper.name}::#{this_method} method must be implemented by the provider")
      end
    end
    
    # This is a search filter that all parameters are passed through
    # Redefine this method in your classes if you need specific functionality
    def search_filter(k)
      k
    end
    
    def provider_parent(klass)
      TaskMapper::Provider.const_get(klass.to_s.split('::')[-2])
    end
    
    # Goes through all the things and returns results that match the options attributes hash
    def search_by_attribute(things, options = {}, limit = 1000)
      things.find_all do |thing|
        options.inject(true) do |memo, kv|
          break unless memo
          key, value = kv
          begin
            memo &= thing.send(key) == value
          rescue NoMethodError
            memo = false
          end
          memo
        end and (limit -= 1) > 0
      end
    end
    
    # Returns a filter-like string from a hash
    # If array_join is given, arrays are joined rather than having their own separated key:values
    # 
    # ex: filter_string({:name => 'some value', :tags => ['abc', 'def']}) = "name:'some value' tag:abc tag:def"
    def filter_string(filter = {}, array_join = nil)
        filter.inject('') do |mem, kv|
          key, value = kv
          if value.is_a?(Array)
            if !array_join.nil?
              mem += value.inject('') { |m, v|
              v = "\"#{v}\"" if v.to_s.include?(' ')
              m+= "#{key}:#{v}"
              }
              return mem
            else
              value = value.join(array_join)
            end
          end
            value = "\"#{value}\"" if value.to_s.include?(' ')
            mem += "#{key}:#{value} "
        end
    end
  end
end
