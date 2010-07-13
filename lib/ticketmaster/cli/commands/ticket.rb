require 'rubygems'
# The command method call for project
# This sets the option parser and passes the parsed options to the subcommands
def ticket(options)
  ARGV << '--help' if ARGV.length == 0
  begin
    OptionParser.new do |opts|
      opts.banner = 'Usage: tm -p PROVIDER -P PROJECT [options] ticket [ticket_options]'
      opts.separator ''
      opts.separator 'Options:'
      
      opts.on('-T', '--ticket TICKET', 'Sets the working ticket') do |id|
        options[:ticket] = id
      end
      opts.on('-C', '--create ATTRIBUTES', 'Create a new ticket') do |attribute|
        options[:ticket_attributes] = {attribute => ARGV.shift}.merge(attributes_hash(ARGV))
        options[:subcommand] = 'create'
      end
      
      opts.on('-R', '--read', 'Read out ticket and its attributes. Requires --ticket to be set') do
        options[:subcommand] = 'read'
      end
      
      opts.on('-U', '--update ATTRIBUTES', 'Update ticket information. Requires --ticket to be set') do |attribute|
        options[:ticket_attributes] = {attribute => ARGV.shift}.merge(attributes_hash(ARGV))
        options[:subcommand] = 'update'
      end
      
      opts.on('-D', '--destroy', 'Destroy/Delete the ticket. Not reversible! Requires --ticket to be set') do
        options[:subcommand] = 'destroy'
      end
      
      opts.on('-I', '--info', 'Get ticket info. Same as --read. ') do
        options[:subcommand] = 'read'
      end
      
      opts.on('-S', '--search [ATTRIBUTES]', 'Search for a ticket based on attributes') do |attribute|
        options[:ticket_attributes] = attribute ? {attribute => ARGV.shift}.merge(attributes_hash(ARGV)) : {}
        options[:subcommand] = 'search'
      end
      
      opts.on('-L', '--list-all', 'List all tickets. Same as --search without any parameters') do
        options[:ticket_attributes] = {}
        options[:subcommand] = 'search'
      end
      
      opts.separator ''
      opts.separator 'Other options:'
      
      opts.on_tail('-h', '--help', 'Show this message') do
        puts opts
        exit
      end
    end.order!
  rescue OptionParser::MissingArgument => exception
    puts "tm #{options[:original_argv].join(' ')}\n\n"
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


# The create subcommand
def create(options)
  tm = TicketMaster.new(options[:provider], options[:authentication])
  ticket = tm.ticket.create(options[:ticket_attributes].merge({:project_id => options[:project].to_i}))
  read_ticket ticket
  exit
end

# The read subcommand
def read(options)
  tm = TicketMaster.new(options[:provider], options[:authentication])
  project = tm.project(options[:project].to_i)
  ticket = project.ticket(options[:ticket].to_i)
  read_ticket ticket
  exit
end

# The update subcommand
def update(options)
  tm = TicketMaster.new(options[:provider], options[:authentication])
  project = tm.project(options[:project].to_i)
  ticket = project.ticket(options[:ticket].to_i)
  if ticket.update!(options[:ticket_attributes])
    puts "Successfully updated Ticket #{ticket.title} (#{ticket.id})"
  else
    puts "Sorry, it seems there was an error when trying to update the attributes"
  end
  read_ticket ticket
  exit
end

# The destroy subcommand.
def destroy(options)
  tm = TicketMaster.new(options[:provider], options[:authentication])
  project = tm.project(options[:project].to_i)
  ticket = project.ticket(options[:ticket].to_i)
  puts "Are you sure you want to delete Ticket #{ticket.title} (#{ticket.id})? (yes/no) [no]"
  ARGV.clear
  confirm = readline.chomp.downcase
  if confirm != 'y' and confirm != 'yes'
    puts "Did not receive a 'yes' confirmation. Exiting..."
    exit
  elsif ticket.destroy
    puts "Successfully deleted Ticket #{ticket.title} (#{ticket.id})"
  else
    puts "Sorry, it seems there was an error when trying to delete the project"
  end
  exit
end

# The search and list subcommands
def search(options)
  tm = TicketMaster.new(options[:provider], options[:authentication])
  project = tm.project(options[:project].to_i)
  tickets = project.tickets(options[:ticket_attributes])
  puts "Found #{tickets.length} tickets"
  tickets.each_with_index do |ticket, index|
    puts "#{index+1}) Ticket #{ticket.title} (#{ticket.id})"
    #read_ticket ticket
    #puts
  end
  exit
end

# A utility method used to output project attributes
def read_ticket(ticket)
  ticket.system_data[:client].attributes.sort.each do |key, value|
    puts "#{key} : #{value}"
  end
end
