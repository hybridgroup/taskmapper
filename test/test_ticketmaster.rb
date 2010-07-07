require File.expand_path(File.dirname(__FILE__) + '/helper')

class TestTicketmaster < Test::Unit::TestCase
  context "An instance of TicketMaster" do
    setup do 
      @ticketmaster = TicketMaster.new(:dummy, {:username => "John", :password => "seekrit"})
    end

    should "have the right properties" do
      assert_instance_of TicketMaster, @ticketmaster

      assert_equal "John", @ticketmaster.authentication.username
      assert_equal "seekrit", @ticketmaster.authentication.password
      assert_equal :dummy, @ticketmaster.system
    end
  end
end
