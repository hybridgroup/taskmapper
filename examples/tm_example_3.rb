require 'rubygems'
require 'taskmapper'
require 'taskmapper-pivotal'
require 'taskmapper-lighthouse'

# copy all tickets and comments from pivotal tracker to new lighthouse project (the hard way)
pivotal = TaskMapper.new(:pivotal)
lighthouse = TaskMapper.new(:lighthouse)

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
