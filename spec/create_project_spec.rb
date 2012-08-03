require 'spec_helper'

module TaskMapper::Providers::NotImplemented
  module Projects; end
  module Tasks; end
end

describe "Create a new Project" do
  let(:tm) do
    TaskMapper.new :inmemory, :user => 'omar', :password => '1234'
  end
  
  context "When I create a project with valid attributes" do
    let(:attributes) {{ 
      :name         => 'test', 
      :description  => 'this is a test' 
    }}
    
    describe :project do
      subject { tm.project! attributes }
      
      its(:id)            { should == 1 }
      its(:name)          { should == 'test' }
      its(:description)   { should == 'this is a test'}
      its(:created_at)    { should be_a Time }
      its(:updated_at)    { should be_a Time }
      it { should satisfy { |p| p.tasks.project.id == 1 } }
    end
    
    context "Given the provider does not implement create method in Projects" do
      let(:tm) { TaskMapper.new :not_implemented }
      let(:error) { catch_error(TaskMapper::Exceptions::ImplementationNotFound) { tm.project! attributes } }
      
      describe :error do
        subject { error }
        it { should_not be_nil }
        its(:message) { should match /Provider TaskMapper::Providers::NotImplemented does not define Projects#create\(Hash\)/i }
      end
    end
  end
  
  context "When I create a project with nil name" do
    let(:attributes) {{ :name => nil }}
    let(:error) { catch_error(TaskMapper::Exceptions::RequiredAttribute) { tm.project! attributes } }
     
    describe :error do
      subject { error }
      it { should_not be_nil }
      its(:message) { should match /Project name is required/ }
    end
  end
end
