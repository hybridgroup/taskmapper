require 'spec_helper'

describe "Search Tasks" do
  let(:tm) do
    TaskMapper.new :in_memory, :user => 'mark', :password => 'twain'
  end
  
  context "Given the project 'Secret Project'" do
    let(:secret_project) { tm.project! :name => 'Plan to kill Justin Bieber' }
    
    context "Given Secret Project have the following tasks" do
      before do
        secret_project.task!  :title        => "Buy bomb materias",
                              :description  => "Go to hardware store",
                              :requestor    => "Ludwig van Beethoven"
                               
        secret_project.task!  :title        => "Contruct a bomb",
                              :description  => "Visit howstuffworks.com",
                              :requestor    => "Ludwig van Beethoven"
                                
        secret_project.task!  :title        => "Install the bomb in Justin Bieber's house",
                              :description  => "Go there and do it",
                              :requestor    => "Ludwig van Beethoven"
                              
        secret_project.task!  :title        => "Detonate bomb with remote controller",
                              :description  => "Save the world",
                              :requestor    => "Ludwig van Beethoven"
      end
      
      context "Retrieve Secret Project's tasks'" do
        subject { secret_project.tasks }
        its(:count) { should == 4 }
        
        describe :second do
          subject { secret_project.tasks[1] }
          its(:id)          { should == 2 }
          its(:title)       { should == "Contruct a bomb" }
          its(:description) { should == "Visit howstuffworks.com" }
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
