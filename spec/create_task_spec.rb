require 'spec_helper'

describe "Create Task" do
  context "Given Project X" do
    let(:tm) { TaskMapper.new :in_memory, 
      :user => 'chuck', :password => 'norris' }
    
    let(:project) { tm.project! :name => 'Project X' }
    
    let(:task) { project.task! attributes }
    
    context "When I create a task for Project X" do
      let(:attributes) {{
        :title => 'Test Task',
        :description => 'This is a test',
        :requestor => 'Ron Evans',
        :assignee => 'Omar Rodriguez',
      }}
      
      subject { task }
      
      its(:id)          { should == 1 }
      its(:title)       { should == 'Test Task' }
      its(:description) { should == 'This is a test'; }
      its(:requestor)   { should == 'Ron Evans' }
      its(:assignee)    { should == 'Omar Rodriguez' }
      
      describe :project_name do
        subject { task.project.name }
        it { should == 'Project X' }
      end
      
      describe :comments_project_id do
        subject { task.comments.task.title }
        it { should == 'Test Task' }
      end
    end
  end
end
