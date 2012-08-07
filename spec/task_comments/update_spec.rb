require 'spec_helper'

describe "Update a task comment" do
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
    
    context "And 'Task X' have a comment" do
      before(:all) do 
        comment = task.create_comment :body => "Comment #1",
                                      :author => "Omar"
        comment.instance_eval do
          updated_at = Time.new 1984, 2, 20
        end
      end
      
      context "When I update the comment body" do
        before(:all) do
          comment = task.comments.first
          comment.body = "Updated Comment"
          @result = comment.save
        end
        
        describe :result do
          subject { @result }
          it { should be_true }
        end
        
        describe :comment do
          let(:comment) { task.comments.find 1 }
          subject { comment }
          
          its(:body) { should == "Updated Comment" }
          
          describe(:updated_at) do
            subject { comment.updated_at }
            its(:day) { should == Time.now.day }
          end
        end
      end
    end
  end  
end
