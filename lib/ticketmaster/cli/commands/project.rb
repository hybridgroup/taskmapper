require 'rubygems'
# The command method call for project
# This sets the option parser and passes the parsed options to the subcommands
def project(options)
  ARGV << '--help' if ARGV.length == 0
  begin
    OptionParser.new do |opts|
      opts.banner = 'Usage: ticket -p PROVIDER [options] project [project_options]'
      opts.separator ''
      opts.separator 'Options:'
      
      opts.on('-C', '--create ATTRIBUTES', 'Create a new project') do |attributes|
        options[:project_attributes] = attributes_hash(attributes)
        options[:subcommand] = 'create'
      end
      
      opts.on('-R', '--read [PROJECT]', 'Read out project and its attributes') do |id|
        options[:project] = id if id
        options[:subcommand] = 'read'
      end
      
      opts.on('-U', '--update ATTRIBUTES', 'Update project information. Takes a comma-separated list of key:value pairs.',
        'Enclose the list in quotes if any keys or values have a space.') do |attributes|
        options[:project_attributes] = attributes_hash(attributes)
        options[:subcommand] = 'update'
      end
      
      opts.on('-D', '--destroy [PROJECT]', 'Destroy the project') do |id|
        options[:project] = id if id
        options[:subcommand] = 'destroy'
      end
      
      opts.on('-I', '--info [PROJECT_ID]', 'Get project info. Same as --read. ') do |id|
        options[:project] = id if id
        options[:subcommand] = 'read'
      end
      
      opts.on('-S', '--search [ATTRIBUTES]', 'Search for a project based on attributes given as a comma-separated list of key:value pairs.',
        'Enclose the whole listi n quotes if any keys or values have a space.') do |attributes|
        options[:project_attributes] = attributes_hash(attributes)
        options[:subcommand] = 'search'
      end
      
      opts.separator ''
      opts.separator 'Other options:'
      
      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
        exit
      end
    end.parse(ARGV)
  rescue OptionParser::MissingArgument => exception
    puts "ticket #{options[:original_argv].join(' ')}\n\n"
    puts "Error: An option was called that requires an argument, but was not given one"
    puts exception.message
  end
  parse_config!(options)
  begin
    require 'ticketmaster'
    require "ticketmaster-#{options[:provider]}"
  rescue
    require options[:provider]
  end
  send(options[:subcommand], options)
end



def create(options)
  tm = TicketMaster.new(options[:provider], options[:authentication])
  project = tm.project.create(options[:project_attributes])
  read_project project
  exit
end

def read(options)
  tm = TicketMaster.new(options[:provider], options[:authentication])
  project = tm.project.find(options[:project].to_i)
  read_project project
  exit
end

def update(options)
  tm = TicketMaster.new(options[:provider], options[:authentication])
  project = tm.project.find(options[:project].to_i)
  if project.update(options[:project_attributes])
    puts "Successfully updated Project #{project.name} (#{project.id})"
  else
    puts "Sorry, it seems there was an error when trying to update the attributes"
  end
  read_project project
  exit
end

def destroy(options)
  tm = TicketMaster.new(options[:provider], options[:authentication])
  project = tm.project.find(options[:project].to_i)
  puts "Are you sure you want to delete Project #{project.name} (#{project.id})? (yes/no) [no]"
  ARGV.clear
  confirm = readline.chomp.downcase
  if confirm != 'y' and confirm != 'yes'
    puts "Did not receive a 'yes' confirmation. Exiting..."
    exit
  elsif project.destroy
    puts "Successfully deleted Project #{project.name} (#{project.id})"
  else
    puts "Sorry, it seems there was an error when trying to delete the project"
  end
  exit
end

def search(options)
  tm = TicketMaster.new(options[:provider], options[:authentication])
  projects = tm.projects(options[:project_attributes])
  puts "Found #{projects.length} projects"
  projects.each_with_index do |project, index|
    puts "#{index+1}) Project #{project.name} (#{project.id})"
    read_project project
    puts
  end
  exit
end

# A utility method used to output project attributes
def read_project(project)
  project.system_data[:client].attributes.sort.each do |key, value|
    puts "#{key} : #{value}"
  end
end
