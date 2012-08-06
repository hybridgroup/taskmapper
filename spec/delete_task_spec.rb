require 'spec_helper'

describe "Delete a Task" do
  let(:tm) { TaskMapper.new :in_memory, :user => "omar", :password => 1234 }
  
  pending "Delete a task" do
    context "Given Project X with Task X and Y" do
      let(:project_x) { tm.project! :name => "Project X"  }
      before :all do
        @task_x = project_x.task! :title => "Task X",
                                  :requestor => "Me"
                                  
        project_x.task! :title => "Task Y",
                        :requestor => "Me"
      end
      
      context "When I delete Task X" do
        context "Using Task@delete" do
          let(:result) { @task_x.delete  }
          
          describe :result do
            subject { result }
            it { should be_true }
          end
          
          describe :project_x do
            subject { project_x.task_count }
            its(:task_count) { should == 1 }
            
            describe :task_x do
              subject { project_x.tasks.find_by_name "Task X"}
              
              it { should be_nil }
            end
          end
        end
      end
    end
  end
end
