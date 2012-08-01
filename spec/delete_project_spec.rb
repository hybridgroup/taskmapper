require 'spec_helper'

describe "Delete project" do 
  let(:client) do 
    TaskMapper::Client.new :inmemory, :user => 'omar', :password => '1234'
  end
<<<<<<< HEAD
=======
  let(:project) { client.project! :name => 'Awesome Project', :description => 'Awesome' }
>>>>>>> This spec implementation is wrong

  context "Given the backend has 2 projects" do 
    it "Delete a project from the collection of projects" do 
      client.projects << project
      client.projects.should have(1).items

    end
<<<<<<< HEAD

    subject { projects } 
    it { should have(2).items }

    describe :delete do 
      context "Given a project id" do 
        let(:project) { projects.first }
        subject { projects.delete project }
        it { should be_true }
      end
    end
=======
>>>>>>> This spec implementation is wrong
  end
end

