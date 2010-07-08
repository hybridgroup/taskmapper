require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# This can also act as an example test or test skeleton for your provider.
# Just replace the Dummy in @project_class and @ticket_class
# Also, remember to mock or stub any API calls
describe "Ticketmaster" do
  before(:each) do
    @ticketmaster = TicketMaster.new(:dummy, {})
    @project_class = TicketMaster::Provider::Dummy::Project
    @ticket_class = TicketMaster::Provider::Dummy::Ticket
    @comment_class = TicketMaster::Provider::Dummy::Comment
  end
  
  # Essentially just a sanity check on the include since .new always returns the object's instance
  it "should be able to instantiate a new instance" do
    @ticketmaster.should be_an_instance_of TicketMaster
    @ticketmaster.should be_a_kind_of TicketMaster::Provider::Dummy
  end
    
  
  it "should be able to load tickets" do
    project = @ticketmaster.projects.first
    project.tickets.should be_an_instance_of Array
    project.tickets.first.should be_an_instance_of @ticket_class
    project.tickets([999]).should be_an_instance_of Array
    project.tickets([999]).first.should  be_an_instance_of @ticket_class
    project.tickets([999]).first.id.should == 999
    project.tickets(:id => 999).should be_an_instance_of Array
    
    project.ticket.should ==  TicketMaster::Provider::Dummy::Ticket
    project.ticket(888).should be_an_instance_of @ticket_class
    project.ticket(888).id.should == 888
    project.ticket(:id => 888).should be_an_instance_of @ticket_class
    project.ticket(:id => 888).id.should == 888
  end
  
  it "should be able to do ticket stuff" do
    pending
  end
  
  it "should be able to load comments" do
    pending
  end
  
  it "should be able to do comment stuff" do
    pending
  end
  
end
