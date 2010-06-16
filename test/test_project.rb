require 'helper'
require 'dummy_provider'

class TestProject < Test::Unit::TestCase
  context "projects" do
    setup do
      @ticketmaster = TicketMaster.new(:dummy, {:username => "John", :password => "seekrit"})
    end

    should "return an empty array when no query" do
      assert_equal [], @ticketmaster.projects.find
    end
  end
end
