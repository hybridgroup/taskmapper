require 'helper'

class TestTicketmaster < Test::Unit::TestCase
  should "say hai from github" do
    class CommunicateWithGithub
      include TicketMaster::Github
    end
    github = CommunicateWithGithub.new

    assert_equal github.hai, "Hai from Github!"
  end
end
