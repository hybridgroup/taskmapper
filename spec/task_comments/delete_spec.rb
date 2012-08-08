require 'spec_helper'

describe "Delete a task comment" do
  let(:tm) { TaskMapper.new :in_memory, :user => 'foo', :password => 'bar' }

  context "Given 'Project X' exists and it has 'Task X'" do
    let(:project) { tm.create_project :name => "Project X" }

    let(:task) do
      project.create_task   :title        => "Task X",
                            :description  => "This is task X",
                            :status       => :new,
                            :priority     => 1,
                            :assignee     => "Omar",
                            :requestor    => "Ron",
    end

    context "And 'Task X' have 3 comments" do
      before(:all) do
        task.create_comment :body => "Comment #1",
                            :author => "Omar"

        task.create_comment :body => "Comment #2",
                            :author => "Omar"
                            
        task.create_comment :body => "Comment #3",
                            :author => "Omar"                            
      end
      
      context "When I delete Comment #2" do
        let(:comments) { task.comments }
        
        let(:comment2) { comments.find_by_body 'Comment #2' }
        
        before do
          comment2.delete
        end
        
        describe :task_comments do
          
          subject { comments }
          
          its(:count) { should == 2 }
          
          describe :find_comment2 do
            subject { comments.find_by_body 'Comment #2' }
            it { should be_nil }
          end
        end
      end
    end
  end
end
