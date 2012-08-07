# Taskmapper

Taskmapper is a Gem which eases communication with various project and ticket management systems by providing a consistent Ruby API.

Taskmapper let's you "remap" a system into the consistent Taskmapper API, easily. For instance the description of an task/issue/ticket, might be named **description** in one system, and **problem-description** somewhere else. Via Taskmapper, this would always be called **description**. The Taskmapper remaps makes it easy for you to integrate different kinds of ticket systems, into your own system. You don't have to take care of all the different kinds of systems, and their different APIs. Taskmapper handles all this *for* you, so you can focus on making your application awesome.

## Installation

Taskmapper is a Gem, so we can easily install it by using RubyGems:

    gem install taskmapper


### Finding and installing a provider

Taskmapper by itself won't do too much. You may want to install a provider, to retrieve a list of available providers issue the following command:

    gem search taskmapper

You could then install for instance taskmapper-pivotal:

    gem install taskmapper-pivotal

## Usage


## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix as an spec.
* Commit, do not mess with Rakefile, Version, or History.
  (if you want to have your own version, that is fine but bump version in a commit by itself so we can ignore when we pull)
* Send us a pull request. Bonus points for feature branches.

## Copyright

Copyright (c) 2010-2012 [The Hybrid Group](http://hybridgroup.com). See LICENSE for details.
