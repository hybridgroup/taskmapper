require 'spec_helper'

describe "Search Tasks" do
  let(:tm) do
    TaskMapper.new :in_memory, :user => 'mark', :password => 'twain'
  end

  context "Given the following projects" do
    let(:secret_project) { tm.project! :name => 'Plan to kill Justin Bieber' }

    let(:learn_ukulele) { tm.project! :name => 'Leard to play ukulele' }

    context "Given the following tasks" do
      before do
        secret_project.create_task  :title => "Buy bomb materias",
          :description  => "Go to hardware store", :priority => 1, 
          :requestor    => "Ludwig van Beethoven", :status => :open

        secret_project.create_task  :title => "Contruct a bomb",
          :description  => "Visit howstuffworks.com", :priority => 1, 
          :requestor    => "Ludwig van Beethoven", :status => :open

        secret_project.create_task  :title => "Install the bomb in Justin Bieber's house",
          :description  => "Go there and do it", :priority => 1, 
          :requestor    => "Ludwig van Beethoven", :status => :open

        secret_project.create_task  :title => "Detonate bomb with remote controller",
          :description  => "Save the world", :priority => 1, 
          :requestor    => "Ludwig van Beethoven", :status => :open

        learn_ukulele.create_task :title  =>  "Buy Ukulele", :priority => 1, 
          :requestor  =>  "Me", :status => :open

        learn_ukulele.create_task :title =>  "Buy Ukulele book", :priority => 1, 
          :requestor  =>  "Me", :status => :open

        learn_ukulele.create_task :title =>  "Practice hard", :priority => 1, 
          :requestor  =>  "Me", :status => :open
      end

      context "Retrieve all tasks" do
        subject { tm.tasks }

        its(:count) { should == 7 }
      end

      context "Retrieve Plan to kill Justin Bieber' project tasks" do
        subject { secret_project.tasks }
        its(:count) { should == 4 }

        describe :second do
          subject { secret_project.tasks[1] }
          its(:id)          { should == 2 }
          its(:title)       { should == "Contruct a bomb" }
          its(:description) { should == "Visit howstuffworks.com" }
          its(:status)      { should == :open }
          its(:priority)    { should == 1 }
        end

        describe :fourth do
          subject { secret_project.tasks[3] }
          its(:id)          { should == 4 }
          its(:title)       { should == "Detonate bomb with remote controller" }
          its(:description) { should == "Save the world" }
          its(:requestor)   { should == "Ludwig van Beethoven" }
        end
      end
    end
  end
end
