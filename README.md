# taskmapper

taskmapper is a Gem which eases communication with various project and ticket management systems by providing a consistent Ruby API.

taskmapper let's you "remap" a system into the consistent taskmapper API, easily. For instance the description of an issue/ticket, might be named **description** in one system, and **problem-description** somewhere else. Via taskmapper, this would always be called **description**. The taskmapper remaps makes it easy for you to integrate different kinds of ticket systems, into your own system. You don't have to take care of all the different kinds of systems, and their different APIs. taskmapper handles all this *for* you, so you can focus on making your application awesome.

## Installation

taskmapper is a Gem, so we can easily install it by using RubyGems:

    gem install taskmapper

taskmapper depends on [Hashie](http://github.com/intridea/hashie), which is an amazing library which makes converting objects to hashes, and the other way around, a joy. It should be installed automatically whenever installing taskmapper.

### Finding and installing a provider

taskmapper by itself won't do too much. You may want to install a provider, to retrieve a list of available providers issue the following command:

    gem search taskmapper

You could then install for instance taskmapper-pivotal:

    gem install taskmapper-pivotal

## Usage

**Note:** The API may change, and the following may not be the final. Please keep yourself updated before you upgrade.

First, we instance a new class with the right set of options. In this example, we are authenticating with Pivotal Tracker.

    pivotal = taskmapper.new(:pivotal, {:username => "john", :password => "seekrit"})

### Grabbing a project

Now that we've got out taskmapper instance, let's go ahead and grab "testproject":

    project = pivotal.project["testproject"]
        #=> taskmapper::Project<#name="testproject"..>

*Project#[]* is an alias to *Project#find*:

    project = pivotal.project.find "testproject"
        #=> taskmapper::Project<#name="testproject"..>

Which translates into:

    project = pivotal.project.find :name => "testproject"
        #=> taskmapper::Project<#name="testproject"..>

That means you can actually look up a project by something else than the title, like the owner:

    project = pivotal.project.find :owner => "Sirupsen"
        #=> taskmapper::Project<#owner="sirupsen"..>

To retrieve all projects, simply pass no argument to find:

    project = pivotal.project.find
        #=> [taskmapper::Project<#..>,TaskMapper::Project<#..>,..]

### Creating a ticket

Now that we grabbed the right project. Let's go ahead and create a ticket at this project:

    project.ticket!(:title => "Test", :description => "Hello World")

We create our ticket with three properties.

### Finding tickets

Alright, let's play with the projects tickets! Here we grab the ticket with the id of 22:

    ticket = project.tickets(:id => 22)
        #=> taskmapper::Ticket<#id=22..>

Like with projects, we can also find tickets by other attributes, like title, priority and so on, with tickets we do not use a find method though. Also as with projects, if no argument is passed, all tickets are retrieved:

    tickets = project.tickets
        #=> [taskmapper::Ticket<#..>,TaskMapper::Ticket<#..>,..]

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

Currently taskmapper supports the following systems:

### Pivotal Tracker

To use Pivotal Tracker with taskmapper, install it:
    gem install taskmapper-pivotal

Then simply require it, and you are good to use Pivotal Tracker with taskmapper!

    require 'taskmapper'
    require 'taskmapper-pivotal'
    unfuddle = taskmapper.new(:pivotal, {:username => "..", :password => ".."})

The source code is located at [taskmapper-pivotal](http://github.com/hybridgroup/taskmapper-pivotal)

### Lighthouse

To use Lighthouse with taskmapper, install it:
    gem install taskmapper-lighthouse

Then simply require it, and you are all set to use Lighthouse with taskmapper!

    require 'taskmapper'
    require 'taskmapper-lighthouse'
    lighthouse = taskmapper.new(:lighthouse, {:username => "..", :password => ".."})

The source code is located at [taskmapper-lighthouse](http://github.com/hybridgroup/taskmapper-lighthouse)

### Basecamp

To use Basecamp with taskmapper, install it:
    gem install taskmapper-basecamp

Once you require it, then you are ready to use Basecamp with taskmapper

    require 'taskmapper'
    require 'taskmapper-basecamp'
    basecamp = taskmapper.new(:basecamp, :domain => 'yourdomain.basecamphq.com', :username => 'you', :password => 'pass')

The source code is located at [taskmapper-basecamp](http://github.com/hybridgroup/taskmapper-basecamp)

### Github

To use Github's issue tracking with taskmapper, install it:
    gem install taskmapper-github

Once you require it, then you are ready to use Github and taskmapper

    require 'taskmapper'
    require 'taskmapper-github'
    github = taskmapper.new(:github, :username => 'you', :password => 'pass')

The source code is located at [taskmapper-github](http://github.com/hybridgroup/taskmapper-github)

### Unfuddle

To use Unfuddle with taskmapper, install it:
    gem install taskmapper-unfuddle

Then simply require it, and you are good to use Unfuddle with taskmapper!

    require 'taskmapper'
    require 'taskmapper-unfuddle'
    unfuddle = taskmapper.new(:unfuddle, {:username => "..", :password => "..", :account => ".."})

The source code is located at [taskmapper-unfuddle](http://github.com/hybridgroup/taskmapper-unfuddle)

### Kanban Pad

To use Kanban Pad with taskmapper, install it:
    gem install taskmapper-kanbanpad

Once you require it, you can connect to Kanban Pad using taskmapper!

    require 'taskmapper'
    require 'taskmapper-kanbanpad'
    kanbanpad = taskmapper.new(:kanbanpad, {:username => "xx", :password => "xx"})

The source code is located at [taskmapper-kanbanpad](https://github.com/hybridgroup/taskmapper-kanbanpad)

### Redmine

To use Redmine with taskmapper, install it:
    gem install taskmapper-redmine

Just require it, and you are ready to use Redmine with taskmapper!

    require 'taskmapper'
    require 'taskmapper-redmine'
    redmine = taskmapper.new(:redmine, {:username => "..", :password => "..", :server => ".."})

The source code is located at [taskmapper-redmine](http://github.com/hybridgroup/taskmapper-redmine)

### Trac

To use Trac with taskmapper, install it:
    gem install taskmapper-trac

Require it, and you are happening to call Trac with taskmapper!

    require 'taskmapper'
    require 'taskmapper-trac'
    trac = taskmapper.new(:trac, {:username => "..", :password => "..", :url => ".."})

The source code is located at [taskmapper-trac](http://github.com/hybridgroup/taskmapper-trac)

### Codaset

To use Codaset with taskmapper, install it:
    gem install taskmapper-codaset

Require and you have connected to Codaset with taskmapper!

    require 'taskmapper'
    require 'taskmapper-codaset'
    codaset = taskmapper.new(:codaset, {:username => "foo", :password => "bar", :client_id => "your_client_id", :client_secret => "your_client_secret"})

The source code is located at [taskmapper-codaset](http://github.com/hybridgroup/taskmapper-codaset)

### Bugzilla

To use Bugzilla with taskmapper, install it:
    gem install taskmapper-bugzilla

Require and you can talk to Bugzilla with taskmapper!

    require 'taskmapper'
    require 'taskmapper-bugzilla'
    codaset = taskmapper.new(:bugzilla, {:username => "foo", :password => "bar", :url => "https://bugzilla.mozilla.org"})

The source code is located at [taskmapper-bugzilla](http://github.com/hybridgroup/taskmapper-bugzilla)

## Creating a provider
Creating a provider consists of three steps:

* Run the generator like this:
    tm generate myprovider
* Implement whatever is needed to connect to your desired backend
* Release it to RubyGems

### Create the taskmapper provider
Thanks to a simple generator, it is easy to get started with a new provider. Run this from the command line:
    tm generate myprovider

This will generate a new skeleton provider called taskmapper-myprovider in the current directory. Create a repo from that directory, and you can start implementing your provider.

Almost all APIs are different. And so are their Ruby providers. taskmapper attempts to create an universal API for ticket and project management systems, and thus, we need to map the functionality to the taskmapper API. This is the providers job. The provider is the glue between taskmapper, and the ticket management system's API.
Usually, your provider would rely on another library for the raw HTTP interaction. For instance, [taskmapper-lighthouse](http://github.com/hybridgroup/taskmapper-lighthouse) relies on ActiveResource in order to interact with the Lighthouse API. Look at it like this:

**taskmapper** -> **Provider** -> *(Ruby library)* -> **Site's API**

Provider being the *glue* between the site's API and taskmapper. The Ruby library is "optional" (though highly recommended as mentioned), therefore it is in parantheses.

An example of a provider could be [taskmapper-lighthouse](http://github.com/hybridgroup/taskmapper-lighthouse), an example of a Ruby library could be ActiveResource.

For now, look at [taskmapper-lighthouse](http://github.com/hybridgroup/taskmapper-lighthouse) as an example on how to create a provider. More detailed documentation will be available soon.

### Release it
Simply release it to RubyGems.org, the name of the provider Gem should follow this simple naming rule:

    taskmapper-<provider's name>

For instance if you set for a Github provider, it would be named:

    taskmapper-github

This makes it easy for people to find providers, simply by issuing:

    gem search -r taskmapper

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
