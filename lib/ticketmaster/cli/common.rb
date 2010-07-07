# Parses the configuration information and puts it into options
def parse_config!(options)
  config = YAML.load_file File.expand_path(options[:config])
  provider = (options[:provider] ||= config['default'] || config.first.first)
  if provider and provider.length > 0
    options[:project] ||= config[provider]['project']
    options[:authentication] ||= config[provider]['authentication']
  end
  options
end

# A utility method used to separate name:value pairs
def attributes_hash(kvlist)
  require 'enumerator' if RUBY_VERSION < "1.8.7"
  if kvlist.is_a?(String)
    kvlist.split(',').inject({}) do |mem, kv|
      key, value = kv.split(':')
      mem[key] = value
      mem
    end
  elsif kvlist.is_a?(Array)
    mem = {}
    kvlist.each_slice(2) do |k, v|
      mem[k] = v
    end
    mem
  end
end
