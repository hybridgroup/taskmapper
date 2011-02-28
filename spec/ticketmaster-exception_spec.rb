$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'rubygems'
require 'ticketmaster'

describe "Ticketmaster Exception Messages" do
  
  before(:all) do
    @exception = TicketMaster::Exception
  end
  
  before(:each) do
    @ticketmaster = TicketMaster.new(:tester, {})
  end
  
  describe "TicketMaster::Provider::Helper" do
    it "easy_finder method raises correct exception" do
      msg = "TicketMaster::Provider::Helper::easy_finder method must be implemented by the provider"
      lambda { @ticketmaster.easy_finder(1, :test, {}) }.should raise_error(@exception, msg)
    end
  end
  
  describe "TicketMaster::Provider::Tester::Project" do
    it "find_by_id method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Project::find_by_id method must be implemented by the provider"
      lambda { @ticketmaster.project([1]) }.should raise_error(@exception, msg)
    end    
    it "find_by_attributes method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Project::find_by_attributes method must be implemented by the provider"
      lambda { @ticketmaster.project.find :all, :name => 'Test Project' }.should raise_error(@exception, msg)
    end    
    it "search method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Project::search method must be implemented by the provider"
      lambda { @ticketmaster.project.search :tag => 'testing' }.should raise_error(@exception, msg)
    end    
    it "create method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Project::create method must be implemented by the provider"
      lambda { @ticketmaster.project.create :name => 'Foo Bar' }.should raise_error(@exception, msg)
    end    
    it "save method raises correct exception" do
      project = TicketMaster::Provider::Tester::Project.new
      msg = "TicketMaster::Provider::Tester::Project::save method must be implemented by the provider"
      lambda { project.save }.should raise_error(@exception, msg)
    end    
    it "destroy method raises correct exception" do
      project = TicketMaster::Provider::Tester::Project.new
      msg = "TicketMaster::Provider::Tester::Project::destroy method must be implemented by the provider"
      lambda { project.destroy }.should raise_error(@exception, msg)
    end    
  end
  
  describe "TicketMaster::Provider::Tester::Ticket" do
    before(:each) do
      @ticket = TicketMaster::Provider::Tester::Ticket.new(1)
    end
    it "find_by_id method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Ticket::find_by_id method must be implemented by the provider"
      lambda { @ticketmaster.tickets(:id => 22) }.should raise_error(@exception, msg)
    end    
    it "find_by_attributes method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Ticket::find_by_attributes method must be implemented by the provider"
      lambda { @ticketmaster.ticket.find(1, :all, :title => 'Test ticket') }.should raise_error(@exception, msg)
    end    
    it "search method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Ticket::search method must be implemented by the provider"
      lambda { @ticketmaster.ticket.search :tag => 'testing' }.should raise_error(@exception, msg)
    end    
    it "create method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Ticket::create method must be implemented by the provider"
      lambda { @ticketmaster.ticket.create :name => 'Foo Bar' }.should raise_error(@exception, msg)
    end    
    it "save method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Ticket::save method must be implemented by the provider"
      lambda { @ticket.save }.should raise_error(@exception, msg)
    end    
    it "destroy method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Ticket::destroy method must be implemented by the provider"
      lambda { @ticket.destroy }.should raise_error(@exception, msg)
    end    
    it "close method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Ticket::close method must be implemented by the provider"
      lambda { @ticket.close }.should raise_error(@exception, msg)
    end    
    it "reload! method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Ticket::reload! method must be implemented by the provider"
      lambda { @ticket.reload! }.should raise_error(@exception, msg)
    end    
  end
  
  describe "TicketMaster::Provider::Tester::Comment" do
    before(:each) do
      @ticket_with_comments = TicketMaster::Provider::Tester::Ticket.new(1)
      @comment = TicketMaster::Provider::Tester::Comment.new(1, 1)
    end
    it "find_by_id method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Comment::find_by_id method must be implemented by the provider"
      lambda { @ticket_with_comments.comment.find(1, 1, [1,2]) }.should raise_error(@exception, msg)
    end    
    it "find_by_attributes method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Comment::find_by_attributes method must be implemented by the provider"
      lambda { @ticket_with_comments.comment.find(1, 1, :all, :tag => "tag") }.should raise_error(@exception, msg)
    end    
    it "search method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Comment::search method must be implemented by the provider"
      lambda { @ticket_with_comments.comment.search(1, 1, :tag => 'testing') }.should raise_error(@exception, msg)
    end    
    it "create method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Comment::create method must be implemented by the provider"
      lambda { @ticket_with_comments.comment.create :name => 'Foo Bar' }.should raise_error(@exception, msg)
    end    
    it "save method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Comment::save method must be implemented by the provider"
      lambda { @comment.save }.should raise_error(@exception, msg)
    end    
    it "destroy method raises correct exception" do
      msg = "TicketMaster::Provider::Tester::Comment::destroy method must be implemented by the provider"
      lambda { @comment.destroy }.should raise_error(@exception, msg)
    end    
  end

end

