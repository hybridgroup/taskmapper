module TicketMaster::Provider
  # Contains a series of helper methods
  module Helper
  
    # A helper method for easy finding
    def easy_finder(api, symbol, options, at_index = 0)
      if api.is_a? Class
        return api if options.length == 0 and symbol == :first
        options.insert(at_index, symbol) if options[at_index].is_a?(Hash)
        api.find(*options)
      else
        raise TicketMaster::Exception.new("This method must be reimplemented in the provider")
      end
    end
    
    # This is a search filter that all parameters are passed through
    # Redefine this method in your classes if you need specific functionality
    def search_filter(k)
      k
    end
    
    # Goes through all the things and returns results that match the options attributes hash
    def search_by_attribute(things, options = {}, limit = 1000)
      things.find_all do |thing|
        options.reduce(true) do |memo, kv|
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
        filter.reduce('') do |mem, kv|
          key, value = kv
          if value.is_a?(Array)
            if !array_join.nil?
              mem += value.reduce('') { |m, v|
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
