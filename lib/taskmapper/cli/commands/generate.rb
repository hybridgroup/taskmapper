# The generate command
def generate(options)
  if ARGV.length == 0
    ARGV << '--help'
  else
    provider_name = ARGV.shift
    if provider_name.start_with? '_'
      options[:provider] = provider_name[1..-1]
      options[:provider_dir] = options[:provider]
    else
      options[:provider] = provider_name
      options[:provider_dir] = 'ticketmaster-' + options[:provider]
    end
  end
  options[:mkdir] = true
  begin
    OptionParser.new do |opts|
      opts.banner = 'Usage: tm generate PROVIDER_NAME [--lib-directory DIR] [--jeweler [jeweler_options]]'
      opts.separator ''
      opts.separator 'Options:'
      
      opts.on('-J', '--jeweler [JEWELER_OPTIONS]', 'Sets the working ticket') do |option|
        options[:jeweler] = ARGV
        options[:mkdir] = false
      end
      
      opts.on('-L', '--lib-directory DIR', 'Put the skeleton files inside this directory', ' * This assumes the directory already exists') do |dir|
        options[:lib] = dir
        options[:mkdir] = false
      end
      
      opts.separator ''
      opts.separator 'Other options:'
      
      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
        exit
      end
      opts.separator ''
      opts.separator 'NOTE: ticketmaster- will be prepended to your provider name'
      opts.separator 'unless you set the first character as _ (it will be removed)'
    end.order!
  rescue OptionParser::MissingArgument => exception
    puts "tm #{options[:original_argv].join(' ')}\n\n"
    puts "Error: An option was called that requires an argument, but was not given one"
    puts exception.message
  rescue OptionParser::InvalidOption => exception
    options[:jeweler] = exception.recover(ARGV)
    options[:mkdir] = false
  end
  options[:lib] ||= options[:provider_dir] + '/lib/'
  create_directories(options)
  copy_skeleton(options)
end

# Copy over the skeleton files
def copy_skeleton(options)
  skeleton_path = File.dirname(__FILE__) + '/generate/'
  provider = File.read(skeleton_path + 'provider.rb').gsub('yoursystem', options[:provider].downcase)
  create_file(options, options[:provider_dir] + '.rb', provider)
  skeleton_path << 'provider/'
  provider = File.read(skeleton_path + 'provider.rb').gsub('Yoursystem', options[:provider].capitalize).gsub('yoursystem', options[:provider].downcase)
  create_file(options, 'provider/' + options[:provider].downcase + '.rb', provider)
  %w(project.rb ticket.rb comment.rb).each do |p|
    provider = File.read(skeleton_path + p).gsub('Yoursystem', options[:provider].capitalize).gsub('yoursystem', options[:provider].downcase)
    create_file(options, 'provider/' + p, provider)
  end
end

# Create the directories so copy_skeleton can do its job
def create_directories(options)
  if options[:jeweler]
    jeweler_options = options[:jeweler].inject('') do |mem, j|
      j="'#{j}'" if j.include?(' ')
      mem + j + ' '
    end
    puts "Running jeweler #{jeweler_options} #{options[:provider_dir]}"
    puts `jeweler #{jeweler_options} #{options[:provider_dir]}`
  elsif options[:mkdir]
    begin 
      Dir.mkdir(options[:provider_dir])
      puts "\tcreate\t#{options[:provider_dir]}"
    rescue Exception => e
      puts "\t#{e.message}"
    end
    begin
      Dir.mkdir(options[:lib])
      puts "\tcreate\t#{options[:lib]}"
    rescue Exception => e
      puts "\t#{e.message}"
    end
  end
  begin
    Dir.mkdir(options[:lib] + '/provider')
    puts "\tcreate\t#{options[:lib] + 'provider'}"
  rescue Exception => e
    puts "\t#{e.message}"
  end
end

# Create files
def create_file(options, filename, data)
  file_path = options[:lib] + '/' + filename
  if File.exist?(file_path) and File.size(file_path) > 0
    puts "\texists with content...skipping\t#{filename}"
    return false;
  end
  puts "\tcreate\t#{filename}"
  f = File.open(file_path, 'a+')
  f.write data
  f.close
end
