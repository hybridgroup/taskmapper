$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'rubygems'
require 'ticketmaster'

describe "TaskMapper Exception Messages" do
  let(:exception) { TaskMapper::Exception }
  let(:tm) { TaskMapper.new(:tester, {}) }
  let(:validation_error) { "TaskMapper::Provider::Base::valid? method must be implemented by the provider" }
  let(:easy_finder_error) { "TaskMapper::Provider::Helper::easy_finder method must be implemented by the provider" }

  describe "TaskMapper::Provider::Base" do 
    context "when calling #valid? method" do 
      subject { lambda { tm.valid? } }
      it { should raise_error(exception, validation_error) }
    end
  end

  describe "TaskMapper::Provider::Helper" do
    context "when calling #easy_finder" do 
      subject { lambda { tm.easy_finder(1, :test, {}) } }
      it { should raise_error(exception, easy_finder_error) }
    end
  end

  describe "TaskMapper::Provider::Tester::Project" do
    let(:find_by_id_error) { "TaskMapper::Provider::Tester::Project::find_by_id method must be implemented by the provider" }
    let(:find_by_attributes_error) { "TaskMapper::Provider::Tester::Project::find_by_attributes method must be implemented by the provider" }
    let(:search_error) { "TaskMapper::Provider::Tester::Project::search method must be implemented by the provider"}
    let(:create_error) { "TaskMapper::Provider::Tester::Project::create method must be implemented by the provider"}
    let(:save_error) { "TaskMapper::Provider::Tester::Project::save method must be implemented by the provider"}
    let(:destroy_error) { "TaskMapper::Provider::Tester::Project::destroy method must be implemented by the provider" }

    context "when calling #find_by_id" do 
      subject { lambda { tm.project([1]) } }
      it { should raise_error(exception, find_by_id_error) }
    end

    context "when calling #find_by_attributes" do 
      subject { lambda { tm.project.find :all, :name => 'Test Project' } }
      it { should raise_error(exception, find_by_attributes_error) }
    end

    context "when calling #search" do 
      subject { lambda { tm.project.search :tag => 'testing' } }
      it { should raise_error(exception, search_error) }
    end

    context "when calling #create" do 
      subject { lambda { tm.project.create :name => 'Foo Bar' } } 
      it { should raise_error(exception, create_error) }
    end

    context "when calling #save" do 
      subject { lambda { tm.project.save } }
      pending { should raise_error(exception, save_error) }
    end

    context "when calling #destroy" do 
      let(:project) { TaskMapper::Provider::Tester::Project.new }
      subject { lambda { project.destroy } }
      it { should raise_error(exception, destroy_error) }
    end
  end

  describe "TaskMapper::Provider::Tester::Ticket" do
    before(:each) do
      @ticket = TaskMapper::Provider::Tester::Ticket.new(1)
    end
    it "find_by_id method raises correct exception" do
      pending
      msg = "TaskMapper::Provider::Tester::Ticket::find_by_id method must be implemented by the provider"
      lambda { @ticketmaster.tickets(:id => 22) }.should raise_error(@exception, msg)
    end    
    it "find_by_attributes method raises correct exception" do
      pending
      msg = "TaskMapper::Provider::Tester::Ticket::find_by_attributes method must be implemented by the provider"
      lambda { @ticketmaster.ticket.find(1, :all, :title => 'Test ticket') }.should raise_error(@exception, msg)
    end    
    it "search method raises correct exception" do
      pending
      msg = "TaskMapper::Provider::Tester::Ticket::search method must be implemented by the provider"
      lambda { @ticketmaster.ticket.search :tag => 'testing' }.should raise_error(@exception, msg)
    end    
    it "create method raises correct exception" do
      pending
      msg = "TaskMapper::Provider::Tester::Ticket::create method must be implemented by the provider"
      lambda { @ticketmaster.ticket.create :name => 'Foo Bar' }.should raise_error(@exception, msg)
    end    
    it "save method raises correct exception" do
      pending
      msg = "TaskMapper::Provider::Tester::Ticket::save method must be implemented by the provider"
      lambda { @ticket.save }.should raise_error(@exception, msg)
    end    
    it "destroy method raises correct exception" do
      pending
      msg = "TaskMapper::Provider::Tester::Ticket::destroy method must be implemented by the provider"
      lambda { @ticket.destroy }.should raise_error(@exception, msg)
    end    
    it "close method raises correct exception" do
      pending
      msg = "TaskMapper::Provider::Tester::Ticket::close method must be implemented by the provider"
      lambda { @ticket.close }.should raise_error(@exception, msg)
    end    
    it "reload! method raises correct exception" do
      pending
      msg = "TaskMapper::Provider::Tester::Ticket::reload! method must be implemented by the provider"
      lambda { @ticket.reload! }.should raise_error(@exception, msg)
    end    
  end

  describe "TaskMapper::Provider::Tester::Comment" do
    before(:each) do
      @ticket_with_comments = TaskMapper::Provider::Tester::Ticket.new(1)
      @comment = TaskMapper::Provider::Tester::Comment.new(1, 1)
    end
    it "find_by_id method raises correct exception" do
      pending
      msg = "TaskMapper::Provider::Tester::Comment::find_by_id method must be implemented by the provider"
      lambda { @ticket_with_comments.comment.find(1, 1, [1,2]) }.should raise_error(@exception, msg)
    end    
    it "find_by_attributes method raises correct exception" do
      pending
      msg = "TaskMapper::Provider::Tester::Comment::find_by_attributes method must be implemented by the provider"
      lambda { @ticket_with_comments.comment.find(1, 1, :all, :tag => "tag") }.should raise_error(@exception, msg)
    end    
    it "search method raises correct exception" do
      pending
      msg = "TaskMapper::Provider::Tester::Comment::search method must be implemented by the provider"
      lambda { @ticket_with_comments.comment.search(1, 1, :tag => 'testing') }.should raise_error(@exception, msg)
    end    
    it "create method raises correct exception" do
      pending
      msg = "TaskMapper::Provider::Tester::Comment::create method must be implemented by the provider"
      lambda { @ticket_with_comments.comment.create :name => 'Foo Bar' }.should raise_error(@exception, msg)
    end    
    it "save method raises correct exception" do
      pending
      msg = "TaskMapper::Provider::Tester::Comment::save method must be implemented by the provider"
      lambda { @comment.save }.should raise_error(@exception, msg)
    end    
    it "destroy method raises correct exception" do
      pending
      msg = "TaskMapper::Provider::Tester::Comment::destroy method must be implemented by the provider"
      lambda { @comment.destroy }.should raise_error(@exception, msg)
    end    
  end

end

