require 'spec_helper'

module TaskMapper::Providers::NoMetaData
  module Projects; end
  module Tasks; end
  module Comments; end
end

describe "Read Provider metadata" do
  context "Given a provider with metadata available" do
    let(:tm) { TaskMapper.new :in_memory, { :user => 'foo', :password => 'bar' } } 
    
    context "Retrieve operations" do
      subject { tm.metadata }
      its(:operations) { should == {
        :projects => [:create, :search, :find],
        :tasks    => [:create, :search, :find]
      }}
      
      pending "metadata for comments"
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
  
  context "Given a provider without metadata" do
    let(:tm) { TaskMapper.new :no_metadata, { :user => 'foo', :password => 'bar' } } 
    
    context "Retrieve operations" do
      subject { tm.metadata }
      its(:operations) { should == {
        :projects => [:no_metadata_available],
        :tasks => [:no_metadata_available]
      }}
      
      pending "metadata for comments"
    end
  end
end
