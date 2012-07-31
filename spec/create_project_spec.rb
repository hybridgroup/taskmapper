require 'spec_helper'

module TaskMapper
  module Providers
    module Kanbanpad
      module Projects
        include InMemoryProvider
      end
      
      module Tasks
        include InMemoryProvider
      end
    end
  end
end

describe "Create a new Project" do
  
  let(:client) do
    TaskMapper::Client.new :kanbanpad, :user => 'omar', :password => '1234'
  end
  
  let(:created_project) { client.project! attributes }
  
  context "Given valid project attributes" do
    let(:attributes) {{ :name => 'test', :description => 'this is a test' }}
    
    context "Given backend saves successfully" do
      describe :created_project do
        subject { created_project }
        
        its(:id) { should == 1 }
        its(:name) { should == 'test' }
        its(:description) { should == 'this is a test'}
        
        describe :tasks do
          subject { created_project.tasks }
          its(:criteria) { should == { :project => created_project } }
        end
      end   
    end
  end
  
  context "Given project name is nil" do
    let(:attributes) {{ :name => nil }}
    let(:error) { catch_error { created_project } }
     
    describe :error do
      subject { error }
      it { should_not be_nil }
      its(:message) { should match /Project name is required/ }
    end
  end
end
