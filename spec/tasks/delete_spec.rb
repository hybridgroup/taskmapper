require 'spec_helper'

describe "Delete a Task" do
  let(:tm) { TaskMapper.new :in_memory, :user => "omar", :password => 1234 }
  
  context "Delete a task" do
    context "Given Project X" do
      let(:project_x) { tm.project! :name => "Project X"  }
      
      context "And Project X have Tasks X and Y" do
        before :all do
          project_x.task! :title => "Task X",
                          :requestor => "Me", :status => :open
                                    
          project_x.task! :title => "Task Y",
                          :requestor => "Me", :status => :open
        end
        
        context "When I delete Task X" do
          before :all do
            t = project_x.tasks.first
            t.delete
          end
            
          describe :project_x do
            subject { project_x.tasks }
            its(:count) { should == 1 }
            
            describe :task_x do
              subject { project_x.tasks.find_by_title "Task X"}
              
              it { should be_nil }
            end
          end
        end
      end
    end
  end
end
