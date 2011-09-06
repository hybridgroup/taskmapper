require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ticketmaster"
    gem.summary = %Q{Ticketmaster provides a universal API to ticket tracking and project management systems.}
    gem.description = %Q{Ticketmaster provides a universal API to ticket tracking and project management systems.}
    gem.email = "info@hybridgroup.com"
    gem.homepage = "http://ticketrb.com"
    gem.authors = ["kiafaldorius", "Sirupsen", "deadprogrammer"]
    gem.add_dependency "hashie", "1.0.0"
    gem.add_dependency "activesupport", ">= 2.3.2"
    gem.add_dependency "activeresource", ">= 2.3.2"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

#task :spec => :check_dependencies

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ticketmaster #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
