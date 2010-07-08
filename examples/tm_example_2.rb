require 'rubygems'
require 'ticketmaster'
require 'ticketmaster-pivotal'

# display list of tickets for last project
tm = TicketMaster.new(:pivotal)
project = tm.projects.last
project.tickets.each {|ticket|
  puts "#{ticket.id} - #{ticket.title}"
}

