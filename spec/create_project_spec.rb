require 'spec_helper'

describe "Create a new Project" do
  let(:client) do
    TaskMapper::Client.new :kanbanpad, 
      {:user => 'omar', :password => '1234'}, factory
  end
  
  let(:factory) { TaskMapper::Factory.new :kanbanpad, 
    { :user => 'omar', :password => '1234' }, 
    :projects_provider => projects_provider,
    :tasks_provider => tasks_provider }
  
  let(:projects_provider) { mock :projects_provider }
  let(:tasks_provider) { mock :tasks_provider }
  
  let(:created_project) do 
    client.project! attributes
  end
  
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
