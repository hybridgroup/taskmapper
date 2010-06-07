require 'helper'
require 'ticketmaster-unfuddle'

class TestTicketmaster < Test::Unit::TestCase
  context "Unfuddle" do
    setup do
      @unfuddle = TicketMaster.new(:unfuddle, {:username => "simon", :password => "WT00op", :subdomain => "ticketmaster"})
      @project = @unfuddle.project.find.first
    end

    should "find testproject" do
      project = @unfuddle.project.find(:name => "testproject")

      assert_instance_of TicketMasterMod::Project, project
      assert_equal "testproject", project.name

      #method 2
      project = @unfuddle.project.find("testproject")

      assert_instance_of TicketMasterMod::Project, project
      assert_equal "testproject", project.name

      #method 3
      project = @unfuddle.project["testproject"]

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

      should "find new tickets" do
        tickets = @project.tickets(:status => "new")

        tickets.each do |ticket|
          assert_equal "new", ticket.status
        end
      end

      should "find ticket with id 1" do
        ticket = @project.tickets(:id => 1)

        assert_equal 1, ticket.id
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
