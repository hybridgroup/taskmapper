require 'spec_helper'

describe "Create Task" do
  subject { created_task }
  
  let(:attributes) {{
    :title => 'Test Task',
    :description => 'This is a test',
    :requestor => 'Ron Evans',
    :assignee => 'Omar Rodriguez',
  }}
  
  let(:project) { project_class.new :id => 1, 
    :name => 'Test Project', 
    :tasks => tasks }
  let(:project_class) { TaskMapper::Entities::Project }
  
  let(:tasks) { tasks_class.new :provider => tasks_provider }
  let(:tasks_class) { TaskMapper::Repository }
  let(:tasks_provider) { double :tasks_provider }
  
  let(:created_task) { project.task! attributes }
  
  before { tasks_provider.should_receive(:create)
    .with(attributes.merge :project => project)
    .and_return 100 }
  
  pending do
    its(:id) { should == 100 }
    
    its(:title) { should == "Test Task" }
    
    its(:description) { should == "This is a test" }
    
    its(:requestor) { should == "Ron Evans" }
    
    its(:assignee) { should == "Omar Rodriguez" }
  end
end
