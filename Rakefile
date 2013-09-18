require 'bundler'
require 'rspec/core/rake_task'
require 'rdoc/task'

task default: :spec

RSpec::Core::RakeTask.new :spec

Bundler::GemHelper.install_tasks

Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "taskmapper#{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
