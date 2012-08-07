require 'spec_helper'

describe "Create Task" do
  context "Given Project X" do
    let(:tm) { TaskMapper.new :in_memory, 
      :user => 'chuck', :password => 'norris' }
    
    let(:project) { tm.create_project :name => 'Project X' }
    
    let(:task) { project.create_task attributes }

    describe :task! do 
      subject { project }
      it { should respond_to :task! }
    end

    context "When I create a task for Project X" do
      let(:attributes) {{
        :title        => 'Test Task',
        :description  => 'This is a test',
        :requestor    => 'Ron Evans',
        :assignee     => 'Omar Rodriguez',
      }}
      
      describe :task do
        subject { task }
        
        its(:id)          { should == 1 }
        its(:title)       { should == 'Test Task' }
        its(:description) { should == 'This is a test'; }
        its(:requestor)   { should == 'Ron Evans' }
        its(:assignee)    { should == 'Omar Rodriguez' }
        its(:project_id)  { should == 1 }
      end
    end
    
    context "When I create a project with nil name" do
      let(:attributes) {{ :title => nil, :requestor => 'Ron' }}
      let(:error) { catch_error(TaskMapper::Exceptions::RequiredAttribute) { task } }
       
      describe :error do
        subject { error }
        it { should_not be_nil }
        its(:message) { should match /Task title is required/ }
      end
    end
    
    context "When I create a project with nil requestor" do
      let(:attributes) {{ :title => "test" }}
      let(:error) { catch_error(TaskMapper::Exceptions::RequiredAttribute) { task } }
       
      describe :error do
        subject { error }
        it { should_not be_nil }
        its(:message) { should match /Task requestor is required/ }
      end
    end
  end
end
