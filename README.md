# ticketmaster

ticketmaster is a Gem which eases communication with various project and ticket management systems by providing a consistent Ruby API.

ticketmaster let's you "remap" a system into the consistent ticketmaster API, easily. For instance the description of an issue/ticket, might be named **description** in one system, and **problem-description** somewhere else. Via ticketmaster, this would always be called **description**. The ticketmaster remaps makes it easy for you to integrate different kinds of ticket systems, into your own system. You don't have to take care of all the different kinds of systems, and their different APIs. ticketmaster handles all this *for* you, so you can focus on making your application awesome.

## Installation

ticketmaster is a Gem, so we can easily install it by using RubyGems:

    gem install ticketmaster

ticketmaster depends on [Hashie](http://github.com/intridea/hashie), which is an amazing library which makes converting objects to hashes, and the other way around, a joy. It should be installed automatically whenever installing ticketmaster.

### Finding and installing a provider

ticketmaster by itself won't do too much. You may want to install a provider, to retrieve a list of available providers issue the following command:

    gem search ticketmaster

You could then install for instance ticketmaster-unfuddle:

    gem install ticketmaster-unfuddle

## Usage

**Note:** The API may change, and the following may not be the final. Please keep yourself updated before you upgrade.

First, we instance a new class with the right set of options. In this example, we are authenticating with Unfuddle. As Unfuddle is a closed system, it is *required* that you authenticate to a subdomain:

    unfuddle = TicketMaster.new(:unfuddle, {:username => "john", :password => "seekrit", :subdomain => "ticketmaster"})

### Grabbing a project

Now that we've got out ticketmaster instance, let's go ahead and grab "testproject":

    project = unfuddle.project["testproject"]
        #=> TicketMaster::Project<#name="testproject"..>

*Project#[]* is an alias to *Project#find*:

    project = unfuddle.project.find "testproject"
        #=> TicketMaster::Project<#name="testproject"..>

Which translates into:

    project = unfuddle.project.find :name => "testproject"
        #=> TicketMaster::Project<#name="testproject"..>

That means you can actually look up a project by something else than the title, like the owner:

    project = unfuddle.project.find :owner => "Sirupsen"
        #=> TicketMaster::Project<#owner="sirupsen"..>

To retrieve all projects, simply pass no argument to find:

    project = unfuddle.project.find
        #=> [TicketMaster::Project<#..>,TicketMaster::Project<#..>,..]

### Creating a ticket

Now that we grabbed the right project. Let's go ahead and create a ticket at this project:

    project.ticket.create(:priority => 3, :summary => "Test", :description => "Hello World")

We create our ticket with three properties, the only one which may seem unfamiliar is the priority one, however, this attribute is required by Unfuddle.

### Finding tickets

Alright, let's play with the projects tickets! Here we grab the ticket with the id of 22:

    ticket = project.tickets(:id => 22)
        #=> TicketMaster::Ticket<#id=22..>

Like with projects, we can also find tickets by other attributes, like title, priority and so on, with tickets we do not use a find method though. Also as with projects, if no argument is passed, all tickets are retrieved:

    tickets = project.tickets
        #=> [TicketMaster::Ticket<#..>,TicketMaster::Ticket<#..>,..]

### Changing ticket attributes

Let's say that we're working on this ticket right now, so let's go ahead and change the status to reflect that:

    ticket.status = :in_progress

Other valid ticket statuses include:

    :closed, :accepted, :resolved

For the sake of example, we'll change the description as well, and then save the ticket.

    ticket.description = "Changed description to something else!"
    ticket.save

### Closing a ticket

The issue was solved, let's make that official by closing the ticket with the appropriate resolution:

    ticket.close(:resolution => "fixed", :description => "Fixed issue by doing x")

Note that you could close the ticket by changing all the attributes manually, like so:

    ticket.status = :closed
    ticket.resolution = "fixed"
    ticket.resolution_description = "Fixed issue by doing x"
    ticket.save

However, as closing a ticket with a resolution is such a common task, the other method is included because it may be more convenient.

## Support

Currently ticketmaster supports the following systems:

### Unfuddle (Alpha)

To use Unfuddle with ticketmaster, install it:
    gem install ticketmaster-unfuddle

Then simply require it, and you are good to use Unfuddle with ticketmaster!

    require 'ticketmaster'
    require 'ticketmaster-unfuddle'
    unfuddle = TicketMaster.new(:unfuddle, {:username => "..", :password => "..", :subdomain => ".."})

## Creating a provider
Creating a provider consists of two steps:

* Create the ticketmaster provider (a.k.a. the remap)
* Release it to RubyGems

### Create the ticketmaster provider
Almost all APIs are different. And so are their Ruby providers. ticketmaster attempts to create an universal API for ticket and project management systems, and thus, we need to map the functionality to the ticketmaster API. This is the providers job. The provider is the glue between ticketmaster, and the ticket management system's API.
Usually, your provider would rely on another library for the raw HTTP interaction. For instance, [ticketmaster-unfuddle](http://github.com/hybridgroup/ticketmaster-unfuddle) relies on [Unfuddler](http://github.com/hybridgroup/unfuddler) in order to interact with the Unfuddle API. Look at it like this:

**ticketmaster** -> **Provider** -> *(Ruby library)* -> **Site's API**

Provider being the *glue* between the site's API and ticketmaster. The Ruby library is "optional" (though higly recommended as mentioned), therefore it is in parantheses.

An example of a provider could be [ticketmaster-unfuddle](http://github.com/hybridgroup/ticketmaster-unfuddle), an example of a Ruby library could be [Unfuddler](http://github.com/hybridgroup/unfuddler).

For now, look at [ticketmaster-unfuddle](http://github.com/hybridgroup/ticketmaster-unfuddle) as an example on how to create a provider. More detailed documentation will be available soon.

### Release it
Simply release it to RubyGems.org, the name of the provider Gem should follow this simple naming rule:

    ticketmaster-<provider's name>

For instance if you set for a Github provider, it would be named:

    ticketmaster-github

This makes it easy for people to find providers, simply by issuing:

    gem search -r ticketmaster

They should be presented with a nice list of all available providers.

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
