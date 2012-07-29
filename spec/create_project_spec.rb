require 'spec_helper'

describe "Create a new Project" do
  let(:client) do
    TaskMapper::Client.new :kanbanpad, 
      { :user => 'foo', :password => 'bar' },
      :projects_provider => projects_provider
  end
  
  let(:created_project) do 
    client.project! attributes
  end
  
  let(:projects_provider) { double :projects_provider }
  
  context "Given valid project attributes" do
    let(:attributes) {{ :name => 'test', :description => 'this is a test' }}
    
    context "Given backend saves successfully" do
      
      describe :created_project do
        subject { created_project }
        
        before do
          projects_provider.should_receive(:create)
            .with(:name => 'test', :description => 'this is a test')
            .and_return 1
        end
        
        its(:id) { should == 1 }
        its(:name) { should == 'test' }
        its(:description) { should == 'this is a test'}
        pending "test tasks"
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
