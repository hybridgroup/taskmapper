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
    describe "#valid?" do
      it "has a custom exception message" do
        expect{tm.valid?}.to raise_error(exception, validation_error)
      end
    end
  end

  describe TaskMapper::Provider::Helper do
    describe "#easy_finder" do
      it "has a custom exception message" do
        expect {
          tm.easy_finder(1, :test, {})
        }.to raise_error(exception, easy_finder_error)
      end
    end
  end

  describe TaskMapper::Provider::Tester::Project do
    let(:find_by_id_error) { "TaskMapper::Provider::Tester::Project::find_by_id method must be implemented by the provider" }
    let(:find_by_attributes_error) { "TaskMapper::Provider::Tester::Project::find_by_attributes method must be implemented by the provider" }
    let(:search_error) { "TaskMapper::Provider::Tester::Project::search method must be implemented by the provider"}
    let(:create_error) { "TaskMapper::Provider::Tester::Project::create method must be implemented by the provider"}
    let(:save_error) { "TaskMapper::Provider::Tester::Project::save method must be implemented by the provider"}
    let(:destroy_error) { "TaskMapper::Provider::Tester::Project::destroy method must be implemented by the provider" }

    describe "#find_by_id" do
      it "has a custom exception message" do
        expect{tm.project([1])}.to raise_error(exception, find_by_id_error)
      end
    end

    describe "#find_by_attributes" do
      it "has a custom exception message" do
        expect {
          tm.project.find :all, :name => 'Test Project'
        }.to raise_error(exception, find_by_attributes_error)
      end
    end

    describe "#search" do
      it "has a custom exception message" do
        expect {
          tm.project.search :tag => 'testing'
        }.to raise_error(exception, search_error)
      end
    end

    describe "#create" do
      it "has a custom exception message" do
        expect {
          tm.project.create :name => 'Foo Bar'
        }.to raise_error(exception, create_error)
      end
    end

    describe "#save" do
      it "has a custom exception message" do
        pending
        expect{tm.project.save}.to raise_error(exception, save_error)
      end
    end

    describe "#destroy" do
      let(:project) { TaskMapper::Provider::Tester::Project.new }

      it "has a custom exception message" do
        expect{project.destroy}.to raise_error(exception, destroy_error)
      end
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

    describe "#find_by_id" do
      it "has a custom exception message" do
        expect{tm.tickets(:id => 22)}.to raise_error(exception, find_by_id_error)
      end
    end

    describe "#find_by_attributes" do
      it "has a custom exception message" do
        expect {
          tm.ticket.find(1, :all, :title => 'Test ticket')
        }.to raise_error(exception, find_by_attributes_error)
      end
    end

    describe "#search" do
      it "has a custom exception message" do
        expect {
          tm.ticket.search :tag => 'testing'
        }.to raise_error(exception, search_error)
      end
    end

    describe "#create" do
      it "has a custom exception message" do
        expect {
          tm.ticket.create :name => 'Foo Bar'
        }.to raise_error(exception, create_error)
      end
    end

    describe "#save" do
      it "has a custom exception message" do
        expect{ticket.save}.to raise_error(exception, save_error)
      end
    end

    describe "#destroy" do
      it "has a custom exception message" do
        expect{ticket.destroy}.to raise_error(exception, destroy_error)
      end
    end

    describe "#close" do
      it "has a custom exception message" do
        expect{ticket.close}.to raise_error(exception, close_error)
      end
    end

    describe "#reload!" do
      it "has a custom exception message" do
        expect{ticket.reload!}.to raise_error(exception, reload_error)
      end
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

    describe "#find_by_id" do
      it "has a custom exception message" do
        expect {
          ticket_with_comments.comment.find(1,1,[1,2])
        }.to raise_error(exception, find_by_id_error)
      end
    end

    describe "#find_by_attributes" do
      it "has a custom exception message" do
        expect {
          ticket_with_comments.comment.find(1, 1, :all, :tag => 'tag')
        }.to raise_error(exception, find_by_attributes_error)
      end
    end

    describe "#search" do
      it "has a custom exception message" do
        expect {
          ticket_with_comments.comment.search(1, 1, :tag => 'testing')
        }.to raise_error(exception, search_error)
      end
    end

    describe "#create" do
      it "has a custom exception message" do
        expect{
          ticket_with_comments.comment.create :name => 'Foo Bar'
        }.to raise_error(exception, create_error)
      end
    end

    describe "#save" do
      it "has a custom exception message" do
        expect{comment.save}.to raise_error(exception, save_error)
      end
    end

    describe "#destroy" do
      it "has a custom exception message" do
        expect{comment.destroy}.to raise_error(exception, destroy_error)
      end
    end
  end
end

