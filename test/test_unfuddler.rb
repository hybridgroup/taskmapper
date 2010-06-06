require 'helper'
require '/home/sirup/Code/Work/Hybrid/ticketmaster-unfuddle/lib/ticketmaster-unfuddle'

class TestTicketmaster < Test::Unit::TestCase
  context "Unfuddle" do
    setup do
      @unfuddle = TicketMaster.new(:unfuddle, {:username => "", :password => "", :subdomain => "ticketmaster"})
      @project = @unfuddle.project.find.first
    end

    should "find testproject" do
      project = @unfuddle.project.find("testproject")

      assert_instance_of TicketMasterMod::Project, project
      assert_equal "testproject", project.name
    end

    context "project instance" do
      should "find a project" do
        assert_instance_of TicketMasterMod::Project, @project
      end
    
      should "find a bunch of tickets" do
        @project.tickets
      end
    
      should "create a ticket" do
        assert @project.ticket.create(:priority => 3, :summary => "Test", :description => "Hello World from TicketMaster::Unfuddle").empty?
      end
    
      should "change ticket property" do
        ticket = @project.tickets.last
        ticket.description = "Edited description"
        assert ticket.save.empty?
    
        ticket = @project.tickets.last
        assert_equal "Edited description", ticket.description
      end
    
      should "close the last ticket with a resolution" do
        ticket = @project.tickets.last
        assert ticket.close(:resolution => "fixed", :description => "Fixed issue").empty?
    
        ticket = @project.tickets.last
        assert_equal "fixed", ticket.resolution
      end
    end
  end
end
