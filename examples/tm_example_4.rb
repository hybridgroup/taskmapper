require 'rubygems'
require 'taskmapper'
require 'taskmapper-pivotal'
require 'taskmapper-lighthouse'

# copy all tickets and comments from pivotal tracker to new lighthouse project (the easy way)
pivotal = TaskMapper.new :pivotal
lighthouse = TaskMapper.new :lighthouse

from = pivotal.project 97107
to = lighthouse.project!(
  :name => "Copy Test on #{Time.now}",
  :description => "A copy test"
)

to.copy from

puts "Copy finished."
