require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# This can also act as an example test or test skeleton for your provider.
# Just replace the Dummy in @project_class and @ticket_class
# Also, remember to mock or stub any API calls
describe "Tickets" do
  before(:each) do
    @ticketmaster = TicketMaster.new(:dummy, {})
    @project_class = TicketMaster::Provider::Dummy::Project
    @ticket_class = TicketMaster::Provider::Dummy::Ticket
    @project = @ticketmaster.projects.first
  end

  describe "for a Project" do
    it "should return an array" do
      @project.tickets.should be_an_instance_of Array
    end
    
    it "should return Ticket objects" do
      @project.tickets.first.should be_an_instance_of @ticket_class
    end
    
    describe "when searching wanting back all tickets that match the query" do
      before do
        @tickets = @project.tickets([999])
      end
      
      it "should return an array" do
        @tickets.should be_an_instance_of Array
      end
      
      it "should return Ticket objects" do
        @tickets.first.should be_an_instance_of @ticket_class
      end
      
      it "should return Tickets that match ID" do
        @tickets.first.id.should == 999
      end
      
      it "should return an array when passing query hash" do
        @project.tickets(:id => 999).should be_an_instance_of Array
      end
    end
    
    describe "when searching wanting back the first ticket that matches the query" do
      it "should return the first Ticket as a default" do
        @project.ticket.should == TicketMaster::Provider::Dummy::Ticket
      end
      
      describe "when querying using default ID query" do
        it "should return a Ticket object" do
          @project.ticket(888).should be_an_instance_of @ticket_class
        end

        it "should only return Tickets with the correct ID" do
          @project.ticket(888).id.should == 888
        end
      end
      
      describe "when querying using hash" do
        it "should return a Ticket object" do
          @project.ticket(:id => 888).should be_an_instance_of @ticket_class
        end

        it "should only return Tickets with the correct ID" do
          @project.ticket(:id => 888).id.should == 888
        end        
      end
    end    
  end
  
  it "should be able to do other ticket stuff"

end
