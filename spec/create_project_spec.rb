require 'spec_helper'

describe "Create a new Project" do
  let(:client) do
    TaskMapper::Client.new :inmemory, :user => 'omar', :password => '1234'
  end
  
  context "Given valid project attributes" do
    let(:attributes) {{ :name => 'test', :description => 'this is a test' }}
    
    describe :project do
      subject { client.project! attributes }
      
      its(:id) { should == 1 }
      its(:name) { should == 'test' }
      its(:description) { should == 'this is a test'}
      its(:created_at) { should be_a Time }
      its(:updated_at) { should be_a Time }
      it { should satisfy { |p| p.tasks.project_id == 1 } }
    end   
  end
  
  context "Given project name is nil" do
    let(:attributes) {{ :name => nil }}
    let(:error) { catch_error { client.project! attributes } }
     
    describe :error do
      subject { error }
      it { should_not be_nil }
      its(:message) { should match /Project name is required/ }
    end
  end
end
