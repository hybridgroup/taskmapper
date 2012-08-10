require 'spec_helper'

describe "Create a task comment" do
  let(:tm) { TaskMapper.new :in_memory,
      :user => 'chuck', :password => 'norris' }

  context "Given Project X" do
    let(:project_x) { tm.create_project :name => 'Project X' }
    
    context "Given Task X" do
      let(:task_x) { project_x.create_task  :title      => "Task X",
                                            :requestor  => "Omar", 
                                            :status => :open,
                                            :priority => 1 }
      context "Given valid attributes" do
        context "When I create a task comment on Task X" do
          before :all do 
            task_x.create_comment :body   => "This is a test", :author => "Magoo"
          end
          
          describe :task_x do
            subject { task_x }
            
            its(:comments_count) { should == 1 }
            
            describe :first_comment do
              let(:comment) { task_x.comments.first }
              subject { comment }
              
              its(:body)    { should eql "This is a test" }
              its(:author)  { should eql "Magoo" }
              
              describe :task do
                subject { comment.task }
                its(:id) { should == task_x.id }
              end
            end
          end        
        end
      end
      
      context "Invalid attributes" do
        context "When I create a task comment with nil body" do
          let(:error) do 
            catch_error(TaskMapper::Exceptions::RequiredAttribute) do 
              task_x.create_comment :body => nil, :author => 'Omar'
            end
          end
           
          describe :error do
            subject { error }
            it { should_not be_nil }
            its(:message) { should match /TaskComment body is required/ }
          end
        end
        
        context "When I create a task comment with empty body" do
          let(:error) do 
            catch_error(TaskMapper::Exceptions::RequiredAttribute) do 
              task_x.create_comment :body => '', :author => 'Omar'
            end
          end
           
          describe :error do
            subject { error }
            it { should_not be_nil }
            its(:message) { should match /TaskComment body is required/ }
          end
        end
        
        context "When I create a task comment with nil author" do
          let(:error) do 
            catch_error(TaskMapper::Exceptions::RequiredAttribute) do 
              task_x.create_comment :body => 'test', :author => nil
            end
          end
           
          describe :error do
            subject { error }
            it { should_not be_nil }
            its(:message) { should match /TaskComment author is required/ }
          end
        end
        
        context "When I create a task comment with empty author" do
          let(:error) do 
            catch_error(TaskMapper::Exceptions::RequiredAttribute) do 
              task_x.create_comment :body => 'test', :author => ''
            end
          end
           
          describe :error do
            subject { error }
            it { should_not be_nil }
            its(:message) { should match /TaskComment author is required/ }
          end
        end
      end
    end
  end
end
