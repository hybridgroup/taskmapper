require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# This can also act as an example test or test skeleton for your provider.
# Just replace the Dummy in @project_class and @ticket_class
# Also, remember to mock or stub any API calls
describe "Ticketmaster" do
  before(:each) do
    @ticketmaster = TicketMaster.new(:dummy, {})
    @project_class = TicketMaster::Provider::Dummy::Project
    @ticket_class = TicketMaster::Provider::Dummy::Ticket
  end
  
  # Essentially just a sanity check on the include since .new always returns the object's instance
  it "should be able to instantiate a new instance" do
    @ticketmaster.should be_an_instance_of TicketMaster
    @ticketmaster.should be_a_kind_of TicketMaster::Provider::Dummy
  end
  
  it "should be able to load projects" do
    @ticketmaster.projects.should be_an_instance_of Array
    @ticketmaster.projects.first.should be_an_instance_of @project_class
    @ticketmaster.projects.first.description.should == "Mock!-ing Bird"
    @ticketmaster.projects(:id => 555).should be_an_instance_of Array
    @ticketmaster.projects(:id => 555).first.should be_an_instance_of @project_class
    @ticketmaster.projects(:id => 555).first.id.should == 555
    
    @ticketmaster.project.should == @project_class
    @ticketmaster.project(:name => "Whack whack what?").should be_an_instance_of @project_class
    @ticketmaster.project(:name => "Whack whack what?").name.should == "Whack whack what?"
    @ticketmaster.project.find(:first, :description => "Shocking Dirb").should be_an_instance_of @project_class
    @ticketmaster.project.find(:first, :description => "Shocking Dirb").description.should == "Shocking Dirb"
  end
  
  it "should be able to do project stuff" do
    info = {:id => 777, :name => "Tiket Name  c", :description => "that c thinks the k is trying to steal it's identity"}
    @ticketmaster.project.create(info).should be_an_instance_of @project_class
    @ticketmaster.project.new(info).should be_an_instance_of @project_class
    @ticketmaster.project.create(info).id.should == 777
    @ticketmaster.project.new(info).id.should == 777
    
    @ticketmaster.projects.first.save.should == true
  end
  
  it "should be able to load tickets" do
    project = @ticketmaster.projects.first
    project.tickets.should be_an_instance_of Array
    project.tickets.first.should be_an_instance_of @ticket_class
    project.tickets(:id => 999).should be_an_instance_of Array
    project.tickets(:id => 999).first.should  be_an_instance_of @ticket_class
    project.tickets(:id => 999).first.id.should == 999
    
    project.ticket.should ==  TicketMaster::Provider::Dummy::Ticket
    project.ticket(:id => 888).should be_an_instance_of @ticket_class
    project.ticket(:id => 888).id.should == 888
    project.ticket.find(:first, :id => 888).should be_an_instance_of @ticket_class
    project.ticket.find(:first, :id => 888).id.should == 888
  end
end
