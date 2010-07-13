require 'rubygems'
require 'ticketmaster'
require 'ticketmaster-pivotal'
require 'ticketmaster-lighthouse'

# copy all tickets and comments from pivotal tracker to new lighthouse project
puts "Copy started..."
pivotal = TicketMaster.new(:pivotal)
pivotal_project = pivotal.project(97107)
lighthouse = TicketMaster.new(:lighthouse)
puts "Creating new project in Lighthouse..."
lighthouse_project = lighthouse.project!(:name => "Copy Test on #{Time.now}", :description => "A copy test")

pivotal_project.tickets.each do |pivotal_ticket|
  puts "Copying ticket '#{pivotal_ticket.title}'..."
  
  lighthouse_ticket = lighthouse_project.ticket!({:title => pivotal_ticket.title, 
                                                  :description => pivotal_ticket.description})
  pivotal_ticket.comments.each do |comment|
    lighthouse_ticket.comment!(:body => comment.body)
  end
end
puts "Copy finished."

