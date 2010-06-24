#!/usr/bin/env ruby

cmd = ARGV.shift || 'help'
page = File.dirname(__FILE__) + '/help/' + cmd
if File.exist?(page)
  puts File.read(page)
  puts "\nFor parameter listing and details, try executing the command with --help.\n\tticketmaster #{cmd} --help"
end

def help(options)
  
end
