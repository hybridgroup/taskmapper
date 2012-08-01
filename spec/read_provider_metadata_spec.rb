require 'spec_helper'

describe "Read Provider metadata" do
  let(:tm) { TaskMapper.new :in_memory, { :user => 'foo', :password => 'bar' } } 
  
  context "Retrieve operations" do
    subject { tm.metadata }
    its(:operations) { should == {
      :projects => [:create, :search, :find],
      :tasks    => [:create, :search, :find]
    }}
  end
  
  context "Support create projects?" do
    subject { tm.support? :create, :projects }
    it { should be_true }
  end
  
  context "Support find projects?" do
    subject { tm.support? :find, :projects }
    it { should be_true }
  end
  
  context "Support delete tasks" do
    subject { tm.support? :delete, :tasks }
    it { should_not be_true }
  end
end
