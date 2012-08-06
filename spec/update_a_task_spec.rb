require 'spec_helper'

describe "Update a Task" do
  let(:tm) { TaskMapper.new :in_memory, :user => 'foo', :password => 'bar' }
  
  context "Given Project X exists and it has the Task X" do
    let(:project_x) { tm.create_project :name => "Project X" }
    let(:task_x) do 
      project_x.create_task :title        => "Task X",
                            :description  => "This is task X",
                            :status       => :new,
                            :priority     => 1,
                            :assignee     => "Omar",
                            :requestor    => "Ron",
    end
    
    pending "When I updated Task X with valid values" do
      before do
        task_x.update_attributes  :title        => "Task X.1",
                                  :description  => "This is task X.1",
                                  :status       => :in_progress,
                                  :priority     => 2,
                                  :assignee     => "Rafa"
      end
      
      describe :update? do
        subject { task_x.save }
        it { should be_true }
      end
      
      context "When I read again Task X" do
        before { task_x = project.tasks.find_by_name "Task X" }
        
        describe :task_x do
          subject { task_x }
          its(:title)       { should == "Task X.1" }
          its(:description) { should == "This is task X.1" }
          its(:status)      { should == :in_progress }
          its(:priority)    { should == 2 }
          its(:assignee)    { should == "Rafa" }
        end
      end
    end
  end
end
