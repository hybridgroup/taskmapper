require 'rubygems'
require 'ticketmaster'
require 'ticketmaster-pivotal'
require 'ticketmaster-lighthouse'

# copy all tickets and comments from pivotal tracker to new lighthouse project (the hard way)
pivotal = TicketMaster.new(:pivotal)
lighthouse = TicketMaster.new(:lighthouse)

from = pivotal.project(97107)

to = lighthouse.project!(:name => "Copy Test on #{Time.now}", 
                          :description => "A copy test")

from.tickets.each do |from_ticket|
  to_ticket = to.ticket!({:title => pivotal_ticket.title, 
                          :description => pivotal_ticket.description})
  from_ticket.comments.each do |comment|
    to_ticket.comment!(:body => comment.body)
  end
end
