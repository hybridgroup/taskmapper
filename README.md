# ticketmaster

ticketmaster is a Gem which eases communication with various project and ticket management systems by providing a consistent Ruby API.

ticketmaster let's you "remap" a system into the consistent ticketmaster API, easily. For instance the description of an issue/ticket, might be named **description** in one system, and **problem-description** somewhere else. Via ticketmaster, this would always be called **description**. The ticketmaster remaps makes it easy for you to integrate different kinds of ticket systems, into your own system. You don't have to take care of all the different kinds of systems, and their different APIs. ticketmaster handles all this *for* you, so you can focus on making your application awesome.

## TODO

* Find project by name
* Find ticket by property

## Usage

**Note** Subject to change.

First, we instance a new class with the right set of options. In this example, we are authenticating with Unfuddle. As Unfuddle is a closed system, it is *required* that you authenticate with a user to a subdomain, and so we do:
    unfuddle = TicketMaster.new(:unfuddle, {:username => "john", :password => "seekrit", :subdomain => "ticketmaster"})

Now we can use our instance with the right settings, to find a project. Let's go ahead and grab the first one:
    project = unfuddle.project.find.first

And as ticketmaster is all about tickets, let's create one:
    project.ticket.create(:priority => 3, :summary => "Test", :description => "Hello World")

Let's play with tickets. First we go ahead and grab ticket 22:
    ticket = project.tickets[22]

We're working on this ticket right now, so let's go ahead and change the status, and for the fun of it, we'll change the description as well, and then save it.
    ticket.status = :in_progress
    ticket.description = "Changed description to something else!"
    ticket.save

The issue was solved, let's make it official by closing the ticket with the appropiate resolution:
    ticket.close(:resolution => "fixed", :description => "Fixed issue by doing x")

## Support

Currently ticketmaster supports the following systems:

### Unfuddle (Alpha)

To use Unfuddle with ticketmaster, install it:
    gem install ticketmaster-unfuddle

Then simply require it, and you are good to use Unfuddle with ticketmaster!
    require 'ticketmaster-unfuddle'

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
