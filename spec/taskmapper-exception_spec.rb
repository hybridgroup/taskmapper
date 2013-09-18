$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'rubygems'
require 'taskmapper'

describe "TaskMapper Exception Messages" do
  let(:exception) { TaskMapper::Exception }
  let(:tm) { TaskMapper.new(:tester, {}) }
  let(:validation_error) { "TaskMapper::Provider::Base::valid? method must be implemented by the provider" }
  let(:easy_finder_error) { "TaskMapper::Provider::Helper::easy_finder method must be implemented by the provider" }

  describe TaskMapper::Provider::Base do
    context "when calling #valid? method" do
      subject { lambda { tm.valid? } }
      it { should raise_error(exception, validation_error) }
    end
  end

  describe TaskMapper::Provider::Helper do
    context "when calling #easy_finder" do
      subject { lambda { tm.easy_finder(1, :test, {}) } }
      it { should raise_error(exception, easy_finder_error) }
    end
  end

  describe TaskMapper::Provider::Tester::Project do
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

  describe TaskMapper::Provider::Tester::Ticket do
    let(:ticket) { TaskMapper::Provider::Tester::Ticket.new(1) }
    let(:find_by_id_error) { "TaskMapper::Provider::Tester::Ticket::find_by_id method must be implemented by the provider" }
    let(:find_by_attributes_error) { "TaskMapper::Provider::Tester::Ticket::find_by_attributes method must be implemented by the provider" }
    let(:search_error) { "TaskMapper::Provider::Tester::Ticket::search method must be implemented by the provider" }
    let(:create_error) { "TaskMapper::Provider::Tester::Ticket::create method must be implemented by the provider" }
    let(:save_error) { "TaskMapper::Provider::Tester::Ticket::save method must be implemented by the provider" }
    let(:destroy_error) { "TaskMapper::Provider::Tester::Ticket::destroy method must be implemented by the provider" }
    let(:close_error) { "TaskMapper::Provider::Tester::Ticket::close method must be implemented by the provider" }
    let(:reload_error) { "TaskMapper::Provider::Tester::Ticket::reload! method must be implemented by the provider" }

    context "when #find_by_id" do
      subject { lambda { tm.tickets(:id => 22) } }
      it { should raise_error(exception, find_by_id_error) }
    end

    context "when #find_by_attributes" do
      subject { lambda { tm.ticket.find(1, :all, :title => 'Test ticket') } }
      it { should raise_error(exception, find_by_attributes_error) }
    end

    context "when #search" do
      subject { lambda { tm.ticket.search :tag => 'testing' } }
      it { should raise_error(exception, search_error) }
    end

    context "when #create" do
      subject { lambda { tm.ticket.create :name => 'Foo Bar' } }
      it { should raise_error(exception, create_error) }
    end

    context "when #save" do
      subject { lambda { ticket.save } }
      it { should raise_error(exception, save_error) }
    end

    context "when #destroy" do
      subject { lambda { ticket.destroy } }
      it { should raise_error(exception, destroy_error) }
    end

    context "when #close" do
      subject { lambda { ticket.close } }
      it { should raise_error(exception, close_error) }
    end

    context "when #reload!" do
      subject { lambda { ticket.reload! } }
      it { should raise_error(exception, reload_error) }
    end
  end

  describe TaskMapper::Provider::Tester::Comment do
    let(:ticket_with_comments) { TaskMapper::Provider::Tester::Ticket.new(1) }
    let(:comment) { TaskMapper::Provider::Tester::Comment.new(1, 1) }
    let(:find_by_id_error) { "TaskMapper::Provider::Tester::Comment::find_by_id method must be implemented by the provider" }
    let(:find_by_attributes_error) { "TaskMapper::Provider::Tester::Comment::find_by_attributes method must be implemented by the provider" }
    let(:search_error) { "TaskMapper::Provider::Tester::Comment::search method must be implemented by the provider" }
    let(:create_error) { "TaskMapper::Provider::Tester::Comment::create method must be implemented by the provider" }
    let(:save_error) { "TaskMapper::Provider::Tester::Comment::save method must be implemented by the provider" }
    let(:destroy_error) { "TaskMapper::Provider::Tester::Comment::destroy method must be implemented by the provider" }

    context "when #find_by_id" do
      subject { lambda { ticket_with_comments.comment.find(1,1,[1,2]) } }
      it { should raise_error(exception, find_by_id_error) }
    end

    context "when #find_by_attributes" do
      subject { lambda { ticket_with_comments.comment.find(1, 1, :all, :tag => 'tag') } }
      it { should raise_error(exception, find_by_attributes_error) }
    end

    context "when #search" do
      subject { lambda { ticket_with_comments.comment.search(1, 1, :tag => 'testing') } }
      it { should raise_error(exception, search_error) }
    end

    context "when #create" do
      subject { lambda { ticket_with_comments.comment.create :name => 'Foo Bar' } }
      it { should raise_error(exception, create_error) }
    end

    context "when #save" do
      subject { lambda { comment.save } }
      it { should raise_error(exception, save_error) }
    end

    context "when #destroy" do
      subject { lambda { comment.destroy } }
      it { should raise_error(exception, destroy_error) }
    end
  end
end

