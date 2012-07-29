require 'spec_helper'

describe TaskMapper::Entities::Task do
  before do
    @attributes = { 
      :status       => :new,
      :priority     => 2,
      :title        => 'testing',
      :description  => 'more testing',
      :assignee     => 'Omar',
      :requestor    => 'Ron',
      :closed       => true,
      :resolution   => "my resolution",
      :project      => :dummy_project,
      :comments     => :dummy_comments 
    }
    @task = described_class.new @attributes 
  end

  it "should initialize with valid attributes" do
    @task.status.should == :new
    @task.priority.should == 2
    @task.title.should == 'testing'
    @task.description.should == 'more testing'
    @task.assignee.should == 'Omar'
    @task.requestor.should == 'Ron'
    @task.closed.should be_true
    @task.resolution.should == 'my resolution'
    @task.project.should == :dummy_project
  end
  
  it "should be convertible to a hash" do
    @task.to_hash.should == @attributes
  end
  
  it "should not allow nil title" do
    lambda {
      @task.title = nil
    }.should raise_error TaskMapper::Exceptions::RequiredAttribute, 
      /Attribute 'title' is required/
  end
  
  it "should not allow empty title" do
    lambda {
      @task.title = ''
    }.should raise_error TaskMapper::Exceptions::RequiredAttribute, 
      /Attribute 'title' is required/
  end
  
  it "should not allow empty requestor" do
    lambda {
      @task.requestor = ''
    }.should raise_error TaskMapper::Exceptions::RequiredAttribute, 
      /Attribute 'requestor' is required/
  end
  
  describe :defaults do
    before :each do
      @task = described_class.new :title => 'test', 
        :requestor => 'mario'
    end 
     
    it "should have default status new" do
      @task.status.should == :new
    end

    it "should have default priority 1" do
      @task.priority.should == 1
    end
  end
end

