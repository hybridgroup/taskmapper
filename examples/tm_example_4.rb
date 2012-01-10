require 'rubygems'
require 'ticketmaster'
require 'ticketmaster-pivotal'
require 'ticketmaster-lighthouse'

# copy all tickets and comments from pivotal tracker to new lighthouse project (the easy way)
pivotal = TicketMaster.new(:pivotal)
lighthouse = TicketMaster.new(:lighthouse)

from = pivotal.project(97107)
to = lighthouse.project!(:name => "Copy Test on #{Time.now}", 
                          :description => "A copy test")
                          
to.copy(from)

puts "Copy finished."

