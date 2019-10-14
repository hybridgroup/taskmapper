# -*- encoding: utf-8 -*-
require File.expand_path '../lib/taskmapper/version', __FILE__

Gem::Specification.new do |spec|
  spec.name          = "taskmapper"
  spec.version       = TaskMapper::VERSION
  spec.authors       = ["www.hybridgroup.com"]
  spec.email         = ["info@hybridgroup.com"]
  spec.description   = %q{TaskMapper provides a universal API to ticket tracking
                          and project management systems.}
  spec.summary   = %q{TaskMapper provides a universal API to ticket tracking
                          and project management systems.}
  spec.homepage      = "http://ticketrb.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activeresource", "~> 3.2"
  spec.add_dependency "activesupport", ">= 3.2", "< 7.0"
  spec.add_dependency "hashie", "~> 2.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rdoc", "~> 4.0"
  spec.add_development_dependency "rspec", "~> 2.14.1"
end
