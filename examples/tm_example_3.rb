require 'rubygems'
require 'ticketmaster'
require 'ticketmaster-pivotal'
require 'ticketmaster-lighthouse'

# copy all tickets and comments from pivotal tracker to new lighthouse project
pivotal = TicketMaster.new(:pivotal)
pivotal_project = pivotal.project(97107)
lighthouse = TicketMaster.new(:lighthouse)
lighthouse_project = lighthouse.project!(:name => "Copy Test on #{Time.now}", :description => "A copy test")

pivotal_project.tickets.each do |pivotal_ticket|
  puts pivotal_ticket.title, pivotal_ticket.description
  
  lighthouse_ticket = lighthouse_project.ticket!({:title => pivotal_ticket.title, :description => pivotal_ticket.description})
  pivotal_ticket.comments.each do |comment|
    lighthouse_ticket.comment!(:text => comment.body)
  end
end

