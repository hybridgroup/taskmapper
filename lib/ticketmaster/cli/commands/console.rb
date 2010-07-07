# the console command
def console(options)
  send(:open_irb, options, ARGV)
end

# the actual method to do the irb opening
def open_irb(options, argv)
  tm_lib   = File.dirname(__FILE__) + '/../../../ticketmaster.rb'
  irb_name = RUBY_PLATFORM =~ /mswin32/ ? 'irb.bat' : 'irb'  
  requires = "-r rubygems -r #{tm_lib} "
  cmd = ''
  if File.exist?(config = File.expand_path(options[:config]))
    ENV['TICKETMASTER_CONFIG']=config
  end
  providers = !options[:provider].nil? ? [options[:provider]] : YAML.load_file(config).keys
  providers.delete 'default'
  require 'rubygems'
  require 'ticketmaster'
  providers.inject(requires) do |mem, p|
    begin
      require "ticketmaster-#{p}"
      requires << "-r ticketmaster-#{p} "
    rescue LoadError => exception
      puts exception
      require "#{p}"
      requires << "-r #{p} "
    end
  end
  cmd << "#{irb_name} #{requires} --simple-prompt #{ARGV.join(' ')}"
  exec cmd
end
