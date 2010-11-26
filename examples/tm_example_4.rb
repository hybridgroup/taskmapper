require 'rubygems'
require 'ticketmaster'
require 'ticketmaster-pivotal'
require 'ticketmaster-lighthouse'

# copy all tickets and comments from pivotal tracker to new lighthouse project (the easy way)
pivotal = TicketMaster.new(:pivotal)
pivotal_project = pivotal.project(97107)
lighthouse = TicketMaster.new(:lighthouse)

lighthouse_project = lighthouse.project!(:name => "Copy Test on #{Time.now}", 
                                         :description => "A copy test")
lighthouse_project.copy(pivotal_project)
puts "Copy finished."

