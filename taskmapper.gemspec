# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "taskmapper/version"

Gem::Specification.new do |s|
  s.name        = "taskmapper"
  s.version     = Taskmapper::VERSION
  s.authors     = ["Omar Rodriguez"]
  s.email       = ["omarjavier15@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{ Taskmapper is a Gem which eases communication with various project and ticket management systems by providing a consistent Ruby API. }
  s.description = %q{ Taskmapper let's you "remap" a system into the consistent Taskmapper API, easily. For instance the description of an issue/ticket, might be named description in one system, and problem-description somewhere else. Via Taskmapper, this would always be called description. The Taskmapper remaps makes it easy for you to integrate different kinds of ticket systems, into your own system. You don't have to take care of all the different kinds of systems, and their different APIs. Taskmapper handles all this for you, so you can focus on making your application awesome. }

  s.rubyforge_project = "taskmapper"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-bundler"
  s.add_development_dependency "rubygems-bundler"
  s.add_development_dependency "libnotify"
end
