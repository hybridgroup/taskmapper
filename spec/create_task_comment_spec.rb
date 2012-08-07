require 'spec_helper'

describe "Create a task comment" do
  let(:tm) { TaskMapper.new :in_memory,
      :user => 'chuck', :password => 'norris' }

  pending "Given Project X" do
    let(:project_x) { tm.create_project :name => 'Project X' }
    
    context "Given Task X" do
      let(:task_x) { project.create_task  :title      => "Task X",
                                      :requestor  => "Omar" }
                                      
      context "When I create a task comment on Task X" do
        let(:comment) do 
          task_x.create_comment :body   => "This is a test",
                                :author => "Magoo"
        end
        
        describe :comment do
          subject { task_x_comment }
          
          its(:body)    { should eql "This is a test" }
          its(:author)  { should eql "Magoo" }
          its(:task_id) { should eql task_x.id }
        end
        
        describe :task_x do
          subject { task_x }
          its(:comments_count) { should == 1 }
        end        
      end
    end
  end
end
