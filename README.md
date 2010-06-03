# ticketmaster

Ticketmaster is a Gem which eases communication with various project and ticket management systems by providing a consistent Ruby API.

**This code is under development.**

## Planned Usage

### Managing tickets

    github = TicketMaster.new(:github)
    project = github.project.find 'ticketmaster project'
    project.tickets.find(17).close(:message => "Fixed")
    ticket = project.ticket.create("Do something", {:body => "What to do"})
    ticket.status = :in_progress

## Usage

As of now.

Retrieving a project:
    unfuddle = TicketMaster.new(:unfuddle, {:username => "john", :password => "seekrit", :subdomain => "ticketmaster"})
    project = unfuddle.project.find.first
    project.ticket.create(:priority => 3, :summary => "Test", :description => "Hello World")

Using a Ticket:
    ticket = project.tickets[22]
    ticket.status = :in_progress
    ticket.description = "Changed description to something else!"
    ticket.save
    ticket.close(:resolution => "fixed", :description => "fixd")

## Support

Currently ticketmaster supports the following systems:

* Unfuddle (Pre-Alpha)

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 [Hybrid Group](http://hybridgroup.com). See LICENSE for details.
