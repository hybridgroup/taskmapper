# ticketmaster

ticketmaster is a Gem which eases communicating with various project management and ticket tracking systems.

**This code is under development.**

## Usage

### Managing tickets

> github = TicketMaster.new(:Github)

> ticketmaster = github.project(:ticketmaster)

> ticketmaster.ticket.close(17, {:message => "Fixed"})

> ticket = ticketmaster.ticket.open("Do something", {:body => "What to do"})

> ticket.close

## Support

Currently ticketmaster supports the following systems:

* None

### Planned

It's planned to create a plugin system, which makes it easy for anyone to submit a plugin for a specific system. But here's a few planned to implement:

* Github issues
* Unfuddle
* Lighthouse

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
