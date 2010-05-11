# ticketmaster

Ticketmaster is a Gem which eases communication with various project and ticket management systems by providing a consistent Ruby API.

**This code is under development.**

## Usage

### Managing tickets

    github = TicketMasterl.interact_with(:github)
    project = github.project.find 'ticketmaster project'
    project.tickets.find(17).close(:message => "Fixed")
    ticket = project.ticket.create("Do something", {:body => "What to do"})
    ticket.status = :in_progress

## Support

Currently ticketmaster supports the following systems:

* Github (Pre-pre-pre-pre Alpha)

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
