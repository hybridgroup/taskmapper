#!/usr/bin/env ruby

require 'optparse'
require 'yaml'
require File.dirname(__FILE__) + '/common.rb'


commands ={ 'help' => 'Get the help text for a particular command',
  'console' => 'Open up a taskmapper console session',
  'config' => 'Setup and configure a taskmapper.yml file',
  'ticket' => 'Work with tickets (create, edit, delete, etc)',
  'project' => 'Work with projects (create, edit, delete, etc)',
  'generate' => 'Generate skeleton library files for a new provider',
  }



helptext = lambda {
  helpmsg = "\nAvailable commands:\n"
  commands.sort.inject(helpmsg) { |mem, cmd| mem << "\t#{cmd.join("    \t")}\n" }
  helpmsg << "\nSee 'tm help COMMAND' for more information on a specific command."
  }
  
ARGV << '--help' if ARGV.length == 0

options = {:original_argv => ARGV.dup}

if File.exist?(options[:config] = File.expand_path('taskmapper.yml'))
elsif File.exist?(options[:config] = File.expand_path('config/taskmapper.yml'))
elsif ENV['TASKMAPPER_CONFIG'] and File.exist?(options[:config] = File.expand_path(ENV['TASKMAPPER_CONFIG']))
else
  options[:config] = File.expand_path('~/.taskmapper.yml')
end

begin
  OptionParser.new do |opts|
    opts.banner = 'Usage: tm [options] COMMAND [command_options]'
    opts.separator ''
    opts.separator 'Options:'
    
    opts.on('-c', '--config CONFIG', 'Use CONFIG as the configuration file. default: ~/.taskmapper.yml') do |c|
      options[:config] = c
    end
  
    opts.on('-p', '--provider PROVIDER', 'Specifies the provider') { |p| options[:provider] = p }
    
    opts.on('-A', '--authentication AUTH',
      'Specifies authentication information, comma-separated list of name:value pairs.',
      'Note: The whole list must be enclosed in quotes if there are any spaces.') do |a|
      options[:authentication] = attributes_hash(a)
    end
    
    opts.on('-P', '--project PROJECT', 'Specifies the working project') { |p| options[:project] = p }
    
    opts.separator ''
    opts.separator 'Other options:'
    
    opts.on_tail('-h', '--help', 'Show this message') do
      puts opts
      puts helptext.call
      exit
    end
  end.order!
rescue OptionParser::MissingArgument => exception
  puts "tm #{ARGV.join(' ')}\n\n"
  puts "Error: An option was called that requires an argument, but was not given one"
  puts exception.message
end

command = ARGV.shift
if commands[command]
  require File.dirname(__FILE__) + '/commands/' + command
  send(command, options)
else
  puts "'#{command}' is not a taskmapper command\n\n", helptext.call
  exit
end
