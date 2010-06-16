require 'helper'

class TestProject < Test::Unit::TestCase
  context "projects" do
    setup do
      @ticketmaster = TicketMaster.new(:dummy, {:username => "John", :password => "seekrit"})
    end

    should "return an empty array when no query" do
      TicketMasterMod::Dummy::Project.stubs(:find).returns([])
      assert_equal [], @ticketmaster.projects.find
    end
  end
end
