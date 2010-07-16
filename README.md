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

You could then install for instance ticketmaster-pivotal:

    gem install ticketmaster-pivotal

## Usage

**Note:** The API may change, and the following may not be the final. Please keep yourself updated before you upgrade.

First, we instance a new class with the right set of options. In this example, we are authenticating with Pivotal Tracker.

    pivotal = TicketMaster.new(:pivotal, {:username => "john", :password => "seekrit"})

### Grabbing a project

Now that we've got out ticketmaster instance, let's go ahead and grab "testproject":

    project = pivotal.project["testproject"]
        #=> TicketMaster::Project<#name="testproject"..>

*Project#[]* is an alias to *Project#find*:

    project = pivotal.project.find "testproject"
        #=> TicketMaster::Project<#name="testproject"..>

Which translates into:

    project = pivotal.project.find :name => "testproject"
        #=> TicketMaster::Project<#name="testproject"..>

That means you can actually look up a project by something else than the title, like the owner:

    project = pivotal.project.find :owner => "Sirupsen"
        #=> TicketMaster::Project<#owner="sirupsen"..>

To retrieve all projects, simply pass no argument to find:

    project = pivotal.project.find
        #=> [TicketMaster::Project<#..>,TicketMaster::Project<#..>,..]

### Creating a ticket

Now that we grabbed the right project. Let's go ahead and create a ticket at this project:

    project.ticket.create(:summary => "Test", :description => "Hello World")

We create our ticket with three properties.

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

### Pivotal Tracker

To use Pivotal Tracker with ticketmaster, install it:
    gem install ticketmaster-pivotal

Then simply require it, and you are good to use Pivotal Tracker with ticketmaster!

    require 'ticketmaster'
    require 'ticketmaster-pivotal'
    unfuddle = TicketMaster.new(:pivotal, {:username => "..", :password => ".."})

### Lighthouse

To use Lighthouse with ticketmaster, install it:
    gem install ticketmaster-lighthouse

Then simply require it, and you are all set to use Lighthouse with ticketmaster!

    require 'ticketmaster'
    require 'ticketmaster-lighthouse'
    lighthouse = TicketMaster.new(:lighthouse, {:username => "..", :password => ".."})

### Unfuddle (Alpha, needs compatibility update)

To use Unfuddle with ticketmaster, install it:
    gem install ticketmaster-unfuddle

Then simply require it, and you are good to use Unfuddle with ticketmaster!

    require 'ticketmaster'
    require 'ticketmaster-unfuddle'
    unfuddle = TicketMaster.new(:unfuddle, {:username => "..", :password => "..", :subdomain => ".."})

## Creating a provider
Creating a provider consists of three steps:

* Create the ticketmaster provider (a.k.a. the remap) using the skeleton located at http://github.com/hybridgroup/ticketmaster-provider-skeleton
* Implement whatever is needed to connect to your desired backend
* Release it to RubyGems

### Create the ticketmaster provider
Almost all APIs are different. And so are their Ruby providers. ticketmaster attempts to create an universal API for ticket and project management systems, and thus, we need to map the functionality to the ticketmaster API. This is the providers job. The provider is the glue between ticketmaster, and the ticket management system's API.
Usually, your provider would rely on another library for the raw HTTP interaction. For instance, [ticketmaster-lighthouse](http://github.com/hybridgroup/ticketmaster-lighthouse) relies on ActiveResource in order to interact with the Lighthouse API. Look at it like this:

**ticketmaster** -> **Provider** -> *(Ruby library)* -> **Site's API**

Provider being the *glue* between the site's API and ticketmaster. The Ruby library is "optional" (though highly recommended as mentioned), therefore it is in parantheses.

An example of a provider could be [ticketmaster-lighthouse](http://github.com/hybridgroup/ticketmaster-lighthouse), an example of a Ruby library could be ActiveResource.

For now, look at [ticketmaster-lighthouse](http://github.com/hybridgroup/ticketmaster-lighthouse) as an example on how to create a provider. More detailed documentation will be available soon.

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
* Add tests for it. This is important so we don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself so we can ignore when we pull)
* Send us a pull request. Bonus points for feature branches.

## Copyright

Copyright (c) 2010 [The Hybrid Group](http://hybridgroup.com). See LICENSE for details.
