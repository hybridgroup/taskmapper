# The help command.
def help(options)
  cmd = ARGV.shift || 'help'
  page = File.dirname(__FILE__) + '/help/' + cmd
  if File.exist?(page)
    puts File.read(page)
    puts "\nFor parameter listing and details, try executing the command with --help.\n\ttm #{cmd} --help"
  end  
end
