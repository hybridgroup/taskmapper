require 'rubygems'
require 'ticketmaster'
require 'ticketmaster-lighthouse'

# display list of projects
tm = TicketMaster.new(:lighthouse)
tm.projects.each {|project|
  puts "#{project.id} - #{project.name}"
}


