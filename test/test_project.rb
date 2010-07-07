require File.expand_path(File.dirname(__FILE__) + '/helper')

class TestProject < Test::Unit::TestCase
  context "with all projects" do
    setup do
      @ticketmaster = TicketMaster.new(:dummy, {:username => "John", :password => "seekrit"})
    end

    context "when searching" do
      context "with no projects" do
        should "return an empty array when no query" do
          assert_equal [], @ticketmaster.projects.find
        end
      
        should "return empty array for string query" do
          assert_equal [], @ticketmaster.projects.find("something")
        end

        should "return empty array for hashed query" do
          assert_equal [], @ticketmaster.projects.find(:name => "something")
        end
      end

      context "with a single project" do
        setup do
          @project = stub(:name => "something")
          TicketMasterMod::Project.any_instance.stubs(:search).returns(@project)
          TicketMasterMod::Dummy::Project.stubs(:find).returns(@project)
        end
        
        should "return single project when no query" do
          assert_equal @project, @ticketmaster.projects.find
        end
      
        should "return single project for string query" do
          assert_equal @project, @ticketmaster.projects.find("something")
        end

        should "return single project for hashed query" do
          assert_equal @project, @ticketmaster.projects.find(:name => "something")
        end
      end

      context "with multiple projects" do
        setup do
          @project1 = stub(:name => "something")
          @project2 = stub(:name => "something else")
          TicketMasterMod::Project.any_instance.stubs(:search).returns(@project)
          TicketMasterMod::Dummy::Project.stubs(:find).returns([@project1, @project2])
        end
        
        should "return multiple projects when no query" do
          assert_equal [@project1, @project2], @ticketmaster.projects.find
        end
      
        should "return single project for string query" do
          assert_equal @project, @ticketmaster.projects.find("something")
        end

        should "return single project for hashed query" do
          assert_equal @project, @ticketmaster.projects.find(:name => "something")
        end
      end
    end
  end
  
  context "a specific project" do
    setup do
      @project = TicketMasterMod::Project.new
      @project.stubs(:system).returns('dummy')
    end
  
    context "with no tickets" do
      should "return an empty array when no query" do
        assert_equal [], @project.tickets
      end
      
      should "return empty array if string query has no results" do
        assert_equal [], @project.tickets("something")
      end

      should "return empty array if hashed query has no results" do
        assert_equal [], @project.tickets(:name => "something")
      end
    end
  end
end
