require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "taskmapper/version"
require "yard"

RSpec::Core::RakeTask.new :spec

YARD::Rake::YardocTask.new do |t|
  t.options += ['--title', "TaskMapper #{Taskmapper::VERSION} Documentation"]
end

task :default => :spec

